extends Node
var multiplayer_peer = WebSocketMultiplayerPeer.new();
var serverSettings = preload("res://ServerSettings.tres");

var playerStates = {}
@onready var playerContainerScene = preload("res://player_container.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	var error;
	if serverSettings.cert && !serverSettings.dev:
		error = multiplayer_peer.create_server(serverSettings.port,"*",TLSOptions.server(serverSettings.key,serverSettings.cert));
	else: 
		error = multiplayer_peer.create_server(serverSettings.port,"*");
	if error:
		print("Error creating server : "+ str(error))
		
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)

	multiplayer.set_multiplayer_peer(multiplayer_peer);
	print("Server Started! Waiting for players");

func PlayerConnected(id: int):
	# Replicate Hierarchy in server
	var playerContainer = playerContainerScene.instantiate();
	playerContainer.name = str(id);
	add_child(playerContainer,true);
	print("Player Connected: "+ str(id))
	
func PlayerDisconnected(id: int):
	# Remove it from the list
	playerStates.erase(id);
	# Remove from local hierarchy
	get_node(str(id)).queue_free();
	print("Player Disconnected: "+ str(id))

# Player sends information to the server
@rpc("any_peer","unreliable_ordered")
func SendPlayerState(playerState):
	var playerId = multiplayer.get_remote_sender_id();
	playerState = Player_data.decode(playerState)

	if playerStates.has(playerId):
		if playerStates[playerId].T < playerState.T:
			playerStates[playerId] = playerState;
	else:
		playerStates[playerId] = playerState;

#Send Back data from server to client
@rpc("authority","unreliable_ordered")
func ReceiveWorldState(_playerState):
	pass;
	
@rpc("any_peer")
func RequestServerTime(clientTime):
	var playerId = multiplayer.get_remote_sender_id();
	ReceiveServerTime.rpc_id(playerId,Time.get_unix_time_from_system(), clientTime)

@rpc("authority")
func ReceiveServerTime(_serverTime, _initialClientTime):
	pass
	
@rpc("any_peer")
func RequestDetermineLatency(clientTime):
	var playerId = multiplayer.get_remote_sender_id();
	ReceiveDetermineLatency.rpc_id(playerId, clientTime);
	
@rpc("authority")
func ReceiveDetermineLatency(_initialClientTime):
	pass

func _on_timer_timeout():
	var processedWorldState = WorldStateProcess.ProcessWorldState(playerStates);
	ReceiveWorldState.rpc(processedWorldState);

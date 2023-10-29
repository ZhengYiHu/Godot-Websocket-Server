class_name Player_data;

var T = 0.0 # Time when the packet is sent
var P = Vector3.ZERO # Position of the player
var R =  Vector3.ZERO # Roation of the player

func _init(time, position, rotation):
	T = time;
	P = position;
	R = rotation;

# get a data structure to minimize the amount of data sent
func encode():
	var payload = {
		'T' : T,
		'P' : P,
		'R' : R
	};
	return var_to_bytes(payload);

static func decode(bytes):
	bytes = bytes_to_var(bytes);
	return Player_data.new(bytes['T'],bytes['P'],bytes['R']);

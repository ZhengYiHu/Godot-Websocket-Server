extends Node

var worldState = {}

func ProcessWorldState(playerStates : Dictionary):
	worldState = playerStates.duplicate(true);
	worldState = World_data.new(Time.get_unix_time_from_system(),worldState).encode();
	return worldState;

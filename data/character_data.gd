class_name CharacterData
extends Resource

enum Faction {
	TOWN,
	SABOTEUR,
	NEUTRAL
}

enum State {
	FREE,
	IMPRISONED,
	EXILED
}

@export var character_name : String
@export var role_name : String
@export var faction : Faction

var state : State = State.FREE

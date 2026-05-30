class_name CharacterData
extends Resource

enum Faction {
	TOWN,
	SABOTEUR
}

enum State {
	FREE,
	EXILED
}

enum Role {
	NAIVE,
	COUNSELOR,
	LIBRARIAN,
	INFILTRATOR
}

@export var real_role : Role
@export var visible_role : Role
@export var faction : Faction

var state : State = State.FREE
var board_position : Vector2i


func get_role_name() -> String:
	match visible_role:
		Role.NAIVE:
			return "Ingenuo"
		Role.COUNSELOR:
			return "Consejero"
		Role.LIBRARIAN:
			return "Bibliotecario"
		Role.INFILTRATOR:
			return "Infiltrado"
	
	return "Desconocido"


func get_real_role_name() -> String:
	match real_role:
		Role.NAIVE:
			return "Ingenuo"
		Role.COUNSELOR:
			return "Consejero"
		Role.LIBRARIAN:
			return "Bibliotecario"
		Role.INFILTRATOR:
			return "Infiltrado"

	return "Desconocido"

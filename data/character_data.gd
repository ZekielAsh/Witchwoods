class_name CharacterData
extends Resource

enum Faction {TOWN, SABOTEUR}
enum State {FREE, EXILED}
enum Role {
	NAIVE,
	COUNSELOR,
	LIBRARIAN,
	CHRONICLER,
	INVESTIGATOR,
	ORACLE,
	JUDGE,
	MIME,
	INFILTRATOR,
	ACTOR
}

@export var real_role : Role
@export var visible_role : Role
@export var faction : Faction

var state : State = State.FREE
var board_position : Vector2i
var statement : String
var character_id : int

func get_role_name() -> String:
	match visible_role:
		Role.NAIVE: 		return "Ingenuo"
		Role.COUNSELOR: 	return "Consejero"
		Role.LIBRARIAN: 	return "Bibliotecario"
		Role.CHRONICLER: 	return "Cronista"
		Role.INVESTIGATOR: 	return "Investigador"
		Role.ORACLE: 		return "Oráculo"
		Role.JUDGE: 		return "Juez"
		Role.MIME: 			return "Mimo"
		Role.INFILTRATOR: 	return "Infiltrado"
		Role.ACTOR: 		return "Actor"
	return "Desconocido"


func get_real_role_name() -> String:
	match real_role:
		Role.NAIVE: 		return "Ingenuo"
		Role.COUNSELOR: 	return "Consejero"
		Role.LIBRARIAN: 	return "Bibliotecario"
		Role.CHRONICLER: 	return "Cronista"
		Role.INVESTIGATOR: 	return "Investigador"
		Role.ORACLE: 		return "Oráculo"
		Role.JUDGE: 		return "Juez"
		Role.MIME: 			return "Mimo"
		Role.INFILTRATOR: 	return "Infiltrado"
		Role.ACTOR: 		return "Actor"
	return "Desconocido"

class_name CharacterData
extends Resource

enum Faction {TOWN, SABOTEUR}
enum State {FREE, EXILED}
enum Role {
	#NAIVE,
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

const ROLE_IMAGES := {
	Role.COUNSELOR: preload("res://assets/textures/cards/counselor.jpg"),
	Role.LIBRARIAN: preload("res://assets/textures/cards/librarian.jpg"),
	Role.CHRONICLER: preload("res://assets/textures/cards/chronicler.jpg"),
	Role.INVESTIGATOR: preload("res://assets/textures/cards/investigator.jpg"),
	Role.ORACLE: preload("res://assets/textures/cards/oracle.jpg"),
	Role.JUDGE: preload("res://assets/textures/cards/judge.jpg"),
	Role.MIME: preload("res://assets/textures/Trapper.jpg"),
	Role.INFILTRATOR: preload("res://assets/textures/cards/infiltrator.jpg"),
	Role.ACTOR: preload("res://assets/textures/cards/actor.jpg")
}

@export var real_role : Role
@export var visible_role : Role
@export var faction : Faction

var state : State = State.FREE
var board_position : Vector2i
var statement : String
var character_id : int

const TOWN_COLOR = Color("69C36B")
const SABOTEUR_COLOR = Color("D35A5A")

func get_role_name() -> String:
	match visible_role:
		#Role.NAIVE: 		return "Ingenuo"
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
		#Role.NAIVE: 		return "Ingenuo"
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

func get_visible_portrait():
	return ROLE_IMAGES[visible_role]

func get_real_portrait():
	return ROLE_IMAGES[real_role]

func get_faction_color() -> Color:
	if faction == Faction.TOWN:
		return TOWN_COLOR
	return SABOTEUR_COLOR

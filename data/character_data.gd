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


func get_information() -> String:
	match visible_role:
		Role.NAIVE:
			if real_role == Role.INFILTRATOR:
				return "No quiero contarte."
			return "Soy un aldeano."
		Role.COUNSELOR:
			if real_role == Role.INFILTRATOR:
				return "Tengo 2 saboteadores cerca."
			return "No percibo saboteadores cercanos."
		Role.LIBRARIAN:
			if real_role == Role.INFILTRATOR:
				return "Existen 2 saboteadores."
			return "Existe 1 saboteador."
		Role.INFILTRATOR:
			return "..."
	return ""

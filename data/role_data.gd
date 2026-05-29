class_name RoleData
extends Resource

enum RoleType {
	NAIVE,
	COUNSELOR,
	LIBRARIAN,
	INFILTRATOR
}

@export var role_name : String
@export_multiline var description : String
@export var faction : CharacterData.Faction

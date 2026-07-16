class_name TutorialData
extends RefCounted

var counselor : CharacterData
var saboteur : CharacterData
var librarian : CharacterData

func initialize(characters : Array[CharacterData]):
	for character in characters:
		match character.real_role:
			CharacterData.Role.COUNSELOR:
				counselor = character
			CharacterData.Role.LIBRARIAN:
				librarian = character
			CharacterData.Role.INFILTRATOR:
				saboteur = character

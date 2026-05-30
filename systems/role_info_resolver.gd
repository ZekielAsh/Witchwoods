class_name RoleInfoResolver
extends Node

@onready var board : BoardManager = $"../BoardManager"


func get_information(character : CharacterData) -> String:
	match character.visible_role:

		CharacterData.Role.NAIVE:
			return resolve_naive(character)

		CharacterData.Role.COUNSELOR:
			return resolve_counselor(character)

		CharacterData.Role.LIBRARIAN:
			return resolve_librarian(character)

		CharacterData.Role.INFILTRATOR:
			return "..."

	return ""


func resolve_naive(character : CharacterData) -> String:
	if character.real_role == CharacterData.Role.INFILTRATOR:
		return "No quiero contarte."

	return "Soy un aldeano."


func resolve_counselor(character : CharacterData) -> String:
	var neighbors = board.get_neighbors(character)

	var saboteur_count := 0

	for neighbor in neighbors:
		if neighbor.faction == CharacterData.Faction.SABOTEUR:
			saboteur_count += 1

	if character.real_role == CharacterData.Role.INFILTRATOR:
		saboteur_count = fake_counselor_value(saboteur_count)

	match saboteur_count:
		0:
			return "No percibo saboteadores cercanos."
		1:
			return "Percibo 1 saboteador cercano."
		_:
			return "Percibo %s saboteadores cercanos." % saboteur_count


func resolve_librarian(character : CharacterData) -> String:
	var total = board.count_faction(
		CharacterData.Faction.SABOTEUR
	)

	if character.real_role == CharacterData.Role.INFILTRATOR:
		total += 1

	if total == 1:
		return "Existe 1 saboteador."

	return "Existen %s saboteadores." % total


func fake_counselor_value(real_value : int) -> int:
	if real_value == 0:
		return 1

	return 0

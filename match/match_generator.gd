class_name MatchGenerator
extends Node

const TOWN_ROLES = [
	CharacterData.Role.NAIVE,
	CharacterData.Role.COUNSELOR,
	CharacterData.Role.LIBRARIAN
]

func generate_match(level : int = 1) -> Array:

	var match := create_random_match(level)

	InformationGenerator.generate(match)

	return match


func create_random_match(level : int) -> Array:

	var characters := []

	var total_characters := get_character_count(level)

	var infiltrator_count := get_infiltrator_count(total_characters)

	var town_count := total_characters - infiltrator_count

	for i in range(town_count):

		var role = TOWN_ROLES.pick_random()

		characters.append(
			make_character(
				role,
				role,
				CharacterData.Faction.TOWN
			)
		)

	for i in range(infiltrator_count):

		var fake_role = TOWN_ROLES.pick_random()

		characters.append(
			make_character(
				CharacterData.Role.INFILTRATOR,
				fake_role,
				CharacterData.Faction.SABOTEUR
			)
		)

	characters.shuffle()

	for i in range(characters.size()):
		characters[i].character_id = i

	assign_positions(characters)

	return characters


func assign_positions(
	characters : Array
) -> void:

	for i in range(characters.size()):

		characters[i].board_position = Vector2i(i, 0)


func get_character_count(level : int) -> int:

	var options = [
		4,
		5,
		6,
		7,
		8
	]

	return options.pick_random()


func get_infiltrator_count(
	character_count : int
) -> int:

	if character_count >= 6:
		return 2

	return 1


func make_character(
	real_role,
	visible_role,
	faction
) -> CharacterData:

	var character = CharacterData.new()

	character.real_role = real_role
	character.visible_role = visible_role
	character.faction = faction

	return character

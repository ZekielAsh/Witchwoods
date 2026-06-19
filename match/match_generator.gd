class_name MatchGenerator
extends Node

const TOWN_ROLES = [
	CharacterData.Role.NAIVE,
	CharacterData.Role.COUNSELOR,
	CharacterData.Role.LIBRARIAN,
	CharacterData.Role.CHRONICLER,
	CharacterData.Role.INVESTIGATOR,
	CharacterData.Role.ORACLE,
	CharacterData.Role.WATCHMAN
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
	
	var available_roles = TOWN_ROLES.duplicate()
	if total_characters < 6: available_roles.erase(CharacterData.Role.WATCHMAN)
	
	for i in range(town_count):
		var role = available_roles.pick_random()
		characters.append(make_character(role, role,CharacterData.Faction.TOWN))
	for i in range(infiltrator_count):
		var fake_role = available_roles.pick_random()
		characters.append(make_character(
			CharacterData.Role.INFILTRATOR, 
			fake_role, 
			CharacterData.Faction.SABOTEUR))
	characters.shuffle()
	for i in range(characters.size()): characters[i].character_id = i + 1
	assign_positions(characters)
	return characters


func assign_positions(characters : Array) -> void:
	var count := characters.size()
	var columns := 4
	match count:
		4: columns = 4
		5: columns = 3
		6: columns = 3
		7: columns = 4
		8: columns = 4

	for i in range(count):

		var x = i % columns
		var y = i / columns

		characters[i].board_position = Vector2i(x, y)


func get_character_count(level : int) -> int:
	var options = [4, 5, 6, 7, 8]
	return options.pick_random()


func get_infiltrator_count(character_count : int) -> int:
	if character_count >= 6: return 2
	return 1


func make_character(real_role, visible_role, faction) -> CharacterData:
	var character = CharacterData.new()
	character.real_role = real_role
	character.visible_role = visible_role
	character.faction = faction
	return character

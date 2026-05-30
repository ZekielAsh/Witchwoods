class_name MatchGenerator
extends Node


func generate_match() -> Array:

	var presets = [
		create_preset_1(),
		create_preset_2(),
		create_preset_3(),
		create_preset_4()
	]

	var selected = presets.pick_random()

	selected.shuffle()

	return selected
	
func create_preset_1() -> Array:
	return [
		make_character(
			CharacterData.Role.NAIVE,
			CharacterData.Role.NAIVE,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.COUNSELOR,
			CharacterData.Role.COUNSELOR,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.LIBRARIAN,
			CharacterData.Role.LIBRARIAN,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.INFILTRATOR,
			CharacterData.Role.COUNSELOR,
			CharacterData.Faction.SABOTEUR
		)
	]
	
func create_preset_2() -> Array:
	return [
		make_character(
			CharacterData.Role.NAIVE,
			CharacterData.Role.NAIVE,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.COUNSELOR,
			CharacterData.Role.COUNSELOR,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.COUNSELOR,
			CharacterData.Role.COUNSELOR,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.INFILTRATOR,
			CharacterData.Role.LIBRARIAN,
			CharacterData.Faction.SABOTEUR
		)
	]
	
func create_preset_3() -> Array:
	return [
		make_character(
			CharacterData.Role.LIBRARIAN,
			CharacterData.Role.LIBRARIAN,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.NAIVE,
			CharacterData.Role.NAIVE,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.NAIVE,
			CharacterData.Role.NAIVE,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.INFILTRATOR,
			CharacterData.Role.COUNSELOR,
			CharacterData.Faction.SABOTEUR
		)
	]
	
func create_preset_4() -> Array:
	return [
		make_character(
			CharacterData.Role.COUNSELOR,
			CharacterData.Role.COUNSELOR,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.LIBRARIAN,
			CharacterData.Role.LIBRARIAN,
			CharacterData.Faction.TOWN
		),

		make_character(
			CharacterData.Role.INFILTRATOR,
			CharacterData.Role.NAIVE,
			CharacterData.Faction.SABOTEUR
		),

		make_character(
			CharacterData.Role.INFILTRATOR,
			CharacterData.Role.COUNSELOR,
			CharacterData.Faction.SABOTEUR
		)
	]
	

func make_character(
	real_role,
	visible_role,
	faction
) -> Dictionary:

	return {
		"real_role": real_role,
		"visible_role": visible_role,
		"faction": faction
	}

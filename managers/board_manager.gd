class_name BoardManager
extends Node

@onready var npc_container = $"../NpcContainer"


func get_all_characters() -> Array[CharacterData]:
	var result : Array[CharacterData] = []

	for card in npc_container.get_children():
		if card.data:
			result.append(card.data)

	return result


func get_character_at(pos : Vector2i) -> CharacterData:
	for character in get_all_characters():
		if character.board_position == pos:
			return character

	return null


func get_neighbors(character : CharacterData) -> Array[CharacterData]:
	var result : Array[CharacterData] = []

	var directions = [
		Vector2i.LEFT,
		Vector2i.RIGHT,
		Vector2i.UP,
		Vector2i.DOWN
	]

	for direction in directions:

		var neighbor = get_character_at(
			character.board_position + direction
		)

		if neighbor:
			result.append(neighbor)

	return result


func count_faction(faction : CharacterData.Faction):

	var total := 0

	for character in get_all_characters():
		if character.faction == faction:
			total += 1

	return total

class_name BoardManager
extends Node

@onready var npc_container = $"../NpcContainer"


func get_all_characters() -> Array[CharacterData]:
	var characters : Array[CharacterData] = []

	for card in npc_container.get_children():
		if card.data:
			characters.append(card.data)

	return characters


func get_character_index(character : CharacterData) -> int:
	var children = npc_container.get_children()

	for i in range(children.size()):
		var card = children[i]

		if card.data == character:
			return i

	return -1


func get_adjacent_characters(character : CharacterData) -> Array[CharacterData]:
	var result : Array[CharacterData] = []

	var children = npc_container.get_children()
	var index = get_character_index(character)

	if index == -1:
		return result

	if index > 0:
		result.append(children[index - 1].data)

	if index < children.size() - 1:
		result.append(children[index + 1].data)

	return result


func count_faction(faction : CharacterData.Faction) -> int:
	var total := 0

	for character in get_all_characters():
		if character.faction == faction:
			total += 1

	return total

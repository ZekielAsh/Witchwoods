class_name BoardManager
extends Node

@onready var npc_container = $"../MarginContainer/NpcContainer"

var card_scene = preload("res://cards/character_card.tscn")
var characters : Array[CharacterData] = []
var board : Dictionary = {}

func build(characters_data : Array[CharacterData]):
	clear_board()

	await get_tree().process_frame

	characters = characters_data
	board.clear()

	for character in characters:
		board[character.board_position] = character

	configure_board_layout(characters.size())

	for character in characters:
		var card : CharacterCard = card_scene.instantiate()
		npc_container.add_child(card)
		card.setup(character)

func get_all_characters() -> Array[CharacterData]:
	return characters

func get_character_at(pos : Vector2i) -> CharacterData:
	return board.get(pos)

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

	for character in characters:
		if character.faction == faction:
			total += 1

	return total

func clear_board():
	characters.clear()
	board.clear()

	for child in npc_container.get_children():
		child.queue_free()

func configure_board_layout(character_count : int):
	match character_count:
		4: npc_container.columns = 4
		6: npc_container.columns = 3
		8: npc_container.columns = 4

func reveal_all_cards():
	for card in npc_container.get_children():
		if card is CharacterCard: card.reveal()

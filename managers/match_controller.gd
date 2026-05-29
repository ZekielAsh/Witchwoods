class_name MatchController
extends Node

@onready var bus : EventBus = $"../EventBus"

var exiled_characters : Array[CharacterData] = []


func exile(character : CharacterData):
	if character.state == CharacterData.State.EXILED:
		return
	character.state = CharacterData.State.EXILED
	exiled_characters.append(character)
	bus.character_exiled.emit(character)
	check_victory()


func check_victory():
	var all_saboteurs_exiled := true
	for character in get_all_characters():
		if character.faction == CharacterData.Faction.SABOTEUR:
			if character.state != CharacterData.State.EXILED:
				all_saboteurs_exiled = false
	if all_saboteurs_exiled:
		bus.game_won.emit()


func get_all_characters() -> Array:
	var npc_container = $"../NpcContainer"
	var characters := []
	for card in npc_container.get_children():
		if card.data:
			characters.append(card.data)
	return characters

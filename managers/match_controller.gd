class_name MatchController
extends Node

@onready var bus : EventBus = $"../EventBus"
@onready var board : BoardManager = $"../BoardManager"

var exiled_characters : Array[CharacterData] = []

func reset():
	exiled_characters.clear()

func exile(character : CharacterData):
	if character.state == CharacterData.State.EXILED:
		return

	character.state = CharacterData.State.EXILED
	exiled_characters.append(character)

	bus.character_exiled.emit(character)

	check_victory()


func check_victory():
	var all_saboteurs_exiled := true

	for character in board.get_all_characters():
		if character.faction == CharacterData.Faction.SABOTEUR:
			if character.state != CharacterData.State.EXILED:
				all_saboteurs_exiled = false

	if all_saboteurs_exiled:
		bus.game_won.emit()

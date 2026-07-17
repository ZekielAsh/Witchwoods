class_name MatchController
extends Node

@onready var bus : EventBus = $"../EventBus"
@onready var board : BoardManager = $"../BoardManager"
@onready var game_manager : GameManager = $"../../GameManager"

var exiled_characters : Array[CharacterData] = []

func reset():
	exiled_characters.clear()

func exile(character : CharacterData):
	if character.state == CharacterData.State.EXILED:
		return

	character.state = CharacterData.State.EXILED
	exiled_characters.append(character)
	
	bus.exile_loop_stopped.emit()
	bus.character_exiled.emit(character)

	check_victory()


func check_victory():
	var all_saboteurs_exiled := true

	for character in board.get_all_characters():
		if character.faction == CharacterData.Faction.SABOTEUR:
			if character.state != CharacterData.State.EXILED:
				all_saboteurs_exiled = false

	if all_saboteurs_exiled:
		if game_manager.current_game_mode == GameManager.GameMode.TUTORIAL:
			return
		bus.game_won.emit()

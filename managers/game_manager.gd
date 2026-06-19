class_name GameManager
extends Node


enum InteractionMode {
	NONE,
	EXILE
}

@onready var npc_container = $MarginContainer/NpcContainer
@onready var character_panel = $CharacterPanel

@onready var bus : EventBus = $EventBus
@onready var match_controller = $MatchController
@onready var match_generator = $MatchGenerator
@onready var end_screen = $"../EndScreen"

var card_scene = preload("res://cards/character_card.tscn")

var current_mode := InteractionMode.NONE


func _ready():
	bus.character_selected.connect(_on_character_selected)
	bus.game_won.connect(_on_game_won)
	bus.game_lost.connect(_on_game_lost)

	create_test_match()
	
	end_screen.retry_requested.connect(_restart_game)


func configure_board_layout(character_count : int):
	match character_count:
		4: npc_container.columns = 4
		5: npc_container.columns = 3
		6: npc_container.columns = 3
		7: npc_container.columns = 4
		8: npc_container.columns = 4


func create_test_match():

	var generated_match = match_generator.generate_match()

	configure_board_layout(
		generated_match.size()
	)

	for character in generated_match:

		var card : CharacterCard = card_scene.instantiate()

		npc_container.add_child(card)

		card.setup(character)

		card.card_selected.connect(
			_on_card_selected
		)

		bus.character_exiled.connect(
			func(exiled_character):

				if exiled_character == card.data:
					card.refresh()
		)


func set_mode(mode):
	current_mode = mode
	bus.interaction_mode_changed.emit(mode)


func clear_mode():
	current_mode = InteractionMode.NONE
	bus.interaction_mode_changed.emit(current_mode)


func _on_card_selected(character : CharacterData):
	bus.character_selected.emit(character)


func _on_character_selected(character : CharacterData):
	match current_mode:
		InteractionMode.NONE:
			character_panel.display_character(character)
		InteractionMode.EXILE:
			match_controller.exile(character)
			character_panel.display_character(character)


func _on_game_won():
	end_screen.show_victory()


func _on_game_lost():
	end_screen.show_defeat()
	
func _restart_game():
	get_tree().reload_current_scene()

class_name GameManager
extends Node


enum InteractionMode {
	NONE,
	EXILE
}

@onready var character_panel = $CharacterPanel

@onready var bus : EventBus = $EventBus
@onready var board = $BoardManager
@onready var match_controller = $MatchController
@onready var match_generator = $MatchGenerator
@onready var end_screen = $"../EndScreen"
@onready var audio = $"../AudioManager"

var current_mode := InteractionMode.NONE
var game_finished := false

func _ready():
	bus.character_selected.connect(_on_character_selected)
	bus.game_won.connect(_on_game_won)
	bus.game_lost.connect(_on_game_lost)
	
	end_screen.retry_requested.connect(_restart_game)
	end_screen.reveal_requested.connect(_on_reveal_requested)
	
func start_game():
	game_finished = false
	set_mode(InteractionMode.NONE)

	match_controller.reset()
	var match = match_generator.generate_match()

	board.build(match)

func set_mode(mode):
	current_mode = mode
	bus.interaction_mode_changed.emit(mode)

func clear_mode():
	current_mode = InteractionMode.NONE
	bus.interaction_mode_changed.emit(current_mode)

func _on_character_selected(character : CharacterData):
	match current_mode:
		InteractionMode.NONE:
			character_panel.display_character(character)
		InteractionMode.EXILE:
			match_controller.exile(character)
			character_panel.display_character(character)

func _on_game_won():
	game_finished = true
	board.reveal_all_cards()
	end_screen.show_victory()

func _on_game_lost():
	game_finished = true
	board.reveal_all_cards()
	end_screen.show_defeat()

func _restart_game():
	end_screen.visible = false
	start_game()

func _on_reveal_requested():
	character_panel.set_reveal_mode()
	end_screen.hide_screen()

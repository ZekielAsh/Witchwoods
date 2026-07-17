class_name GameManager
extends Node


enum GameMode {
	NORMAL,
	TUTORIAL
}

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
@onready var tutorial_dialog = $"../TutorialDialog"
@onready var stability_system = $StabilitySystem

var current_game_mode := GameMode.NORMAL
var current_mode := InteractionMode.NONE
var game_finished := false
var current_match : MatchData
var tutorial_completed := false

func _ready():
	bus.character_selected.connect(_on_character_selected)
	bus.game_won.connect(_on_game_won)
	bus.game_lost.connect(_on_game_lost)
	
	end_screen.retry_requested.connect(_restart_game)
	
	bus.tutorial_show_message.connect(tutorial_dialog.show_message)
	tutorial_dialog.next_pressed.connect(func(): bus.tutorial_next_step.emit())
	
func start_game(mode : GameMode = GameMode.NORMAL):
	bus.new_investigation_started.emit()
	current_game_mode = mode

	game_finished = false
	set_mode(InteractionMode.NONE)

	match_controller.reset()
	stability_system.reset()
	
	var match_data : MatchData
	match current_game_mode:
		GameMode.NORMAL:
			match_data = match_generator.generate_match()
		GameMode.TUTORIAL:
			match_data = match_generator.generate_tutorial_match()

	current_match = match_data
	await board.build(current_match.characters)

	if current_game_mode == GameMode.TUTORIAL:
		bus.tutorial_started.emit(current_match)

func set_mode(mode):
	current_mode = mode
	bus.interaction_mode_changed.emit(mode)

	if mode == InteractionMode.EXILE:
		bus.capture_mode_entered.emit()
		bus.exile_loop_started.emit()

func clear_mode():
	current_mode = InteractionMode.NONE
	bus.interaction_mode_changed.emit(current_mode)

	bus.capture_mode_exited.emit()
	bus.exile_loop_stopped.emit()

func _on_character_selected(character):
	match current_mode:
		InteractionMode.NONE:
			bus.character_inspected.emit(character)
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
	end_screen.from_tutorial = false
	
	if tutorial_completed:
		tutorial_dialog.close()
		bus.tutorial_clear_highlights.emit()
		tutorial_completed = false
	
	start_game(current_game_mode)

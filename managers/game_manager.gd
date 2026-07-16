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
@onready var audio = $"../AudioManager"

var card_scene = preload("res://cards/character_card.tscn")
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

	clear_board()
	match_controller.reset()
	await get_tree().process_frame

	create_test_match()
	
	print("Listeners:", bus.character_exiled.get_connections().size())

func clear_board():
	for child in npc_container.get_children():
		child.queue_free()

func configure_board_layout(character_count : int):
	match character_count:
		4: npc_container.columns = 4
		6: npc_container.columns = 3
		8: npc_container.columns = 4

func create_test_match():
	var generated_match = match_generator.generate_match()
	configure_board_layout(generated_match.size())

	for character in generated_match:
		var card : CharacterCard = card_scene.instantiate()
		npc_container.add_child(card)

		card.setup(character)

func set_mode(mode):
	current_mode = mode
	bus.interaction_mode_changed.emit(mode)

func clear_mode():
	current_mode = InteractionMode.NONE
	bus.interaction_mode_changed.emit(current_mode)

func reveal_all_cards():
	for card in npc_container.get_children():
		if card is CharacterCard: card.reveal()

func _on_character_selected(character : CharacterData):
	match current_mode:
		InteractionMode.NONE:
			character_panel.display_character(character)
		InteractionMode.EXILE:
			match_controller.exile(character)
			character_panel.display_character(character)

func _on_game_won():
	game_finished = true
	reveal_all_cards()
	end_screen.show_victory()

func _on_game_lost():
	game_finished = true
	reveal_all_cards()
	end_screen.show_defeat()

func _restart_game():
	end_screen.visible = false
	start_game()

func _on_reveal_requested():
	character_panel.set_reveal_mode()
	end_screen.hide_screen()

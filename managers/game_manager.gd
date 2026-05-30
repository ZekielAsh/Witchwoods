class_name GameManager
extends Node


enum InteractionMode {
	NONE,
	EXILE
}

@onready var npc_container = $NpcContainer
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

		6: npc_container.columns = 3

		8: npc_container.columns = 4


func assign_positions(characters : Array):
	var count := characters.size()
	var columns := 4
	match count:
		4: columns = 4

		6: columns = 3

		8: columns = 4

	for i in range(count):

		var x = i % columns
		var y = i / columns

		characters[i]["position"] = Vector2i(x, y)


func create_test_match():
	var generated_match = match_generator.generate_match()
	configure_board_layout(generated_match.size())
	assign_positions(generated_match)

	for config in generated_match:
		create_character(
			config.real_role,
			config.visible_role,
			config.faction,
			config.position
		)


func create_character(real_role, visible_role, faction, position : Vector2i):
		
	var data = CharacterData.new()

	data.real_role = real_role
	data.visible_role = visible_role
	data.faction = faction
	data.board_position = position

	var card : CharacterCard = card_scene.instantiate()

	npc_container.add_child(card)

	card.setup(data)

	card.card_selected.connect(
		_on_card_selected
	)

	bus.character_exiled.connect(
		func(character):
			if character == card.data:
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

class_name GameManager
extends Node


enum InteractionMode {
	NONE,
	IMPRISON,
	RELEASE,
	EXILE
}

@onready var npc_container = $NpcContainer
@onready var character_panel = $CharacterPanel

@onready var bus : EventBus = $EventBus
@onready var prison_manager : PrisonManager = $PrisonManager

var card_scene = preload("res://cards/character_card.tscn")

var current_mode := InteractionMode.NONE


func _ready():

	bus.character_selected.connect(_on_character_selected)

	create_test_character(
		"Detective",
		CharacterData.Faction.TOWN
	)

	create_test_character(
		"Cazador",
		CharacterData.Faction.SABOTEUR
	)


func create_test_character(role, faction):
	var data = CharacterData.new()
	data.role_name = role
	data.faction = faction

	var card : CharacterCard = card_scene.instantiate()
	npc_container.add_child(card)
	card.setup(data)
	card.card_selected.connect(_on_card_selected)

	_connect_card_to_bus(card)


func _connect_card_to_bus(card : CharacterCard):

	bus.character_imprisoned.connect(
		func(character):
			if character == card.data:
				card.refresh()
	)

	bus.character_released.connect(
		func(character):
			if character == card.data:
				card.refresh()
	)

	bus.character_exiled.connect(
		func(character):
			if character == card.data:
				card.refresh()
	)


func set_mode(mode : InteractionMode):

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
		InteractionMode.IMPRISON:
			prison_manager.imprison(character)
		InteractionMode.RELEASE:
			prison_manager.release(character)
		InteractionMode.EXILE:
			prison_manager.exile(character)

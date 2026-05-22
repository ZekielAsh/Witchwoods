extends Node

enum InteractionMode {
	NONE,
	IMPRISON,
	RELEASE,
	EXILE
}

@onready var npc_container = $"../NpcContainer"
@onready var character_panel = $"../CharacterPanel"

var card_scene = preload("res://cards/character_card.tscn")
var current_mode := InteractionMode.NONE

func _ready():
	
	EventBus.character_selected.connect(_on_character_selected)

	create_test_character(
		"Campesino",
		"Detective",
		CharacterData.Faction.TOWN
	)

	create_test_character(
		"Campesino",
		"Saboteador",
		CharacterData.Faction.SABOTEUR
	)


func create_test_character(name, role, faction):
	var data = CharacterData.new()
	data.character_name = name
	data.role_name = role
	data.faction = faction
	
	var card = card_scene.instantiate()
	npc_container.add_child(card)
	card.setup(data)
	card.card_selected.connect(_on_card_selected)

func set_mode(mode):
	current_mode = mode

func clear_mode():
	current_mode = InteractionMode.NONE

func _on_character_selected(character : CharacterData):
	match current_mode:
		
		InteractionMode.NONE:
			character_panel.display_character(character)
		InteractionMode.IMPRISON:
			PrisonManager.imprison(character)
		InteractionMode.RELEASE:
			PrisonManager.release(character)
		InteractionMode.EXILE:
			PrisonManager.exile(character)

func _on_card_selected(card):
	character_panel.display_character(card)

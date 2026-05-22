class_name CharacterCard
extends Button

signal card_selected(character_data)

var data : CharacterData

@onready var name_label = $MarginContainer/VBoxContainer/NameLabel
@onready var state_label = $MarginContainer/VBoxContainer/StateLabel
@onready var role_hint_label = $MarginContainer/VBoxContainer/RoleHintLabel


func _ready():

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	await get_tree().process_frame

	EventBus.character_imprisoned.connect(_on_character_changed)
	EventBus.character_released.connect(_on_character_changed)
	EventBus.character_exiled.connect(_on_character_changed)
	
func refresh():

	update_visuals()
	update_style()

func _on_mouse_entered():

	scale = Vector2(1.05, 1.05)

func _on_mouse_exited():

	scale = Vector2.ONE

func setup(character_data : CharacterData):
	data = character_data
	name_label.text = data.character_name
	update_visuals()

func update_visuals():
	match data.state:

		CharacterData.State.FREE:
			state_label.text = "Libre"
		CharacterData.State.IMPRISONED:
			state_label.text = "Encarcelado"
		CharacterData.State.EXILED:
			state_label.text = "Exiliado"

	role_hint_label.text = "???"

func update_style():
	match data.state:

		CharacterData.State.FREE:
			modulate = Color.WHITE
		CharacterData.State.IMPRISONED:
			modulate = Color.YELLOW
		CharacterData.State.EXILED:
			modulate = Color.DIM_GRAY

func _gui_input(event):

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			GameManager.character_selected(data)
			
func _on_character_changed(character):

	if character == data:
		refresh()

func _pressed():

	EventBus.character_selected.emit(data)

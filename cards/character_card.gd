class_name CharacterCard
extends Button

signal card_selected(character : CharacterData)

var data : CharacterData

@onready var state_label = $MarginContainer/VBoxContainer/StateLabel
@onready var role_hint_label = $MarginContainer/VBoxContainer/RoleHintLabel


func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func setup(character_data : CharacterData):
	data = character_data
	role_hint_label.text = data.role_name
	refresh()


func refresh():
	update_visuals()
	update_style()


func update_visuals():

	match data.state:

		CharacterData.State.FREE:
			state_label.text = "Libre"
		CharacterData.State.IMPRISONED:
			state_label.text = "Encarcelado"
		CharacterData.State.EXILED:
			state_label.text = "Exiliado"

	role_hint_label.text = data.role_name


func update_style():
	match data.state:

		CharacterData.State.FREE:
			modulate = Color.WHITE
		CharacterData.State.IMPRISONED:
			modulate = Color.YELLOW
		CharacterData.State.EXILED:
			modulate = Color.DIM_GRAY


func _pressed():
	card_selected.emit(data)


func _on_mouse_entered():
	scale = Vector2(1.05, 1.05)


func _on_mouse_exited():
	scale = Vector2.ONE

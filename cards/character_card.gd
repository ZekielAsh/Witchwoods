class_name CharacterCard
extends Button

signal card_selected(character : CharacterData)

var data : CharacterData

@onready var state_label = $MarginContainer/VBoxContainer/StateLabel
@onready var role_label = $MarginContainer/VBoxContainer/RoleLabel


func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func setup(character_data : CharacterData):
	data = character_data
	refresh()


func refresh():
	update_visuals()
	update_style()


func update_visuals():
	if data.state == CharacterData.State.EXILED:
		state_label.text = "Exiliado"
		role_label.text = data.get_real_role_name()
	else:
		state_label.text = "Libre"
		role_label.text = data.get_role_name()


func update_style():
	if data.state == CharacterData.State.EXILED:
		modulate = Color.DIM_GRAY
	else:
		modulate = Color.WHITE


func _pressed():
	if data.state == CharacterData.State.EXILED:
		return

	card_selected.emit(data)


func _on_mouse_entered():
	if data.state == CharacterData.State.EXILED:
		return

	scale = Vector2(1.05, 1.05)


func _on_mouse_exited():
	scale = Vector2.ONE

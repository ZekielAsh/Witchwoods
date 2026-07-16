class_name CharacterCard
extends Button

@onready var bus : EventBus = $"../../../EventBus"
@onready var highlight = %Highlight

var data : CharacterData
var reveal_mode := false
var highlighted := false

@onready var id_label = %IDLabel
@onready var role_label = %RoleLabel


func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	bus.character_exiled.connect(_on_character_exiled)
	
	bus.tutorial_highlight_character.connect(_on_highlight)
	bus.tutorial_clear_highlights.connect(_on_clear_highlight)

func setup(character_data : CharacterData):
	data = character_data
	refresh()

func refresh():
	update_visuals()
	update_style()

func update_visuals():
	id_label.text = "#%d"  % data.character_id
	if reveal_mode:
		role_label.text = data.get_real_role_name()
	elif data.state == CharacterData.State.EXILED:
		role_label.text = data.get_real_role_name()
	else:
		role_label.text = data.get_role_name()

func update_style():
	if data.state == CharacterData.State.EXILED:
		modulate = Color.DIM_GRAY
	else:
		modulate = Color.WHITE

	if highlighted:
		self_modulate = Color(1.0, 1.0, 0.6)
	else:
		self_modulate = Color.WHITE

func set_highlight(enabled: bool):
	highlighted = enabled
	highlight.visible = enabled

func reveal():
	reveal_mode = true
	refresh()

func _pressed():
	if data.state == CharacterData.State.EXILED:
		return

	bus.character_selected.emit(data)

func _on_mouse_entered():
	if data.state == CharacterData.State.EXILED:
		return

	scale = Vector2(1.05, 1.05)

func _on_mouse_exited():
	scale = Vector2.ONE

func _exit_tree():
	if bus.character_exiled.is_connected(_on_character_exiled):
		bus.character_exiled.disconnect(_on_character_exiled)

	if bus.tutorial_highlight_character.is_connected(_on_highlight):
		bus.tutorial_highlight_character.disconnect(_on_highlight)

	if bus.tutorial_clear_highlights.is_connected(_on_clear_highlight):
		bus.tutorial_clear_highlights.disconnect(_on_clear_highlight)

func _on_character_exiled(character : CharacterData):
	if character == data:
		refresh()

func _on_highlight(character_id : int):
	set_highlight(data.character_id == character_id)

func _on_clear_highlight():
	set_highlight(false)

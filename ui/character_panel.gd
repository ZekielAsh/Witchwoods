extends PanelContainer

var current_character : CharacterData

@onready var role_label = %RoleLabel
@onready var information_label = %InformationLabel

var reveal_mode := false

func set_reveal_mode():
	reveal_mode = true

func display_character(character : CharacterData):
	current_character = character
	if reveal_mode:
		role_label.text = character.get_real_role_name()
	elif character.state == CharacterData.State.EXILED:
		role_label.text = character.get_real_role_name()
	else:
		role_label.text = character.get_role_name()
	information_label.text = character.statement

func get_state_text(state : CharacterData.State):
	match state:
		CharacterData.State.FREE: return "Libre"
		CharacterData.State.EXILED: return "Exiliado"
	return ""

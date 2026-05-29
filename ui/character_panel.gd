extends PanelContainer

var current_character : CharacterData

@onready var role_label = %RoleLabel
@onready var information_label = %InformationLabel


func display_character(character : CharacterData):
	current_character = character
	if character.state == CharacterData.State.EXILED:
		role_label.text = character.get_real_role_name()
	else:
		role_label.text = character.get_role_name()
	information_label.text = character.get_information()


func get_state_text(state : CharacterData.State):
	match state:
		CharacterData.State.FREE:
			return "Libre"
		CharacterData.State.EXILED:
			return "Exiliado"
			
	return ""

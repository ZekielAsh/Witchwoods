extends PanelContainer

var current_character : CharacterData

@onready var role_label = $VBoxContainer/RoleLabel
@onready var state_label = $VBoxContainer/StateLabel


func display_character(character : CharacterData):

	current_character = character

	state_label.text = str(character.state)
	role_label.text = character.role_name

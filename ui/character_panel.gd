extends PanelContainer

var current_card : CharacterCard
var current_character : CharacterData

@onready var name_label = $VBoxContainer/NameLabel
@onready var role_label = $VBoxContainer/RoleLabel
@onready var state_label = $VBoxContainer/StateLabel


func display_character(card : CharacterCard):

	current_card = card
	current_character = card.data

	name_label.text = current_character.character_name
	state_label.text = str(current_character.state)

	role_label.text = "Rol desconocido"

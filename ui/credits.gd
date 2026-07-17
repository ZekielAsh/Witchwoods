class_name Credits
extends PopupPanel

@onready var close_button = %CloseButton

func _ready():
	close_button.pressed.connect(_on_close_pressed)

func open():
	popup_centered()

func _on_close_pressed():
	hide()

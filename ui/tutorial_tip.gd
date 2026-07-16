class_name TutorialTip
extends PopupPanel

@onready var close_button = %CloseButton
@onready var tutorial_text = %TutorialText


func _ready():
	close_button.pressed.connect(
		_on_close_pressed
	)


func open():
	popup_centered()


func _on_close_pressed():
	hide()
	

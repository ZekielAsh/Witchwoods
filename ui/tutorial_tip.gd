class_name TutorialTip
extends PopupPanel

@onready var close_button = %CloseButton
@onready var tutorial_text = %TutorialText
@onready var bus : EventBus = $"../GameManager/EventBus"


func _ready():
	close_button.pressed.connect(
		_on_close_pressed
	)

func open():
	bus.paper_flipped.emit()
	popup_centered()


func _on_close_pressed():
	bus.paper_flipped.emit()
	hide()

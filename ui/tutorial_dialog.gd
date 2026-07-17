class_name TutorialDialog
extends Control

signal next_pressed

@onready var message = %Message
@onready var next_button = %NextButton
@onready var bus : EventBus = $"../GameManager/EventBus"


func _ready():
	next_button.pressed.connect(_on_next_pressed)

func _on_next_pressed():
	bus.paper_flipped.emit()
	
	hide()
	next_pressed.emit()

func show_message(text:String, button_text := "Continuar"):
	show()
	message.text = text
	next_button.text = button_text


func close():
	hide()

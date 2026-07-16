extends CanvasLayer

signal retry_requested
signal reveal_requested

@onready var result_label = %ResultLabel
@onready var reveal_button = %RevealButton
@onready var retry_button = %RetryButton

var analysis_mode := false
var from_tutorial := true

func _ready():
	visible = false
	retry_button.pressed.connect(_on_retry_button_pressed)
	reveal_button.pressed.connect(_on_reveal_button_pressed)

func show_victory():
	visible = true
	result_label.text = "Victoria"
	if from_tutorial:
		retry_button.text = "Comenzar investigación"
	else:
		retry_button.text = "Nueva investigación"

func show_defeat():
	visible = true
	result_label.text = "Derrota"
	retry_button.text = "Nueva investigación"

func hide_screen():
	visible = false

func _on_reveal_button_pressed():
	reveal_requested.emit()

func _on_retry_button_pressed():
	retry_requested.emit()

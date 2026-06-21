extends CanvasLayer

signal retry_requested
signal reveal_requested

@onready var result_label = %ResultLabel
@onready var reveal_button = %RevealButton
@onready var retry_button = %RetryButton

var analysis_mode := false

func _ready():
	visible = false
	retry_button.pressed.connect(_on_retry_button_pressed)
	reveal_button.pressed.connect(_on_reveal_button_pressed)

func show_victory():
	visible = true
	result_label.text = "Victoria"

func show_defeat():
	visible = true
	result_label.text = "Derrota"


func _on_reveal_button_pressed():
	reveal_requested.emit()

func _on_retry_button_pressed():
	retry_requested.emit()

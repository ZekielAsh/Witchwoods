extends CanvasLayer

signal retry_requested

@onready var result_label = %ResultLabel
@onready var retry_button = %RetryButton


func _ready():
	visible = false
	retry_button.pressed.connect(
		_on_retry_button_pressed
	)


func show_victory():
	visible = true
	result_label.text = "Victoria"


func show_defeat():
	visible = true
	result_label.text = "Derrota"


func _on_retry_button_pressed():
	retry_requested.emit()

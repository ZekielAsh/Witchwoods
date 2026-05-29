extends CanvasLayer

signal retry_requested

@onready var result_label = $PanelContainer/VBoxContainer/ResultLabel


func show_victory():
	visible = true
	result_label.text = "Victoria"


func show_defeat():
	visible = true
	result_label.text = "Derrota"


func _on_retry_button_pressed():
	retry_requested.emit()

extends CanvasLayer

signal retry_requested

@onready var result_label = %ResultLabel
@onready var legend_label = %LegendLabel
@onready var retry_button = %RetryButton
@onready var bus : EventBus = $"../GameManager/EventBus"

var analysis_mode := false
var from_tutorial := true

func _ready():
	visible = false
	retry_button.pressed.connect(_on_retry_button_pressed)

func show_victory():
	visible = true
	result_label.text = "Victoria"
	legend_label.text = "Has rescatado la aldea."
	if from_tutorial:
		retry_button.text = "Comenzar investigación"
	else:
		retry_button.text = "Nueva investigación"

func show_defeat():
	visible = true
	result_label.text = "Derrota"
	legend_label.text = "La aldea ha caido en el engaño."
	retry_button.text = "Nueva investigación"

func hide_screen():
	visible = false

func _on_retry_button_pressed():
	bus.ui_button_pressed.emit()
	retry_requested.emit()

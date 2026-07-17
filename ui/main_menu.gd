extends CanvasLayer
signal start_requested
signal tutorial_game_requested
signal codex_requested
signal exit_requested

@onready var start_button = %StartButton
@onready var tutorial_button = %TutorialButton
@onready var codex_button = %CodexButton
@onready var exit_button = %ExitButton
@onready var bus : EventBus = $"../GameManager/EventBus"

func _ready():

	start_button.text = "Comenzar investigación"
	tutorial_button.text = "Aprender a jugar"
	codex_button.text = "Guia de Investigación"
	exit_button.text = "Créditos"

	start_button.pressed.connect(func():
		bus.ui_button_pressed.emit()
		start_requested.emit()
	)

	tutorial_button.pressed.connect(func():
		bus.ui_button_pressed.emit()
		tutorial_game_requested.emit()
	)

	codex_button.pressed.connect(func():
		bus.ui_button_pressed.emit()
		codex_requested.emit()
	)

	exit_button.pressed.connect(func():
		bus.ui_button_pressed.emit()
		exit_requested.emit()
	)

func open():
	show()

func close():
	hide()

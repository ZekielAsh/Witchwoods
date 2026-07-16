extends CanvasLayer
signal start_requested
signal tutorial_game_requested
signal codex_requested
signal exit_requested

@onready var start_button = %StartButton
@onready var tutorial_button = %TutorialButton
@onready var codex_button = %CodexButton
@onready var exit_button = %ExitButton

func _ready():

	start_button.text = "Comenzar investigación"
	tutorial_button.text = "Aprender a jugar"
	codex_button.text = "Registro de habitantes"
	exit_button.text = "Salir"

	start_button.pressed.connect(
		func(): start_requested.emit()
	)

	tutorial_button.pressed.connect(
		func(): tutorial_game_requested.emit()
	)

	codex_button.pressed.connect(
		func(): codex_requested.emit()
	)

	exit_button.pressed.connect(
		func(): exit_requested.emit()
	)

func open():
	show()

func close():
	hide()

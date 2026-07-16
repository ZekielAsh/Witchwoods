extends CanvasLayer

@onready var game_manager : GameManager = $"../GameManager"
@onready var tutorial_tip : TutorialTip = $"../TutorialTip"

@onready var exile_button = %ExileButton
@onready var mode_label = $ModeLabel
@onready var help_button = $HelpButton


func _ready():
	game_manager.bus.interaction_mode_changed.connect(
		_on_interaction_mode_changed
	)

	_on_interaction_mode_changed(
		GameManager.InteractionMode.NONE
	)

	exile_button.tooltip_text = (
		"Activa el modo de captura. Luego selecciona al personaje que creas que es un Saboteador."
	)

	help_button.tooltip_text = (
		"Consulta las condiciones y el objetivo de la investigación."
	)

	mode_label.tooltip_text = (
		"Muestra si estás investigando o intentando capturar a un sospechoso."
	)


func _on_exile_button_pressed():

	if game_manager.current_mode == GameManager.InteractionMode.EXILE:
		game_manager.clear_mode()
	else:
		game_manager.set_mode(
			GameManager.InteractionMode.EXILE
		)


func _on_interaction_mode_changed(mode : int):
	match mode:

		GameManager.InteractionMode.NONE:
			mode_label.text = "Investigando..."
			exile_button.text = "Capturar sospechoso"

		GameManager.InteractionMode.EXILE:
			mode_label.text = "Selecciona al sospechoso."
			exile_button.text = "Cancelar captura"


func _on_help_button_pressed() -> void:
	tutorial_tip.open()

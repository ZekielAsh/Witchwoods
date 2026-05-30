extends CanvasLayer

@onready var game_manager : GameManager = $"../GameManager"

@onready var exile_button = %ExileButton
@onready var mode_label = $ModeLabel
@onready var tutorial_tip = $TutorialTip
@onready var help_button = $HelpButton

var tutorial_shown := false


func _ready():
	game_manager.bus.interaction_mode_changed.connect(
		_on_interaction_mode_changed
	)

	_on_interaction_mode_changed(
		GameManager.InteractionMode.NONE
	)

	exile_button.tooltip_text = (
		"Activa el modo exilio para expulsar un personaje."
	)

	help_button.tooltip_text = (
		"Aprende cómo jugar."
	)

	mode_label.tooltip_text = (
		"Indica el modo de interacción actual."
	)

	await get_tree().process_frame
	
	if not get_tree().has_meta("tutorial_shown"):

		tutorial_tip.open()

		get_tree().set_meta(
			"tutorial_shown",
			true
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
			mode_label.text = "Modo: Inspección"
			exile_button.text = "Exiliar"

		GameManager.InteractionMode.EXILE:
			mode_label.text = "Modo: Exilio"
			exile_button.text = "Cancelar"


func _on_help_button_pressed() -> void:
	tutorial_tip.open()

extends CanvasLayer

@onready var game_manager : GameManager = $"../GameManager"

@onready var mode_label = $ModeLabel
@onready var exile_button = $ExileButton


func _ready():

	game_manager.bus.interaction_mode_changed.connect(
		_on_interaction_mode_changed
	)

	_on_interaction_mode_changed(
		GameManager.InteractionMode.NONE
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

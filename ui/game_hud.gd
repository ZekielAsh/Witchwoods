extends CanvasLayer

@onready var game_manager : GameManager = $"../"


func _on_imprison_button_pressed():
	game_manager.set_mode(GameManager.InteractionMode.IMPRISON)


func _on_release_button_pressed():
	game_manager.set_mode(GameManager.InteractionMode.RELEASE)


func _on_exile_button_pressed():
	game_manager.set_mode(GameManager.InteractionMode.EXILE)

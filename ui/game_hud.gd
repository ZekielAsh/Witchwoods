extends CanvasLayer


func _on_imprison_button_pressed():
	GameManager.current_mode = GameManager.InteractionMode.IMPRISON

func _on_release_button_pressed():
	GameManager.current_mode = GameManager.InteractionMode.RELEASE

func _on_exile_button_pressed():
	GameManager.current_mode = GameManager.InteractionMode.EXILE

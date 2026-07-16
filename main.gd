extends Node

@onready var menu = $MainMenu
@onready var game = $GameManager
@onready var hud = $GameHUD
@onready var panel = $GameManager/CharacterPanel
@onready var tutorial = $TutorialTip

func _ready() -> void:
	hud.hide()
	panel.hide()
	tutorial.hide()

	menu.start_requested.connect(_on_start)
	menu.tutorial_requested.connect(_on_guide)

func _on_start():
	menu.hide()
	hud.show()
	panel.show()
	game.start_game()

func _on_guide():
	tutorial.open()

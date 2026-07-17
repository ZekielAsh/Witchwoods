extends Node

@onready var menu = $MainMenu
@onready var game = $GameManager
@onready var hud = $GameHUD
@onready var panel = $GameManager/CharacterPanel
@onready var tutorial = $TutorialTip
@onready var audio = $AudioManager

func _ready() -> void:
	hud.hide()
	panel.hide()
	tutorial.hide()

	menu.start_requested.connect(_on_start_normal)
	menu.tutorial_game_requested.connect(_on_start_tutorial)

func _on_start_normal():
	menu.hide()
	hud.show()
	panel.show()

	game.bus.transition_requested.emit()

	audio.play_music(AudioManager.Music.GAME)
	game.start_game(GameManager.GameMode.NORMAL)

func _on_start_tutorial():
	menu.hide()
	hud.show()
	panel.show()

	game.bus.transition_requested.emit()

	audio.play_music(AudioManager.Music.GAME)
	game.start_game(GameManager.GameMode.TUTORIAL)

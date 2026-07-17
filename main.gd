extends Node

@onready var menu = $MainMenu
@onready var game = $GameManager
@onready var hud = $GameHUD
@onready var panel = $GameManager/CharacterPanel
@onready var tutorial = $TutorialTip
@onready var credits = $Credits
@onready var audio = $AudioManager

func _ready() -> void:
	hud.hide()
	panel.hide()
	tutorial.hide()

	menu.start_requested.connect(_on_start_normal)
	menu.tutorial_game_requested.connect(_on_start_tutorial)
	menu.codex_requested.connect(_on_open_guide)
	menu.exit_requested.connect(_on_open_credits)

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

func _on_open_guide():
	tutorial.show()

func _on_open_credits():
	credits.show()

class_name AudioManager
extends Node

enum Sound {
	CARD_SELECT,
	ENTER_CAPTURE,
	EXIT_CAPTURE,
	EXILE,
	VICTORY,
	DEFEAT,
	OPEN_HELP,
	CLOSE_HELP
}

@onready var ambience_player = $MusicPlayer
@onready var sfx_player = $SfxPlayer

#const SOUNDS = {
	#Sound.CARD_SELECT: preload("res://assets/audio/sfx/card_select.wav"),
	#Sound.ENTER_CAPTURE: preload("res://assets/audio/sfx/enter_capture.wav"),
	#Sound.EXIT_CAPTURE: preload("res://assets/audio/sfx/exit_capture.wav"),
	#Sound.EXILE: preload("res://assets/audio/sfx/exile.wav"),
	#Sound.VICTORY: preload("res://assets/audio/sfx/victory.wav"),
	#Sound.DEFEAT: preload("res://assets/audio/sfx/defeat.wav"),
	#Sound.OPEN_HELP: preload("res://assets/audio/sfx/open_help.wav"),
	#Sound.CLOSE_HELP: preload("res://assets/audio/sfx/open_help.wav")
#}

const AMBIENCE = preload("res://assets/audio/ambience/forest_loop.ogg")

func _ready():
	ambience_player.stream = AMBIENCE
	ambience_player.play()

#func play_sound(sound):
	#sfx_player.stop()
	#sfx_player.stream = SOUNDS[sound]
	#sfx_player.play()

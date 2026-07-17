class_name AudioManager
extends Node

enum Music {
	MENU,
	GAME
}

enum Sound {
	CARD_SELECT,
	CARD_SETTLE,
	CARD_SETTLE_2,
	CARD_SETTLE_3,
	DEFEAT,
	ENTER_CAPTURE,
	EXILE,
	EXILE_CHARACTER,
	EXIT_CAPTURE,
	HOVER,
	PAPER_FLIP,
	PASS,
	TRANSITION,
	VICTORY
}

@onready var music_player = $MusicPlayer
@onready var sfx_player = $SfxPlayer
@onready var state_player = $StatePlayer
@onready var bus : EventBus = $"../GameManager/EventBus"


const MUSIC = {
	Music.MENU: preload("res://assets/audio/ambience/main_menu.ogg"),
	Music.GAME: preload("res://assets/audio/ambience/forest_loop.ogg")
}

const SOUNDS = {
	Sound.CARD_SELECT: preload("res://assets/audio/sfx/card_select.wav"),
	Sound.CARD_SETTLE: preload("res://assets/audio/sfx/card_settle.wav"),
	Sound.CARD_SETTLE_2: preload("res://assets/audio/sfx/card_settle_2.wav"),
	Sound.CARD_SETTLE_3: preload("res://assets/audio/sfx/card_settle_3.wav"),
	Sound.DEFEAT: preload("res://assets/audio/sfx/defeat.wav"),
	Sound.ENTER_CAPTURE: preload("res://assets/audio/sfx/enter_capture.wav"),
	Sound.EXILE: preload("res://assets/audio/sfx/exile.wav"),
	Sound.EXILE_CHARACTER: preload("res://assets/audio/sfx/exile_character.wav"),
	Sound.EXIT_CAPTURE: preload("res://assets/audio/sfx/exit_capture.wav"),
	Sound.HOVER: preload("res://assets/audio/sfx/hover.wav"),
	Sound.PAPER_FLIP: preload("res://assets/audio/sfx/paper_flip.wav"),
	Sound.PASS: preload("res://assets/audio/sfx/pass.wav"),
	Sound.TRANSITION: preload("res://assets/audio/sfx/transition.wav"),
	Sound.VICTORY: preload("res://assets/audio/sfx/victory.wav")
}

var current_music : Music = Music.MENU
var current_state_sound = null

func _ready():
	music_player.finished.connect(_on_music_finished)
	play_music(Music.MENU)
	
	bus.character_inspected.connect(_on_character_selected)
	bus.character_exiled.connect(_on_character_exiled)
	
	bus.paper_flipped.connect(_on_paper_flipped)
	bus.ui_button_pressed.connect(_on_ui_button_pressed)
	
	bus.transition_requested.connect(_on_transition_requested)
	bus.new_investigation_started.connect(_on_pass_requested)
	
	bus.game_won.connect(_on_game_won)
	bus.game_lost.connect(_on_game_lost)
	
	bus.capture_mode_entered.connect(_on_capture_mode_entered)
	bus.capture_mode_exited.connect(_on_capture_mode_exited)
	
	bus.exile_loop_started.connect(_on_exile_loop_started)
	bus.exile_loop_stopped.connect(_on_exile_loop_stopped)

func play_music(track : Music):
	if current_music == track and music_player.playing:
		return

	current_music = track
	music_player.stop()
	music_player.stream = MUSIC[track]
	music_player.play()

func _on_music_finished():
	music_player.play()

func play_sound(sound):
	sfx_player.stop()
	sfx_player.stream = SOUNDS[sound]
	sfx_player.play()

func _on_ui_button_pressed():
	play_sound(Sound.CARD_SELECT)

func _on_paper_flipped():
	play_sound(Sound.PAPER_FLIP)

func _on_character_selected(character):
	play_card_settle()

func play_card_settle():
	var sounds = [
		Sound.CARD_SETTLE,
		Sound.CARD_SETTLE_2,
		Sound.CARD_SETTLE_3
	]

	play_sound(sounds.pick_random())

func _on_transition_requested():
	play_sound(Sound.TRANSITION)

func _on_pass_requested():
	play_sound(Sound.PASS)

func _on_capture_mode_entered():
	play_sound(Sound.ENTER_CAPTURE)

func _on_capture_mode_exited():
	play_sound(Sound.EXIT_CAPTURE)

func _on_character_exiled(character):
	play_sound(Sound.EXILE_CHARACTER)

func _on_game_won():
	print("VICTORIA")
	play_sound(Sound.VICTORY)

func _on_game_lost():
	print("DERROTA")
	play_sound(Sound.DEFEAT)

func play_state(sound):
	current_state_sound = sound

	state_player.stop()
	state_player.stream = SOUNDS[sound]
	state_player.play()

func stop_state():
	current_state_sound = null
	state_player.stop()

func _on_state_finished():
	if current_state_sound != null:
		state_player.play()

func _on_exile_loop_started():
	play_state(Sound.EXILE)

func _on_exile_loop_stopped():
	stop_state()

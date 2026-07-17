class_name EventBus
extends Node

signal character_selected(character : CharacterData)
signal character_inspected(character : CharacterData)
signal character_exiled(character : CharacterData)

signal interaction_mode_changed(mode : int)

signal capture_mode_entered
signal capture_mode_exited

signal new_investigation_started
signal transition_requested

signal ui_button_pressed
signal paper_flipped

signal exile_loop_started
signal exile_loop_stopped

signal game_won
signal game_lost

signal tutorial_started(match : MatchData)
signal tutorial_finished

signal tutorial_show_message(text:String, button_text:String)
signal tutorial_next_step

signal tutorial_highlight_character(character_id : int)
signal tutorial_clear_highlights

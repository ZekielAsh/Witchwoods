class_name EventBus
extends Node

signal character_selected(character : CharacterData)
signal character_exiled(character : CharacterData)

signal interaction_mode_changed(mode : int)

signal game_won
signal game_lost

signal tutorial_started(match : MatchData)
signal tutorial_finished

signal tutorial_show_message(text:String, button_text:String)
signal tutorial_next_step

signal tutorial_highlight_character(character_id : int)
signal tutorial_clear_highlights

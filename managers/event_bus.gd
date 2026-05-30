class_name EventBus
extends Node

signal character_selected(character : CharacterData)
signal character_exiled(character : CharacterData)

signal interaction_mode_changed(mode : int)

signal game_won
signal game_lost

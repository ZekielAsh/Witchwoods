class_name StabilitySystem
extends Node

const MAX_FAILURES := 2
var failures := 0
@onready var bus : EventBus = $"../EventBus"


func _ready():
	bus.character_exiled.connect(_on_character_exiled)

func reset():
	failures = 0

func _on_character_exiled(character : CharacterData):
	if character.faction == CharacterData.Faction.TOWN:

		failures += 1

		if failures >= MAX_FAILURES:
			bus.game_lost.emit()

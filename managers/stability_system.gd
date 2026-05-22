extends Node

var stability := 10

@onready var bus : EventBus = $"../EventBus"


func _ready():

	bus.character_imprisoned.connect(_on_character_imprisoned)
	bus.character_released.connect(_on_character_released)
	bus.character_exiled.connect(_on_character_exiled)


func modify_stability(amount):

	stability += amount

	print("Estabilidad actual:", stability)

	check_defeat()


func check_defeat():

	if stability <= 0:
		print("DERROTA")


func _on_character_imprisoned(character):
	modify_stability(-1)


func _on_character_released(character):
	modify_stability(1)


func _on_character_exiled(character):

	if character.faction == CharacterData.Faction.SABOTEUR:
		modify_stability(2)
	else:
		modify_stability(-3)

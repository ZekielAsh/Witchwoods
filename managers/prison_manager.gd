class_name PrisonManager
extends Node

const MAX_PRISONERS = 2

var imprisoned_characters = []

@onready var bus : EventBus = $"../EventBus"


func imprison(character : CharacterData):
	if character.state != CharacterData.State.FREE:
		return false

	if imprisoned_characters.size() >= MAX_PRISONERS:
		return false

	imprisoned_characters.append(character)
	character.state = CharacterData.State.IMPRISONED
	bus.character_imprisoned.emit(character)
	return true


func release(character : CharacterData):
	if character.state != CharacterData.State.IMPRISONED:
		return

	imprisoned_characters.erase(character)
	character.state = CharacterData.State.FREE
	bus.character_released.emit(character)


func exile(character : CharacterData):
	if character.state != CharacterData.State.IMPRISONED:
		return

	imprisoned_characters.erase(character)
	character.state = CharacterData.State.EXILED
	bus.character_exiled.emit(character)

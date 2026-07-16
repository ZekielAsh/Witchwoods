class_name TutorialController
extends Node

@onready var bus : EventBus = $"../EventBus"
@onready var game_manager : GameManager = $"../../GameManager"

enum Step {
	NONE,
	SELECT_COUNSELOR,
	READ_COUNSELOR,
	EXILE_SABOTEUR,
	FINISHED
}

var current_step := Step.NONE
var current_match

func _ready():
	bus.tutorial_started.connect(start)
	bus.character_selected.connect(_on_character_selected)
	bus.character_exiled.connect(_on_character_exiled)
	bus.tutorial_next_step.connect(_on_next_step)

func start(match : MatchData):
	current_match = match
	current_step = Step.SELECT_COUNSELOR

	bus.tutorial_show_message.emit(
		"Bienvenido, investigador.\n\nComencemos hablando con este aldeano.",
		"Comenzar"
	)

	bus.tutorial_highlight_character.emit(
		match.tutorial_data.counselor.character_id
	)

func _on_next_step():
	match current_step:

		Step.SELECT_COUNSELOR:
			bus.tutorial_show_message.emit(
				"Haz clic sobre el personaje iluminado.",
				"Continuar"
			)
		Step.READ_COUNSELOR:
			current_step = Step.EXILE_SABOTEUR
			bus.tutorial_show_message.emit(
				"Ahora intentaremos capturar al saboteador.\n\nHaz clic en Capturar sospechoso.",
				"¡Y exilialo!"
			)
			bus.tutorial_highlight_character.emit(
				current_match.tutorial_data.saboteur.character_id
			)

func _on_character_selected(character:CharacterData):
	if current_step != Step.SELECT_COUNSELOR:
		return
	if character != current_match.tutorial_data.counselor:
		return

	current_step = Step.READ_COUNSELOR

	bus.tutorial_show_message.emit(
		"Perfecto.\n\nLee atentamente su declaración.",
	    "Entendido"
	)
	bus.tutorial_clear_highlights.emit()

func _on_character_exiled(character):
	if current_step != Step.EXILE_SABOTEUR:
		return
	if character != current_match.tutorial_data.saboteur:
		return

	current_step = Step.FINISHED
	game_manager.tutorial_completed = true
	game_manager.current_game_mode = GameManager.GameMode.NORMAL

	bus.tutorial_clear_highlights.emit()
	bus.tutorial_show_message.emit(
		"¡Excelente trabajo investigador!\n\nHas rescatado la aldea.",
		"¡Ahora ve y salva mas aldeas!"
	)

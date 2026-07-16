class_name MatchGenerator
extends Node

const TOWN_ROLES = [
	#CharacterData.Role.NAIVE,
	CharacterData.Role.COUNSELOR,
	CharacterData.Role.LIBRARIAN,
	CharacterData.Role.CHRONICLER,
	CharacterData.Role.INVESTIGATOR,
	CharacterData.Role.ORACLE,
	CharacterData.Role.JUDGE,
	CharacterData.Role.MIME
]

func generate_match(level := 1) -> MatchData:
	var data := MatchData.new()

	data.mode = GameManager.GameMode.NORMAL
	data.characters = create_random_match(level)

	InformationGenerator.generate(data.characters)

	return data

func generate_tutorial_match() -> MatchData:
	var data := MatchData.new()

	data.mode = GameManager.GameMode.TUTORIAL
	data.characters = create_tutorial_match()

	InformationGenerator.generate(data.characters)
	data.tutorial_data = TutorialData.new()
	data.tutorial_data.initialize(data.characters)

	return data

func create_random_match(level : int) -> Array[CharacterData]:
	var characters : Array[CharacterData] = []
	var total_characters := get_character_count(level)
	var saboteur_count := get_saboteur_count(total_characters)
	var town_count := total_characters - saboteur_count
	
	var available_roles = TOWN_ROLES.duplicate()
	if total_characters < 6: available_roles.erase(CharacterData.Role.JUDGE)

	available_roles.shuffle()
	for i in range(town_count):
		var role = available_roles.pop_front()
		characters.append(
			make_character(role, role, CharacterData.Faction.TOWN))
	
	var present_roles := []
	for character in characters:
		if character.faction == CharacterData.Faction.TOWN:
			present_roles.append(character.visible_role)
	var absent_roles := []
	for role in available_roles:
		if !present_roles.has(role): absent_roles.append(role)
	
	present_roles.erase(CharacterData.Role.MIME)
	absent_roles.erase(CharacterData.Role.MIME)
	characters.append(make_character(
			CharacterData.Role.INFILTRATOR,
			absent_roles.pick_random(),
			CharacterData.Faction.SABOTEUR))
	if saboteur_count >= 2:
		characters.append(make_character(
			CharacterData.Role.ACTOR,
			present_roles.pick_random(),
			CharacterData.Faction.SABOTEUR))
	
	configure_mime(characters)
	characters.shuffle()
	for i in range(characters.size()): characters[i].character_id = i + 1
	assign_positions(characters)
	return characters

func create_tutorial_match() -> Array[CharacterData]:
	var characters : Array[CharacterData] = []

	characters.append(make_character(
		CharacterData.Role.COUNSELOR,
		CharacterData.Role.COUNSELOR,
		CharacterData.Faction.TOWN
	))

	characters.append(make_character(
		CharacterData.Role.INFILTRATOR,
		CharacterData.Role.LIBRARIAN,
		CharacterData.Faction.SABOTEUR
	))

	characters.append(make_character(
		CharacterData.Role.LIBRARIAN,
		CharacterData.Role.LIBRARIAN,
		CharacterData.Faction.TOWN
	))

	characters.append(make_character(
		CharacterData.Role.CHRONICLER,
		CharacterData.Role.CHRONICLER,
		CharacterData.Faction.TOWN
	))

	for i in range(characters.size()):
		characters[i].character_id = i + 1

	assign_positions(characters)

	return characters

func assign_positions(characters : Array) -> void:
	var count := characters.size()
	var columns := 4
	match count:
		4: columns = 4
		6: columns = 3
		8: columns = 4

	for i in range(count):

		var x = i % columns
		var y = i / columns

		characters[i].board_position = Vector2i(x, y)

func get_character_count(level : int) -> int:
	var options = [4, 6, 8]
	return options.pick_random()

func get_saboteur_count(character_count : int) -> int:
	if character_count >= 6: return 2
	return 1

func make_character(real_role, visible_role, faction) -> CharacterData:
	var character = CharacterData.new()
	character.real_role = real_role
	character.visible_role = visible_role
	character.faction = faction
	return character

func configure_mime(characters : Array) -> void:
	var mime = null
	for character in characters:
		if character.real_role == CharacterData.Role.MIME:
			mime = character
			break
	if mime == null: return
	
	var candidates := []
	for character in characters:
		if character == mime: continue
		if character.faction != CharacterData.Faction.TOWN: continue
		candidates.append(character)
	if candidates.is_empty(): return

	var target = candidates.pick_random()
	mime.visible_role = target.visible_role

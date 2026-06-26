class_name InformationGenerator
extends RefCounted


static func generate(match : Array) -> void:
	for character in match:
		match character.visible_role:
			CharacterData.Role.NAIVE: generate_naive(character)
			CharacterData.Role.COUNSELOR: generate_counselor(character, match)
			CharacterData.Role.LIBRARIAN: generate_librarian(character, match)
			CharacterData.Role.CHRONICLER: generate_chronicler(character, match)
			CharacterData.Role.INVESTIGATOR: generate_investigator(character, match)
			CharacterData.Role.ORACLE: generate_oracle(character, match)
			CharacterData.Role.JUDGE: generate_judge(character, match)


static func generate_naive(character):
	if character.faction == CharacterData.Faction.TOWN:
		character.statement = "Pueden confiar en mí. Soy un Aldeano."
	else:
		character.statement = "No quiero contarte."

static func generate_librarian(character, match):
	var infiltrators := count_infiltrators(match)
	if character.faction == CharacterData.Faction.TOWN:
		character.statement = (
			"He contado %s en la aldea."
			% format_saboteurs(infiltrators)
		)
	else:
		var lie = generate_fake_number(infiltrators, 0, match.size())
		character.statement = (
			"He contado %s en la aldea."
			% format_saboteurs(lie)
		)

static func generate_counselor(character, match):
	var nearby = count_adjacent_infiltrators(character, match)
	if character.faction == CharacterData.Faction.TOWN:
		character.statement = (
			"Entre mis vecinos inmediatos hay %s."
			% format_saboteurs(nearby)
		)
	else:
		var lie = generate_fake_number(nearby, 0, 2)
		character.statement = (
			"Entre mis vecinos inmediatos hay %s."
			% format_saboteurs(lie)
		)

static func generate_chronicler(character, match): 
	var same_faction = neighbors_same_faction(character, match) 
	if character.faction != CharacterData.Faction.TOWN: 
		same_faction = !same_faction 
		
	if same_faction: character.statement = "Todos mis vecinos son del mismo bando." 
	else: character.statement = "Entre mis vecinos hay Aldeanos y Saboteadores."

static func generate_investigator(character, match):
	var villagers = count_villagers(match)
	if character.faction == CharacterData.Faction.TOWN:
		character.statement = (
			"He identificado %d Aldeanos."
			% villagers
		)
	else:
		var lie = generate_fake_number(villagers, 0, match.size())
		character.statement = (
			"He identificado %d Aldeanos."
			% lie
		)

static func generate_oracle(character, match):
	var infiltrators = count_infiltrators(match)
	var is_even = infiltrators % 2 == 0
	if character.faction != CharacterData.Faction.TOWN:
		is_even = !is_even
	if is_even:
		character.statement = ("Puedo divinar que los Saboteadores forman un grupo par.")
	else:
		character.statement = ("Puedo divinar que los Saboteadores forman un grupo impar.")

static func generate_judge(character, match):
	var candidates = get_judge_candidates(character, match)
	if candidates.is_empty():
		character.statement = "Todos son culpables."
		return
	var target = candidates.pick_random()
	character.statement = (
		"Considero inocente al personaje #%d."
		% target.character_id)


static func count_villagers(match) -> int:
	var total := 0
	for character in match:
		if character.faction == CharacterData.Faction.TOWN:
			total += 1
	return total

static func count_infiltrators(match : Array) -> int:
	var total := 0
	for character in match:
		if character.faction == CharacterData.Faction.SABOTEUR:
			total += 1
	return total

static func count_adjacent_infiltrators(character : CharacterData, match : Array) -> int:
	var total := 0
	var directions = [
		Vector2i.LEFT,
		Vector2i.RIGHT,
		Vector2i.UP,
		Vector2i.DOWN
	]
	for direction in directions:
		var target_position = character.board_position + direction
		for other in match:
			if other.board_position == target_position:
				if other.faction == CharacterData.Faction.SABOTEUR:
					total += 1
				break
	return total

static func neighbors_same_faction(character, match) -> bool:
	var neighbors = get_neighbors(character, match)
	if neighbors.size() < 2: return false
	var first_faction = neighbors[0].faction
	for neighbor in neighbors:
		if neighbor.faction != first_faction: return false
	return true

static func get_neighbors(character : CharacterData, match : Array) -> Array:
	var neighbors := []
	var directions = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]
	for direction in directions:
		var target_position = character.board_position + direction
		for other in match:
			if other.board_position == target_position:
				neighbors.append(other)
				break
	return neighbors

static func generate_fake_number(real_value : int, min_value : int, max_value : int) -> int:
	var options := []
	for i in range(min_value, max_value + 1):
		if i != real_value: options.append(i)
	return options.pick_random()

static func format_saboteurs(count : int) -> String:
	if count == 0: return "solo Aldeanos"
	if count == 1: return "1 Saboteador"
	return "%d Saboteadores" % count

static func get_judge_candidates(character, match) -> Array:
	var candidates := []
	if character.faction == CharacterData.Faction.TOWN:
		for other in match:
			if other == character: continue
			if other.faction == CharacterData.Faction.TOWN: candidates.append(other)
	else:
		for other in match:
			if other == character: continue
			if other.faction == CharacterData.Faction.SABOTEUR: candidates.append(other)
	return candidates

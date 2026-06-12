class_name InformationGenerator
extends RefCounted


static func generate(match : Array) -> void:

	for character in match:

		match character.visible_role:

			CharacterData.Role.NAIVE:
				generate_naive(character)

			CharacterData.Role.COUNSELOR:
				generate_counselor(character, match)

			CharacterData.Role.LIBRARIAN:
				generate_librarian(character, match)


static func generate_naive(character):

	if character.faction == CharacterData.Faction.TOWN:
		character.statement = "Soy aldeano"

	else:
		character.statement = "No quiero contarte"


static func generate_librarian(
	character,
	match
):

	var infiltrators := count_infiltrators(match)

	if character.faction == CharacterData.Faction.TOWN:

		character.statement = (
			"Hay %d saboteadores"
			% infiltrators
		)

	else:

		var lie = generate_fake_number(
			infiltrators,
			0,
			match.size()
		)

		character.statement = (
			"Hay %d saboteadores"
			% lie
		)


static func generate_counselor(
	character,
	match
):

	var nearby = count_adjacent_infiltrators(
		character,
		match
	)

	if character.faction == CharacterData.Faction.TOWN:

		character.statement = (
			"Tengo %d saboteadores cerca"
			% nearby
		)

	else:

		var lie = generate_fake_number(
			nearby,
			0,
			2
		)

		character.statement = (
			"Tengo %d saboteadores cerca"
			% lie
		)


static func count_infiltrators(
	match : Array
) -> int:

	var total := 0

	for character in match:

		if character.faction == CharacterData.Faction.SABOTEUR:
			total += 1

	return total


static func count_adjacent_infiltrators(
	character,
	match
) -> int:

	var index = match.find(character)

	var total := 0

	if index > 0:

		if match[index - 1].faction == CharacterData.Faction.SABOTEUR:
			total += 1

	if index < match.size() - 1:

		if match[index + 1].faction == CharacterData.Faction.SABOTEUR:
			total += 1

	return total


static func generate_fake_number(
	real_value : int,
	min_value : int,
	max_value : int
) -> int:

	var options := []

	for i in range(
		min_value,
		max_value + 1
	):

		if i != real_value:
			options.append(i)

	return options.pick_random()

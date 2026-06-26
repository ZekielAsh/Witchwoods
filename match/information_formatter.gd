class_name InformationFormatter
extends RefCounted

const TOWN_COLOR := "#69C36B"
const SABOTEUR_COLOR := "#D35A5A"

static func format(statement: String) -> String:
	var text := statement

	text = text.replace(
		"Aldeanos",
		"[color=%s]Aldeanos[/color]" % TOWN_COLOR
	)

	text = text.replace(
		"Aldeano",
		"[color=%s]Aldeano[/color]" % TOWN_COLOR
	)

	text = text.replace(
		"Saboteadores",
		"[color=%s]Saboteadores[/color]" % SABOTEUR_COLOR
	)

	text = text.replace(
		"Saboteador",
		"[color=%s]Saboteador[/color]" % SABOTEUR_COLOR
	)

	return text

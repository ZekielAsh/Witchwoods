extends Node

var stability := 10

func modify_stability(amount):

	stability += amount

	print("Estabilidad actual:", stability)

	check_defeat()


func check_defeat():

	if stability <= 0:
		print("DERROTA")

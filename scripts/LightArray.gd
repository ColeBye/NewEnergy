extends Node3D

var arr = []
var num_bulbs = 20 * 25 * 25

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in num_bulbs:
		arr.append("BLACK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_light_color(color, idx):
	#print([color, idx])
	arr[idx] = color
	#print([arr[0], arr[1]])
func get_light_color(idx):
	return arr[idx]

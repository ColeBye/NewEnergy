extends Node3D

var arr = []

# signal enter
# signal exit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_light_color(color, idx):
	print([color, idx])
	arr[idx] = color

func get_light_color(idx):
	return arr[idx]
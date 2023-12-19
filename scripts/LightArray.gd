extends Node3D

var arr = []
var num_bulbs = 16 * 26 * 26

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in num_bulbs:
		arr.append([Color.BLACK])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_light_color(color, idx, lit):
	if lit:
		arr[idx].append(color)
	else:
		arr[idx].erase(color)
	
	var col_list = arr[idx]
	var num_col = col_list.size() - 1
	if num_col > 1:
		var r = 0
		var g = 0
		var b = 0
		for c in range(1, num_col + 1):
			r += col_list[c].r
			g += col_list[c].g
			b += col_list[c].b		
		arr[idx][0] = Color(r/num_col, g/num_col, b/num_col, 1.0)
	elif num_col == 1:
		arr[idx][0] = col_list[1]
	else:
		arr[idx][0] = Color.BLACK
	
	
func get_light_color(idx):
	return arr[idx][0]

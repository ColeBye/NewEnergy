extends Node3D

@onready var light_array = get_node("/root/Main/LightArray").arr
@export var bulb_idx = 0
var xval = 0
var yval = 0
var zval = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	xval = get_parent().get_meta("x", 0)
	yval = get_parent().get_parent().get_meta("y", 0)
	zval = get_parent().get_parent().get_parent().get_meta("z", 0)

	# array size X:25, Y:20. Z:25
	# idx = (z * ySize + y) * xSize + x;
	bulb_idx = (zval * 20 + yval) * 25 + xval


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.Mesh.material.albedo_color = light_array.get_light_color(bulb_idx)

func xyz_to_idx():
	# array size X:25, Y:20. Z:25
	# idx = (z * ySize + y) * xSize + x;
	return (zval * 20 + yval) * 25 + xval


extends StaticBody3D

@onready var light_array = get_node("/root/Main/LightArray")
@export var detector_idx = 0
var xval = 0
var yval = 0
var zval = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	xval = get_parent().get_meta("x", 0)
	yval = get_parent().get_parent().get_meta("y", 0)
	zval = get_parent().get_parent().get_parent().get_meta("z", 0)
	
	detector_idx = (zval * 20 + yval) * 25 + xval


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func xyz_to_idx():
	pass

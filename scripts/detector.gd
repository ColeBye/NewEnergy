extends StaticBody3D

var hand = false

@onready var light_array = get_node("/root/Main/LightArray")
var detector_idx = 0
@export var xval = 0
var yval = 0
var zval = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#xval = self.get_meta("x", 0)
	yval = get_parent().axis
	zval = get_parent().get_parent().axis
	
	detector_idx = (zval * 16 + yval) * 26 + xval


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

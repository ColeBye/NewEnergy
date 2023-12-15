extends Node3D

@onready var light_array = get_node("/root/Main/LightArray")
var bulb_idx = 0
@export var xval = 0
var yval = 0
var zval = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#set up index
	yval = get_parent().axis
	zval = get_parent().get_parent().axis
	# array size X:25, Y:20. Z:25
	# idx = (z * ySize + y) * xSize + x;
	bulb_idx = (zval * 20 + yval) * 25 + xval
	
	#set up mesh
	var new_mesh = SphereMesh.new()
	new_mesh.radius = 0.2
	new_mesh.height = 0.4
	new_mesh.radial_segments = 8
	new_mesh.rings = 4

	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.0, 0.0, 0.0, 1.0)
	# set other mat params
	new_mesh.material = mat
	self.mesh = new_mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.mesh.material.albedo_color = light_array.get_light_color(bulb_idx)



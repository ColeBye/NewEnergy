extends Node3D

@onready var light_array = get_node("/root/Main/LightArray")
var bulb_idx = 0
@export var xval = 0
var yval = 0
var zval = 0

var blk = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#set up index
	yval = get_parent().axis
	zval = get_parent().get_parent().axis
	# array size X:25, Y:20. Z:25
	# idx = (z * ySize + y) * xSize + x;
	bulb_idx = (zval * 16 + yval) * 26 + xval
	
	#set up mesh
	var new_mesh = SphereMesh.new()
	new_mesh.radius = 0.05
	new_mesh.height = 0.1
	new_mesh.radial_segments = 8
	new_mesh.rings = 4

	# var new_mesh = BoxMesh.new()
	# new_mesh.size.x = 0.1
	# new_mesh.size.y = 0.1
	# new_mesh.size.z = 0.1
	

	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.7, 0.7, 0.7, 0.5)
	# set other mat params
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_VERTEX
	mat.emission_enabled = true
	mat.emission = Color(0.0, 0.0, 0.0, 1.0)
	mat.emission_energy_multiplier = 3.0
	mat.disable_receive_shadows = true

	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA

	new_mesh.material = mat
	self.mesh = new_mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var color = light_array.get_light_color(bulb_idx)
	if color != Color.BLACK:
		self.mesh.material.emission = color
		blk = false
	elif blk == false:
		self.mesh.material.emission = Color.BLACK
		self.mesh.material.albedo_color = Color(0.7, 0.7, 0.7, 0.5)
		blk = true


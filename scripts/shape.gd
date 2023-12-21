extends Area3D

@onready var light_array = get_node("/root/Main/LightArray")
var color = Color.GREEN 
var blank_color = Color.BLACK
@onready var parent_grab = get_parent()
var rotating = false
@onready var backup_pos = self.position
@export var rotate_dist = 0.12
@export var rotate_speed = 1.25
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	color = $MeshInstance3D.mesh.material.albedo_color
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if rotating:
		self.position.x = rotate_dist * sin(timer*rotate_speed)
		self.position.y = rotate_dist * cos(timer*rotate_speed)
		#self.position.z = rotate_dist * cos(timer*rotate_speed)
	else:
		self.position = backup_pos


func _on_body_entered(body:Node3D): #body is the detector it touched
	if body is RigidBody3D:
		return

	light_array.set_light_color(color, body.detector_idx, true)
	

func _on_body_exited(body:Node3D):
	if body is RigidBody3D:
		return
	light_array.set_light_color(color, body.detector_idx, false)
	

func set_shape_color(new_color):
	color = new_color


extends Area3D

@onready var light_array = get_node("/root/Main/LightArray")
var color = Color.GREEN 
var blank_color = Color.BLACK

# Called when the node enters the scene tree for the first time.
func _ready():
	color = $MeshInstance3D.mesh.material.albedo_color
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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


extends Node3D

enum State {
	CHANGING,
	GRABBING,
	EMPTY,
}

@onready var state = State.EMPTY

@onready var left_hand = get_node("/root/Main/XROrigin3D/LeftController/FunctionPickup")
@onready var right_hand = get_node("/root/Main/XROrigin3D/RightController/FunctionPickup")
var left_grabbed = null
var right_grabbed = null
var sample_color = Color.BLACK


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#check to change state
	# if obj grabbed and hand/obj near cyl, then changing
	# grabbing may not be necessary unless can be changed on pickup on other code to optimized constant hand obj search(fuc pup methods for pickup/drop)

	if state == State.CHANGING:
		#calculate/change sample color
		$Sample.visible = true
		if self.global_position.distance_to(left_hand.global_position) > 0.5 and self.global_position.distance_to(right_hand.global_position) > 0.5:
			state = State.GRABBING
		
		sample_color = find_hsv()
		$Sample.mesh.material.emission = sample_color 

	elif state == State.GRABBING:
		$Sample.visible = false
		if self.global_position.distance_to(left_hand.global_position) < 0.5 or self.global_position.distance_to(right_hand.global_position) < 0.5:
			state = State.CHANGING
	else:
		#just empty, state to grabbing should be done in grab code
		$Sample.visible = false

#make helper func for checking hsv of an obj. make sure to bind min and max values
func find_hsv():
	var close = null
	if left_grabbed == null:
		close = right_grabbed
	elif right_grabbed == null:
		close = left_grabbed
	elif self.global_position.distance_to(left_hand.global_position) < self.global_position.distance_to(right_hand.global_position):
		close = left_grabbed
	else:
		close = right_grabbed
	
	var rel_pos = close.global_position - self.global_position
	
	var val = clamp((rel_pos.y / 0.5) + 0.5, 0, 1)

	var ref_pt = Vector3(0, rel_pos.y, 0)
	var sat = clamp((rel_pos.distance_to(ref_pt) / 3) * 10, 0, 1)

	ref_pt = Vector3(0, rel_pos.y, 0.3)
	var hue = (rad_to_deg(Vector2(0,0).angle_to_point(Vector2(rel_pos.x, rel_pos.z))) + 180) / 360
	#ref_pt.x, ref_pt.z
	#rel_pos.x, rel_pos.z

	return Color.from_hsv(hue, sat, val, 1.0)

func grab_state():
	left_grabbed = left_hand.picked_up_object
	right_grabbed = right_hand.picked_up_object

	if not right_grabbed and not left_grabbed:
		state = State.EMPTY
	elif left_grabbed or right_grabbed and state != State.CHANGING:
		state = State.GRABBING


func _on_left_controller_button_pressed(name:String):
	if name == "trigger_click" and state == State.CHANGING:
		
		#set held obj color to color var
		#print(left_grabbed.get_node("Area/MeshInstance3D"))
		left_grabbed.get_node("Area/MeshInstance3D").mesh.material.albedo_color = sample_color
		left_grabbed.get_node("Area").set_shape_color(sample_color)
		#left_grabbed = null


	
func _on_right_controller_button_pressed(name:String):
	if name == "trigger_click" and state == State.CHANGING:
		#print(right_grabbed.get_node("Area/MeshInstance3D"))
		right_grabbed.get_node("Area/MeshInstance3D").mesh.material.albedo_color = sample_color
		right_grabbed.get_node("Area").set_shape_color(sample_color)
		#right_grabbed = null


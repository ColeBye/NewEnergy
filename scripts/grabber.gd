extends Node3D

var hand = true

@onready var left_hand = get_node("/root/Main/XROrigin3D/LeftController/Grabber")
@onready var right_hand = get_node("/root/Main/XROrigin3D/RightController/Grabber")

var grabbed_object: Area3D = null
var previous_transform: Transform3D
var placed: int = 0
# @onready var grabbables = get_node("/root/Main/Shapes")
@onready var grabbables = [get_node("/root/Main/Shapes/Dummy"), get_node("/root/Main/Shapes/Dummy2")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.grabbed_object:
		self.grabbed_object.transform = self.transform * self.previous_transform.inverse() * self.grabbed_object.transform
		#self.grabbed_object.position = self.position

	self.previous_transform = self.transform 


func _on_button_pressed(button_name: String) -> void:
	#print("button pressed: " + button_name)
	
	# Stop if we have not clicked the grip button or we already are grabbing an object
	if button_name != "grip_click" || self.grabbed_object != null:
		return
	
	var collision_area = $GrabArea as RigidBody3D

	# Iterate through all grabbable objects and check if the collision area overlaps with them
	for grabbable in grabbables:
		# Cast the grabbable object to a RigidBody3D
		var grabbable_body = grabbable as Area3D

		# Check to see if the grabber and grabbable collision shapes are intersecting
		if grabbable_body.overlaps_body(collision_area):
			print("YE")
			# If the object is already grabbed by another grabber, release it first
			# if left_hand.grabbed_object == grabbable_body:
			# 	left_hand.grabbed_object = null
			# elif right_hand.grabbed_object == grabbable_body:
			# 	right_hand.grabbed_object = null

			# grab it
			self.grabbed_object = grabbable_body
		else:
			print("NA")


func _on_button_released(button_name: String) -> void:
	#print("button released: " + button_name)
	
	# Stop if we have not clicked the grip button or we have no current grabbed object
	if button_name != "grip_click" || self.grabbed_object == null:
		return

	# Release the grabbed object
	self.grabbed_object = null


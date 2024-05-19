extends CharacterBody2D

#Variables
var animation_tree
var animation_state

#Initializing variables
func _ready():
	Global.playerBody = self
	animation_tree = get_node("AnimationTree")
	animation_state = animation_tree.get("parameters/playback")
	
func _physics_process(delta):
	
	#Movement
	var move_dir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
		)
	var speed = 100
	velocity = move_dir.normalized() * speed
	move_and_slide()
	update_animation(move_dir)

	#Animations
func update_animation(move_dir):
	if(move_dir!=Vector2.ZERO):
		animation_state.travel("walk")
		animation_tree.set("parameters/idle/blend_position", move_dir)
		animation_tree.set("parameters/walk/blend_position", move_dir)
	else:
		animation_state.travel("idle")
		
		#Broke the collision, first try failed.
		#It's ok, we improve.

extends CharacterBody2D

#Variables
var animation_tree
var animation_state

const speed = 40

var dir: Vector2
var p_chase: bool
var player: CharacterBody2D

#Initializing variables
func _ready():
	animation_tree = get_node("AnimationTree")
	animation_state = animation_tree.get("parameters/playback")
	p_chase=false
	
#States
func _on_area_2d_body_entered(body):
	p_chase=true
	player = Global.playerBody
	
func _on_area_2d_body_exited(body):
	p_chase=false
	player = null
	
#Movement
func move(delta):
	if p_chase:
		velocity = position.direction_to(player.position) * speed
		dir.x=abs(velocity.x) / velocity.x
		dir.y=abs(velocity.y) / velocity.y
	else:
		velocity+=dir * speed * delta
	move_and_slide()
	
#Animations
func update_animation(move_dir):
	if(move_dir!=Vector2.ZERO):
		animation_state.travel("walk")
		animation_tree.set("parameters/idle/blend_position", move_dir)
		animation_tree.set("parameters/walk/blend_position", move_dir)
	else:
		animation_state.travel("idle")
	
func _process(delta):
	move(delta)
	update_animation(dir)
	
	
#Broke the collision, first try failed.
#It's ok, we improve.

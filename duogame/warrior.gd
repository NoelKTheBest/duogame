extends CharacterBody2D


var SPEED = 300.0
var JUMP_VELOCITY = -400.0

var light_mode = "00c9c6"
var dark_mode = "0b0030"

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var collider : CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	animation_tree.active = true
	$Area2D.visible = false
	modulate = light_mode


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		animation_tree.active = false
		if sprite.flip_h: animation_player.play("attack_L")
		else: animation_player.play("attack_R")
	
	if modulate == Color(dark_mode):
		SPEED = 250
		JUMP_VELOCITY = -475
	elif modulate == Color(light_mode):
		SPEED = 350
		JUMP_VELOCITY = -400


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if animation_tree.active == true:
		if velocity.x < 0: sprite.flip_h = true 
		elif velocity.x > 0: sprite.flip_h = false
	elif animation_tree.active == false and is_on_floor():
		if velocity.x < 0: sprite.flip_h = true 
		elif velocity.x > 0: sprite.flip_h = false
	
	collider.position.x = 18 if sprite.flip_h else 0

	move_and_slide()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_L" or anim_name == "attack_R":
		animation_tree.active = true


func _on_light_area_entered(area: Area2D) -> void:
	modulate = light_mode


func _on_dark_area_entered(area: Area2D) -> void:
	modulate = dark_mode

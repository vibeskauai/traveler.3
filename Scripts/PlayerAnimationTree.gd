extends Node2D

@export var animation_tree: AnimationTree
@onready var player: Player = get_owner()  # Assigns the player node as the parent

var last_facing_direction := Vector2(0, 1)

func _physics_process(_delta: float) -> void:
	
	var idle = !player.velocity
	
	if !idle: last_facing_direction = player.velocity.normalized()
			
	animation_tree.set("parameters/walk/blend_position", last_facing_direction)
	animation_tree.set("parameters/idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/swing/blend_position", last_facing_direction)
	animation_tree.set("parameters/gather/blend_position", last_facing_direction)

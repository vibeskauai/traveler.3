class_name Player extends CharacterBody2D

@onready var animation_tree: AnimationTree
@export var speed: float = 80.0
@export var inventory_data: InventoryData
var pickup_distance = 32  # Distance at which player can pick up items

var last_facing_direction := Vector2(0, 1)
var swinging := false
var gathering := false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	return input_direction * speed


func _physics_process(_delta: float) -> void:
	var input_direction = get_input()
	velocity = input_direction
	move_and_slide()
	# Swing Click
	if Input.is_action_just_pressed("swing") and not swinging:
		swing()
	if Input.is_action_pressed("gather") and not gathering:
		gather()
		

func swing():
	swinging = true
	await get_tree().create_timer(0.5).timeout
	swinging = false

func gather():
	gathering = true
	await get_tree().create_timer(1.4).timeout
	gathering = false

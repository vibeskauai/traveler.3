class_name Player extends CharacterBody2D

@onready var animation_tree: AnimationTree
@export var speed: float = 80.0
@export var inventory_data: InventoryData
@export var equip_inventory_data: InventoryDataEquip

static var current_player: Player

var pickup_distance = 32  # Distance at which player can pick up items
var last_facing_direction := Vector2(0, 1)
var swinging := false
var gathering := false

func _ready():
	current_player = self

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	return input_direction * speed

func _physics_process(_delta: float) -> void:
	velocity = get_input()
	move_and_slide()

	if Input.is_action_just_pressed("swing"):
		if is_mouse_over_npc():
			print("Cannot swing at NPC!")
		elif not $MouseOverInventory.is_mouse_over_inventory_or_npc():
			swing()

	if Input.is_action_pressed("gather"):
		if not $MouseOverInventory.is_mouse_over_inventory_or_npc():
			gather()

func is_mouse_over_npc() -> bool:
	var mouse_pos = get_global_mouse_position()
	for npc in get_tree().get_nodes_in_group("NPCs"):
		var npc_sprite = npc.get_node("Sprite2D")
		var npc_rect = Rect2(npc_sprite.get_global_position() - npc_sprite.texture.get_size() / 6 + Vector2(6, 15), npc_sprite.texture.get_size() / 5)
		if npc_rect.has_point(mouse_pos):
			return true
	return false

func swing():
	swinging = true
	await get_tree().create_timer(0.5).timeout
	swinging = false

func gather():
	gathering = true
	await get_tree().create_timer(1.4).timeout
	gathering = false

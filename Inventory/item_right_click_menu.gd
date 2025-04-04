extends Node2D

var target_slot: SlotData

@export var equip: Button
@export var cancel: Button

func _ready() -> void:
	equip.pressed.connect(_on_equip_pressed)
	cancel.pressed.connect(_on_cancel_pressed)

func setup_up(slot: SlotData) -> void:
	target_slot = slot
	
func _on_equip_pressed() -> void:
	Player.current_player.equipped_inventory.drop_slot_data(target_slot, 0)
	queue_free()
	
func _on_cancel_pressed() -> void:
	queue_free()

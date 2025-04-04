extends Node2D
class_name World

static var current_world: World

@onready var player: Player = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface

func _ready() -> void:
	inventory_interface.set_player_inventory_data(player.inventory_data)
	inventory_interface.set_equip_inventory_data(player.equip_inventory_data)
	current_world = self

func _on_inventory_interface_drop_slot_data(_slot_data: SlotData) -> void:
	pass

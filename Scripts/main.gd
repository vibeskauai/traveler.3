extends Node2D

@onready var player: Player = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface

func _ready() -> void:
	inventory_interface.set_player_inventory_data(player.inventory_data)

func _on_inventory_interface_drop_slot_data(_slot_data: SlotData) -> void:
	pass

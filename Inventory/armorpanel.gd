extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var helmet_slot: Button = $VBoxContainer/HelmetSlot
@onready var weapon_slot: Button = $VBoxContainer/ChestRow/WeaponSlot
@onready var chest_slot: Button = $VBoxContainer/ChestRow/ChestSlot
@onready var shield_slot: Button = $VBoxContainer/ChestRow/ShieldSlot
@onready var legs_slot: Button = $VBoxContainer/LegsSlot

func set_equipped_items(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func populate_item_grid(inventory_data: InventoryData) -> void:
	weapon_slot.set_slot_data(inventory_data.equipped_weapon)
	helmet_slot.set_slot_data(inventory_data.equipped_helmet)
	chest_slot.set_slot_data(inventory_data.equipped_chest)
	shield_slot.set_slot_data(inventory_data.equipped_shield)
	legs_slot.set_slot_data(inventory_data.equipped_legs)

func show_panel() -> void:
	visible = true

func hide_panel() -> void:
	visible = false

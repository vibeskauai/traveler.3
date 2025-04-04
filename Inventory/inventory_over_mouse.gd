extends Node

@onready var inventory_interface_node = $"/root/TheCrossroads/UI/InventoryInterface"

var panels = ["InventoryPanel", "StatsPanel", "ArmorPanel"]
var buttons = ["InventoryButton", "StatsButton", "ArmorButton"]
var npcs = []


func _ready():
	npcs = get_tree().get_nodes_in_group("NPCs")
	print(npcs)  # Print out the npcs array

func is_mouse_over_inventory_or_npc() -> bool:
	var mouse_position = get_viewport().get_mouse_position()

	for panel in panels:
		var panel_rect = inventory_interface_node.get_node(panel).get_global_rect()
		if panel_rect.has_point(mouse_position):
			return true

	for button in buttons:
		var button_rect = inventory_interface_node.get_node(button).get_global_rect()
		if button_rect.has_point(mouse_position):
			return true

	return false

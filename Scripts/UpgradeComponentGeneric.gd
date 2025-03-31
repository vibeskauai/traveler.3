extends Node

var inventory_data: InventoryData
var equip_slot: SlotData

func _ready():
	inventory_data = load("res://Inventory/player_inventory.tres")
	equip_slot = load("res://Inventory/equip_slot.tres")
	get_node("../InteractionArea").connect("interacted", Callable(self, "_on_interaction_area_clicked"))

func _on_interaction_area_clicked():
	_on_NPC_clicked()

func _on_NPC_clicked():
	var item_data = get_item_to_upgrade()
	if item_data:
		print("Found item to upgrade:", item_data.name)
		var next_upgrade = item_data.next_upgrade
		if next_upgrade:
			print("Next upgrade:", next_upgrade.name)
			upgrade_item(item_data, next_upgrade)
		else:
			print("No next upgrade found for item:", item_data.name)
	else:
		print("No item to upgrade found")

func upgrade_item(item_data: ItemData, next_upgrade: ItemData):
	var required_resources = next_upgrade.upgrade_recipe.resources
	if has_required_resources(required_resources):
		# Upgrade the item
		for slot_data in inventory_data.slot_datas:
			if slot_data.item_data == item_data:
				slot_data.item_data = next_upgrade
				print("Upgraded item to:", next_upgrade.name)
				remove_resources(required_resources)
				break
	else:
		print("Not enough resources to upgrade")

func has_required_resources(resources: Dictionary) -> bool:
	for resource in resources:
		if not has_resource(resource, resources[resource]):
			return false
	return true

func has_resource(resource: String, amount: int) -> bool:
	for slot_data in inventory_data.slot_datas:
		if slot_data and slot_data.item_data and slot_data.item_data.name == resource:
			if slot_data.quantity >= amount:
				return true
	return false

func remove_resources(resources: Dictionary):
	for resource in resources:
		for slot_data in inventory_data.slot_datas:
			if slot_data and slot_data.item_data and slot_data.item_data.name == resource:
				if slot_data.quantity >= resources[resource]:
					slot_data.quantity -= resources[resource]
					print("Removed", resources[resource], "of", resource, "from inventory")
				else:
					print("Not enough", resource, "in inventory to remove")

func get_item_to_upgrade() -> ItemData:
	for slot_data in inventory_data.slot_datas:
		if slot_data and slot_data.item_data and slot_data.item_data.next_upgrade:
			return slot_data.item_data
	print("No item to upgrade found")
	return 

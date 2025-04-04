extends Node

var inventory_data: InventoryData
var equip_slot: SlotData

func _ready():
	inventory_data = load("res://Inventory/player_inventory.tres")
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
	var ore_resource = next_upgrade.upgrade_recipe.resources["ore"]
	var ore_name = ore_resource.name
	var ore_amount = next_upgrade.upgrade_recipe.resources["amount"]
	var has_enough_ores = false

	for slot_data in inventory_data.slot_datas:
		if slot_data and slot_data.item_data and slot_data.item_data.name == ore_name:
			if slot_data.quantity >= ore_amount:
				has_enough_ores = true
				break

	if has_enough_ores:
		# Upgrade the pickaxe
		for slot_data in inventory_data.slot_datas:
			if slot_data.item_data == item_data:
				slot_data.item_data = next_upgrade
				print("Upgraded item to:", next_upgrade.name)
				remove_ores(next_upgrade.upgrade_recipe)
				break
	else:
		print("Not enough ", ore_name, " in inventory to upgrade")

func remove_ores(upgrade_recipe: UpgradeRecipe):
	var ore_resource = upgrade_recipe.resources["ore"]
	var ore_name = ore_resource.name
	for slot_data in inventory_data.slot_datas:
		if slot_data and slot_data.item_data and slot_data.item_data.name == ore_name:
			if slot_data.quantity >= upgrade_recipe.resources["amount"]:
				slot_data.quantity -= upgrade_recipe.resources["amount"]
				print("Removed ", upgrade_recipe.resources["amount"], " of ", ore_name, " from inventory")
			else:
				print("Not enough", ore_name, "in inventory to remove")
		

func get_item_to_upgrade():
	for slot_data in inventory_data.slot_datas:
		if slot_data and slot_data.item_data and slot_data.item_data.item_type == "pickaxe":
			var item_data = slot_data.item_data
			if item_data.next_upgrade:
				return item_data
	print("No pickaxe found")
	return null

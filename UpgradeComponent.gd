extends Node

var inventory_data: InventoryData
var equip_slot: SlotData

func _ready():
    inventory_data = load("res://Inventory/test_inventory.tres")
    equip_slot = load("res://Inventory/equip_slot.tres")
    
    print("Loaded inventory_data:", inventory_data)
    print("Loaded equip_slot:", equip_slot)
    
    get_node("../InteractionArea").connect("interacted", Callable(self, "_on_interaction_area_clicked"))

func _on_interaction_area_clicked():
    perform_upgrade()

func has_pickaxe(inventory_data: InventoryData, equip_slot: SlotData = null) -> bool:
    for slot_data in inventory_data.slot_datas:
        if slot_data != null and slot_data.item_data != null and slot_data.item_data.item_type == "Pickaxe":
            return true

    if equip_slot != null and equip_slot.item_data != null and equip_slot.item_data.item_type == "Pickaxe":
        return true

    return false

func get_item_to_upgrade():
    for slot_data in inventory_data.slot_datas:
        if slot_data != null and slot_data.item_data != null and slot_data.item_data.item_type == "Pickaxe":
            print("Found item to upgrade:", slot_data.item_data)
            return slot_data.item_data
    return null

func has_resource(resource_name: String, quantity: int) -> bool:
    print("Checking for resource:", resource_name, "quantity:", quantity)
    for slot_data in inventory_data.slot_datas:
        if slot_data.item_data != null and slot_data.item_data.name == resource_name and slot_data.quantity >= quantity:
            print("Found enough resources:", resource_name, "quantity:", quantity)
            return true
    print("Not enough resources:", resource_name, "quantity:", quantity)
    return false

func has_required_resources(upgrade_recipe: UpgradeRecipe) -> bool:
    print("Checking required resources for upgrade")
    for resource_name in upgrade_recipe.resources.keys():
        var quantity = upgrade_recipe.resources[resource_name]
        if not has_resource(resource_name, quantity):
            print("Missing required resource:", resource_name, "quantity:", quantity)
            return false
    print("All required resources found:")
    return true

func perform_upgrade():
    var item_to_upgrade = get_item_to_upgrade()
    if item_to_upgrade != null:
        var upgrade_recipe = item_to_upgrade.upgrade_recipe
        if upgrade_recipe != null:
            if has_required_resources(upgrade_recipe):
                upgrade_item(item_to_upgrade, inventory_data)
                print("Item upgraded!")
            else:
                print("Insufficient resources to upgrade item.")
        else:
            print("No upgrade recipe found for item.")
    else:
        print("No item to upgrade.")

func upgrade_item(item_data: ItemData, inventory_data: InventoryData) -> bool:
    if not item_data.upgrade_recipe:
        return false

    for resource_name in item_data.upgrade_recipe.resources.keys():
        var quantity = item_data.upgrade_recipe.resources[resource_name]
        var slot_data = get_slot_data(resource_name)
        if not slot_data or slot_data.quantity < quantity:
            return false
        slot_data.quantity -= quantity

    var upgraded_slot_data = SlotData.new()
    upgraded_slot_data.item_data = item_data.next_upgrade
    upgraded_slot_data.quantity = 1

    inventory_data.slot_datas.append(upgraded_slot_data)

    return true

func get_slot_data(resource_name: String):
    for slot_data in inventory_data.slot_datas:
        if slot_data.item_data != null and slot_data.item_data.name == resource_name:
            return slot_data
    return null
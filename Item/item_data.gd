extends Resource
class_name ItemData

@export var name: String = ""
@export var texture: Texture
@export var item_type: String = ""  # pickaxe, weapon, armor, herb, etc.
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var upgrade_recipe: Array[ItemData]

@export_group("Equippable") 
@export var can_equip: bool = false
@export var equip_slot: String = "" 
@export var stats_resource: StatsResource = null 
@export var next_upgrade: ItemData

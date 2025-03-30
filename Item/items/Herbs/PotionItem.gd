# PotionItem.gd (Inherits from ItemData)
extends ItemData

@export var potion_type: String # Type of potion (e.g., "Health Potion")
@export var recipe: Array = []  # List of herb types required to craft the potion
@export var potion_effect: Dictionary = {"stat": "health", "value": 20} # Effect of the potion

extends Button

func _on_InventoryButton_pressed():
	$InventoryPanel.show()
	$StatsPanel.hide()
	$ArmorPanel.hide()

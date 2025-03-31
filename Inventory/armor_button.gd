extends Button

func _on_ArmorButton_pressed():
	$InventoryPanel.hide()
	$StatsPanel.hide()
	$ArmorPanel.show()

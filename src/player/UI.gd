extends CanvasLayer

#
# Node References
#

## Inventory
onready var inventory := $Inventory;
onready var crop_counter := $Inventory/VBoxContainer/CropCount;
onready var upgrade_list := $Inventory/VBoxContainer/UpgradeList;


###########################
### Show/Hide Inventory ###
###########################

func _ready() -> void:
	inventory.set_visible(false);

func _input(event: InputEvent) -> void:
	_update_crop_count();
	if Input.is_action_just_pressed("player_show_inventory"):
		inventory.set_visible(true);
		
	elif Input.is_action_just_released("player_show_inventory"):
		inventory.set_visible(false);

#
# Update the crop counter in the inventory
#
func _update_crop_count() -> void:
	## Update crop counts
	crop_counter.set_text(
		"Tomatoes: %s\nCarrots: %s\nBeets: %s\nZucchini: %s" % [
			GameData.crop_data["tomato"],
			GameData.crop_data["carrot"],
			GameData.crop_data["beet"],
			GameData.crop_data["zucchini"],
		]
	);
	
	## Update upgrades
	for l in upgrade_list.get_children():
		var text := "";
		text += l.get_name();
		
		for k in GameData.upgrade_data[l.get_name()]:
			text += "\n%s: %s" % [k, GameData.upgrade_data[l.get_name()][k]];
#			text += k + ": " + GameData.upgrade_data[l.get_name()][k];
		
		l.set_text(text);

class_name Crop extends Interactable;

signal crop_collected(crop_node);

#
# Exports
#
export(String, "tomato", "carrot", "beet", "zucchini") var type;
export(float) var grow_time = 1.0;
export(int) var min_value := 1;
export(int) var max_value := 3;

## Random Number Generator
onready var _rng := RandomNumberGenerator.new();

#
# Variables
#
var value;

#
# Make upgrades actually do stuff
#
func _ready() -> void:
	## Generate crop value
	_rng.randomize();
	value = _rng.randi_range(
		min_value + GameData.upgrade_data[type]["rich-soil"] / 2,
		max_value + GameData.upgrade_data[type]["rich-soil"]
	);

#
# Interact logic
#
func interact() -> void:
	GameData.add_crop(type, value);
	emit_signal("crop_collected", self);

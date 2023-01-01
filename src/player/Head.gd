class_name PlayerHead extends Spatial;

#
# Data
#
onready var cursor_dict := {
	"default": preload("res://dat/ui/crosshairs/default.png"),
	"interact": preload("res://dat/ui/crosshairs/interact.png"),
	"plant": preload("res://dat/ui/crosshairs/plant.png"),
	"collect": preload("res://dat/ui/crosshairs/collect.png"),
};

#
# Node References
#
onready var crosshair := $Camera/Crosshair;



#
# Update the player's crosshair
#
func update_crosshair(type: String = "default") -> void:
	if crosshair.get_texture() != cursor_dict[type]:
		crosshair.set_texture(cursor_dict[type]);

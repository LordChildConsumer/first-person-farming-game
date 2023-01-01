class_name Interactable extends StaticBody;

#
# Exports
#
export(bool) var _enabled := true setget set_enabled, is_enabled;
export(bool) var _one_shot := false;
export(String) var _interact_text := "" setget set_interact_text, get_interact_text

export(String, "default", "interact", "plant", "collect") var _crosshair = "default";

#
# Interact (will be overridden)
#
func interact() -> void:
	pass;


#########################
### Setters & Getters ###
#########################

#
# Enabled/Disabled
#
func set_enabled(value: bool) -> void:
	_enabled = value;
func is_enabled() -> bool:
	return _enabled;

#
# Interaction Text
#
func set_interact_text(value: String) -> void:
	_interact_text = value;
func get_interact_text() -> String:
	return _interact_text;

#
# Crosshair type
#
func get_crosshair() -> String:
	return _crosshair;

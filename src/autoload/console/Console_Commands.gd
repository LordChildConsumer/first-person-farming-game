extends Node

enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}
# Node References


# Constants
const valid_commands = [
	#["command", [ARG_TYPE, ARG_TYPE],
	["help", [], "Shows the full list of commands"],
	["upgrade", [ARG_STRING, ARG_STRING, ARG_INT], "Give yourself an upgrade. (ex: upgrade tomato rich-soil 1)"]
]

# Variables


# -----------------------
# --- Godot Functions ---
# -----------------------

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	pass


# ------------------------
# --- Custom Functions ---
# ------------------------

func help():
	var help_list = "Command List\n\n"
	for c in valid_commands:
		help_list += "%s | %s\n" % [c[0], c[2]]
	
	return help_list

func upgrade(crop, upgrade, value):
	if not crop in GameData.upgrade_data:
		return "Crop: '%s' not found." % crop;
	if not upgrade in GameData.upgrade_data[crop]:
		return "Upgrade: '%s' not found in '%s'" % [upgrade, crop];
	
	GameData.upgrade_data[crop][upgrade] = value.to_int();
	return "Set '%s/%s' equal to %s." % [crop, upgrade, value]; 

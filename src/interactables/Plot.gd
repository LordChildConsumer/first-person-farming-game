class_name Plot extends Interactable;

### General TODOs ###
# TODO: Add support for upgrades like in the original

#
# Exports
#
export(PackedScene) var _crop;

#
# Node/Scene References
#
onready var _timer := $Timer;
onready var _crop_point := $CropPoint;
onready var _plant_fx := $PlantEffects;
onready var _collect_fx := $CropPoint/CollectEffects;
onready var _anim := $AnimationPlayer;


#
# Variables
#

#
# Do some basic set up once everything is loaded
func _ready() -> void:
	## Free the mesh since that's just so I can see it in the editor
	get_node("MeshInstance").queue_free();


#
# When the player plants the crop
#
func plant_crop() -> void:
	set_enabled(false);
	_plant_fx.set_emitting(true);
	
	## Create an instance of the crop
	var new_crop: Spatial = _crop.instance();
	
	print("Growtime: %s\nNew Growtime: %s" % [new_crop.grow_time, new_crop.grow_time / (1.0 + GameData.upgrade_data[new_crop.type]["fast-grow"])])
	
	_timer.start(
		new_crop.grow_time / (1.0 + GameData.upgrade_data[new_crop.type]["fast-grow"])
	);
	yield(_timer, "timeout");
	
	spawn_crop(new_crop);
	

#
# Show the crop when needed
#
func spawn_crop(new_crop) -> void:
	_crop_point.add_child(new_crop);
	
	new_crop.connect("crop_collected", self, "_on_Crop_Collected");
	
	_anim.play("spin_crop");

#
# Collect the crop
#
func _on_Crop_Collected(crop_node: Crop) -> void:
	crop_node.disconnect("crop_collected", self, "_on_Crop_Collected");
	
	_anim.stop(true);
	
	_collect_fx.set_emitting(true);
	
	crop_node.queue_free();
	
	set_enabled(true);

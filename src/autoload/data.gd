extends Node


#################
### Crop Data ###
#################

var crop_data: Dictionary = {
	"tomato": 0,
	"carrot": 0,
	"beet": 0,
	"zucchini": 0
};

func add_crop(type: String, value: int) -> void:
	crop_data[type] += value;
func sub_crop(type: String, value: int) -> void:
	crop_data[type] -= value;
func get_crop_count(type: String) -> int:
	return crop_data[type];


####################
### Upgrade Data ###
####################

#
# Rich Soil - More per harvest
# 
var upgrade_data: Dictionary = {
	"tomato": {
		"rich-soil": 0,
		"fast-grow": 0,
	},
	"carrot": {
		"rich-soil": 0,
		"fast-grow": 0,
	},
	"beet": {
		"rich-soil": 0,
		"fast-grow": 0,
	},
	"zucchini": {
		"rich-soil": 0,
		"fast-grow": 0,
	},
};

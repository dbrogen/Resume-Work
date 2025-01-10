class_name QuestBuilding
extends Node2D

## Contains the instance of the interatable scene
@onready var interactable: Interactable = $interactable

## Called when the node enters the scene tree for the first time.
## Sets the interact function to the enter function
func _ready() -> void:
	interactable.interact = enter;


## Sets the scene to the quest room scene
func enter():
	get_tree().change_scene_to_file("res://Ground Levels/Levels/quest_room.tscn")

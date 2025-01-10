class_name QuestRoom
extends Node2D

## Contains the instance of the interatable scene
@onready var interactable: Interactable = $interactable

## Gives the worlds gravity
var world_gravity = 1

## Called when the node enters the scene tree for the first time.
## Sets the interact funnction to leave()
func _ready() -> void:
	interactable.interact = leave;

## Changes the scene to the quest ground scene (main quest world scene)
func leave():
	get_tree().change_scene_to_file("res://Ground Levels/Levels/quest_ground.tscn");

## The function for the player to inherit the world's gravity
func _get_gravity() -> float:
	print("Gravity set to ", world_gravity);
	return world_gravity;

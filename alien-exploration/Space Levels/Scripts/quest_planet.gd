class_name QuestPlanet
extends Node2D

## Contains the instance of the interatable scene
@onready var interactable: Interactable = $interactable

## Called when the node enters the scene tree for the first time.
## Sets the interact function to the dock function
func _ready() -> void:
	interactable.interact = _dock;

## Changes the scene to the quest planet's main scene
func _dock() -> void:
	print("Docking")
	get_tree().change_scene_to_file("res://Ground Levels/Levels/quest_ground.tscn");

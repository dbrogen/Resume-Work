class_name SpacePlanet2
extends Node2D

## Contains the instance of the interatable scene
@onready var interactable: Interactable = $interactable

## Called when the node enters the scene tree for the first time.
## Sets the interact function to the land function
func _ready() -> void:
	interactable.interact = _land;

## Changes the scene to planet two's main scene
func _land():
	get_tree().change_scene_to_file("res://Ground Levels/Levels/planet_2.tscn")

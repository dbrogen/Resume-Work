class_name Chests
extends Node2D

## Contains the instance of the interatable scene
@onready var interactable: Interactable = $interactable

## Called when the node enters the scene tree for the first time.
## Sets the proper Chest sprite and assigns the open_chest fuction for when the player interacts with the chest
func _ready() -> void:
	$"Open Chest".hide();
	$"Closed Chest".show();
	interactable.interact = Callable(_open_chest);

## Changes the sprite visibililty based on the player's interaction
func _open_chest():
	$"Open Chest".show();
	$"Closed Chest".hide();

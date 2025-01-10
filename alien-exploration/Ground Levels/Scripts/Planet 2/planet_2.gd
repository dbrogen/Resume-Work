class_name Planet2
extends Node2D

# contains the gravity of the origin planet
var world_gravity = 1; 

## Function for the player to inherit the planet's gravity
func _get_gravity() -> float:
	print("Gravity set to ", world_gravity);
	return world_gravity; 

## Changes the scene to the space scene when the change box is entered
func _on_rocket_space_scene() -> void:
	print("Change Scene to Space");
	get_tree().change_scene_to_file("res://Space Levels/space.tscn");

## Restarts the scene when the player dies
func _on_player_dead() -> void:
	get_tree().change_scene_to_file("res://Ground Levels/Levels/planet_2.tscn");

class_name QuestGround
extends Node2D

## Contains the world's gravity
var world_gravity = 1;

## The function for the player to inherit the world's gravity
func _get_gravity() -> float:
	print("Gravity set to ", world_gravity);
	return world_gravity;

## When the rocket reaches the change scene box it sets the scene to the space scene
func _on_change_scene_box_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Space Levels/space.tscn");

## When the player enters the death zone the player dies and the scene reloads
func _on_death_zone_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		get_tree().reload_current_scene();

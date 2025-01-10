class_name InteractionManager
extends Node2D

## Instances the interact label node from the scene tree
@onready var interact_label:Label = $InteractLabel

## Array containing the available interactions
var current_interactions:Array  = []
## Boolean containing if the player can interact with the object
var can_interact: bool = true;

## Handles the input of the interaction for when a player interacts with an object
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("interact") and can_interact):
		if(current_interactions):
			can_interact = false;
			interact_label.hide();
			
			await(current_interactions[0].interact.call());
			
			can_interact = true;

## When the player gets near an object that is interactable its reveals the label
func _process(_delta: float) -> void:
	if(current_interactions and can_interact):
		current_interactions.sort_custom(_sort_by_nearest);
		if(current_interactions[0].is_interactable):
			interact_label.text = current_interactions[0].interact_name;
			interact_label.show();
	else:
		interact_label.hide();

## When an interactable area is entered it adds the object to the back of the array
func _on_interact_range_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)

## When the interactable area is exited it is removed from the array
func _on_interact_range_area_exited(area: Area2D) -> void:
	current_interactions.erase(area);

## Sorts the available objects by the nearest object to the player
func _sort_by_nearest(area1, area2):
	var area1_distance = global_position.distance_to(area1.global_position);
	var area2_distance = global_position.distance_to(area2.global_position);
	
	return area1_distance < area2_distance;

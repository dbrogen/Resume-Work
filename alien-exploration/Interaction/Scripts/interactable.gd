class_name Interactable
extends Area2D

## The interactable area's callable name
@export var interact_name: String = "";
## The interactable area's callable boolean check
@export var is_interactable: bool = true;

## The interactable area's base interact function
var interact: Callable = func():
	pass;

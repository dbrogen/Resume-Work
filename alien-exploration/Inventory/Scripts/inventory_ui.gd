class_name InventoryUI
extends Control

##Loads the inventory to the player
@onready var inventory: Inventory = preload("res://Inventory/player_inventory.tres");
##Adds the children of the gridcontainer as the array
@onready var slots: Array = $NinePatchRect/GridContainer.get_children();

##If the inventory is open
var is_open = false

## Connects the update slots signal to the ui and calls the update and hiding the inventory from the viewport
func _ready() -> void:
	inventory.update.connect(update_slots);
	update_slots();
	close();

## If the inventory input is pressed open or close it accordingly
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Inventory")):
		if(is_open):
			close();
		else:
			open();

## Displays the inventory ui to the viewport 
func open():
	self.visible = true;
	is_open = true;

## Hides the inventory ui from the viewport	
func close():
	self.visible = false;
	is_open = false;
	
## Updates the slots of the inventory
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i]);

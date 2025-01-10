extends Resource
class_name Inventory

## An array of inventory slots
@export var slots: Array [Inventory_Slot]

## Signals when to update the inventory
signal update;

## The invetory item gets added to the next empty slot of the inventory
func insert(item: Inventory_Item):
	var item_slots = slots.filter(func(slot): return slot.item == item);
	if(not item_slots.is_empty()):
		item_slots[0].amount += 1;
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if(not empty_slots.is_empty()):
			empty_slots[0].item = item;
			empty_slots[0].amount = 1;
	update.emit();

## The inventory gets cleared of all items in the inventory
func clear():
	var item_slots = slots.filter(func(slot): return slot.item);
	for item in item_slots:
		if(not item_slots.is_empty()):
			item.amount = 0;
			item.item = null;

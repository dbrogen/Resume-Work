class_name CollectionChannel
extends Object

##Indicated an Item is collected
@warning_ignore("unused_signal")
signal item_collected(item: Inventory_Item);

##Tells the Quest Journal UI to update
@warning_ignore("unused_signal")
signal update_journal(quest: CollectQuest);

## Checks to see if there is an instance of the channel
func _init():
	assert(_instance == null);

## Checks if there is an instance already and if not creates a new one if so returns the current instance
static func get_instance() -> CollectionChannel:
	if(not _instance):
		_instance = CollectionChannel.new();
	return _instance;

## Contains the channel instance
static var _instance: CollectionChannel = null;

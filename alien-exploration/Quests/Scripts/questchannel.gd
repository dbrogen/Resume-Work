class_name QuestChannel
extends Object


## Indicates that a quest has been accepted and that quest is passed through the signal
@warning_ignore("unused_signal")
signal quest_accepted(quest:Quest)
## Indicates that a quest's objectives have been completed and that quest is passed through the signal
@warning_ignore("unused_signal")
signal quest_completed(quest:Quest)
## Indicates that a quest has been rewarded and closed and that quest is passed through the signal
@warning_ignore("unused_signal")
signal quest_rewarded(quest:Quest)
## Indicates that a quest has been unlocked and that quest is passed through the signal
@warning_ignore("unused_signal")
signal quest_unlocked(quest:Quest)


## Checks to see if there is an instance of the channel
func _init():
	assert(_instance == null)


## Checks if there is an instance already and if not creates a new one if so returns the current instance
static func get_instance() -> QuestChannel:
	if not _instance:
		_instance = QuestChannel.new()
	return _instance


## Contains the channel instance
static var _instance: QuestChannel = null

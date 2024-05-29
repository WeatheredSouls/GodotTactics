extends BattleState

@export var selectUnitState: State
var data: ConversationData

func _ready():
	super()
	data = load("res://Data/Conversations/IntroScene2.tres")

func AddListeners():
	super()
	_owner.conversationController.completeEvent.connect(OnCompleteConversation)

func RemoveListeners():
	super()
	_owner.conversationController.completeEvent.disconnect(OnCompleteConversation)

func Enter():
	super()
	_owner.conversationController.Show(data)

func OnFire(e:int):
	super(e)
	_owner.conversationController.Next()
	
func OnCompleteConversation():
	_owner.stateMachine.ChangeState(selectUnitState)


extends Node
class_name BattleController

@export var board: BoardCreator
@export var inputController: InputController
@export var cameraController: CameraController
@export var conversationController: ConversationController

@export var stateMachine: StateMachine
@export var startState: State

@export var abilityMenuPanelController:AbilityMenuPanelController
@export var statPanelController:StatPanelController

@export var turnOrderController:TurnOrderController
@export var hitSuccessIndicator:HitSuccessIndicator

var turn:Turn = Turn.new()
var units:Array[Unit] = []

var heroPrefab = preload("res://Prefabs/Hero.tscn")

var currentTile:Tile: 
	get: return board.GetTile(board.pos)

func _ready():
	stateMachine.ChangeState(startState)

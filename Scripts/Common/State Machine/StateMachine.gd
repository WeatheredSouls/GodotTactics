class_name StateMachine
extends Node

var _currentState: State

func ChangeState(newState: State) -> void:
	if _currentState == newState:
		return
	
	if _currentState:
		await _currentState.Exit()

	_currentState = newState
	
	if _currentState:
		await _currentState.Enter()

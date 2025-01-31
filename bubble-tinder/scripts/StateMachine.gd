extends Node

var current_state : State
var states : Dictionary = {}

@export var initial_state : State


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		#owner.CURRSTATE = initial_state.name
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		owner.stateFrame += 1
		current_state.Physics_Update(delta)

@rpc("authority", "call_local", "reliable")
func change_state(new_state_name):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state == new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	owner.PREVSTATE = current_state.name
	owner.stateFrame = 1
	new_state.Enter()
	current_state = new_state
	owner.CURRSTATE = new_state.name

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.Exit()
	
	owner.PREVSTATE = current_state.name
	owner.stateFrame = 1
	current_state = new_state
	owner.CURRSTATE = new_state.name
	new_state.Enter()

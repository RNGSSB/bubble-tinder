extends Node2D

@onready var stateMachine = $StateMachine
@export var stateLabel : RichTextLabel
@export var timerLabel : RichTextLabel

@export var PREVSTATE = "Lobby"
@export var CURRSTATE = "Lobby"

var stateFrame = 0
var frameCounter = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	frameCounter = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	frameCounter += 1
	timerLabel.text = str(frameCounter)

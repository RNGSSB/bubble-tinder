extends Resource
class_name Character

@export var name = ""
@export var age = 20
@export var description = ""


@export var trait1 = Traits.Traits.FLIRTY
@export var trait2 = Traits.Traits.TOXICO

@export var postive1 = Traits.Traits.POCASPALABRAS
@export var postive2 = Traits.Traits.TOXICO

@export var negative1 = Traits.Traits.ALTANERO
@export var negative2 = Traits.Traits.MELOSO

@export var prompts : Array[Prompt] = []

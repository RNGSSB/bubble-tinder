extends Resource
class_name Character

@export var name = ""

enum Traits {FLIRTY, POCASPALABRAS, TOXICO, MELOSO, ALTANERO}

@export var trait1 = Traits.FLIRTY
@export var trait2 = Traits.TOXICO

@export var postive1 = Traits.POCASPALABRAS
@export var postive2 = Traits.TOXICO

@export var negative1 = Traits.ALTANERO
@export var negative2 = Traits.MELOSO

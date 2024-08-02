class_name WeaponResource extends ItemResource

enum WeaponType { MELEE, RANGED }

@export var weapon_type: WeaponType

@export_range(0, 100, 5) var base_damage: int
@export_range(0, 1, 0.1) var strength_modifier: float

@export var ineffective_against: Array[StringName]=  []

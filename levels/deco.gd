extends Sprite3D

export(bool) var is_billboard = true

func _ready():
	var material = SpatialMaterial.new()
	material.albedo_texture = self.texture
	material.params_use_alpha_scissor = true
	if is_billboard:
		material.params_billboard_mode = SpatialMaterial.BILLBOARD_FIXED_Y
	self.material_override = material

extends TextureButton

func _ready():
	var img = texture_normal.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(img)
	texture_click_mask = bitmap

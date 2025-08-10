# HintOverlay.gd
extends ColorRect

var original_color: Color

func _ready():
	original_color = color

func _process(_delta):
	# 获取父节点（Spot）
	var spot = get_parent()
	var has_item = false

	# 检查 Spot 下面的子节点，是否存在 TextureRect 类型（你也可以改成 group 检查）
	for child in spot.get_children():
		if child is TextureRect:
			has_item = true
			break

	# 根据是否有 Item 改变颜色
	if has_item:
		# 设置为透明
		color = Color(original_color.r, original_color.g, original_color.b, 0.0)
	else:
		# 恢复原色
		color = original_color

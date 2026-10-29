extends Control

@onready var PageContainer = $pages
@onready var pageAmount = $pages.get_child_count() - 1
var currentPage = 0

func _on_next_page_button_up() -> void:
	currentPage += 1
	if currentPage > pageAmount:
		currentPage = 0
	
	openPage()

func _on_previous_page_button_up() -> void:
	currentPage -= 1
	if currentPage < 0:
		currentPage = pageAmount
	
	openPage()

func openPage():
	for child in PageContainer.get_children():
		child.visible = false
	
	PageContainer.get_child(currentPage).visible = true

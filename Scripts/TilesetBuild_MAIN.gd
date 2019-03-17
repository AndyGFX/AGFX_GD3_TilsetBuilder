extends Node2D

var Builder =  TilesetBuilder.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Builder.SetTileSize(16,16)
	Builder.SetInputTexture(get_node("UserInput/SpriteInput").get_texture())
	Builder.SetOutputTexture(get_node("UserInput/SpriteOutput").get_texture())
	Builder.Prepare()
	Builder.Build()
	get_node("UserInput/SpriteOutput").texture = Builder.GetResult()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
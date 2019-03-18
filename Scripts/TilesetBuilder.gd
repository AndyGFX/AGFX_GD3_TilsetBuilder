class_name TilesetBuilder

var tile_width:int  = 16
var tile_height:int = 16
var tiles_input_image:Texture = null
var tileset_output_image:Texture = null
var tileset_image : Image = null

var tilset_3x3b = {
		"0,0" : ["11abcd"],
		"1,0" : ["14abcd"],
		"2,0" : ["04abcd"],
		"3,0" : ["14ac","04bd"],
		"4,0" : ["03abcd"],
		"5,0" : ["14ab","03cd"],
		"6,0" : ["04ab","03cd"],
		"7,0" : ["14ac","04b","03d"],
		"0,1" : ["13abcd"],
		"1,1" : ["14ab","13cd"],
		"2,1" : ["13ac","04bd"],
		"3,1" : ["14a","13d","04bd"],
		"4,1" : ["13ac","03bd"],
		"5,1" : ["14a","13c","03bd"],
		"6,1" : ["04ab","13c","03d"],
		"7,1" : ["14a","04b","13c","03d"]
	}
#--------------------------------------------------------------------
# Set tile size
#--------------------------------------------------------------------
func SetTileSize(w:int, h:int) -> void:
	self.tile_width = w
	self.tile_height = h

#--------------------------------------------------------------------
# SET Input TEXTURE
#--------------------------------------------------------------------
func SetInputTexture(img_in:Texture)->void:
	self.tiles_input_image = img_in
	self.tileset_image = Image.new()

func SetOutputTexture(img_out:Texture)->void:
	self.tileset_output_image = img_out
	
	
#--------------------------------------------------------------------
# Prepare data
#--------------------------------------------------------------------
func Prepare() -> void:
	
	# create output image
	#self.tileset_output_image = ImageTexture.new()	
	#self.tileset_image.create(8*self.tile_width,6*self.tile_height,false,Image.FORMAT_RGBA8)
	self.tileset_image = self.tileset_output_image.get_data()
	# set output texture from image
	#self.tileset_output_image.create_from_image(self.tileset_image)

#--------------------------------------------------------------------
# Decode x or y position 
#--------------------------------------------------------------------
func _DecodePosition(val) -> int:
	
	match val:
		"0" : return self.tile_width*0
		"1" : return self.tile_width*1
		"2" : return self.tile_width*2
		"3" : return self.tile_width*3
		"4" : return self.tile_width*4
	
	return -1

#--------------------------------------------------------------------
# Decode sub tile position
#--------------------------------------------------------------------
func _DecodeSubPosition(val) -> Vector2:
	
	var sub_size = Vector2(self.tile_width /2,self.tile_height / 2)
	
	match val:
		"a" : return Vector2(sub_size.x*0,sub_size.y*0)
		"b" : return Vector2(sub_size.x*1,sub_size.y*0)
		"c" : return Vector2(sub_size.x*0,sub_size.y*1)
		"d" : return Vector2(sub_size.x*1,sub_size.y*1)
		
	return Vector2(0,0)

#--------------------------------------------------------------------
# BUILD
#--------------------------------------------------------------------
func Build():
	
	self.tileset_image.blit_rect(self.tiles_input_image.get_data(),Rect2(0,0,16,16),Vector2(0,0))
	pass

#--------------------------------------------------------------------
# Tilset RESULT
#--------------------------------------------------------------------
func GetResult() -> ImageTexture:
	var itex = ImageTexture.new()    
	itex.set_storage(ImageTexture.STORAGE_RAW)
	itex.create_from_image(self.tileset_image,0)	
	return itex
class_name TilesetBuilder

var tile_width:int  = 16
var tile_height:int = 16
var tiles_input_image:Image = null
var tiles_input_imagename = "undefined"
var tileset_image : Image = null
var tileset_name : String = "Base"
var tileset_output_name : String = "DefaultTileset"
var _debug:bool = false
var tileset_template_3x3M_16x16p = TileSet.new()
var tileset_id = 0
var _tileset_folder = "res://TileSet"
var _spritesheet_folder = "res://TileSet_Spritesheet"
var _directory = Directory.new()

var tileset_template = {
		"0,0" : ["11abcd"],
		"1,0" : ["14abcd"],
		"2,0" : ["04abcd"],
		"3,0" : ["14ac","04bd"],
		"4,0" : ["03abcd"],
		"5,0" : ["14a","02b","20c","03d"],
		"6,0" : ["04ab","03cd"],
		"7,0" : ["14a","04b","20c","03d"],
		"0,1" : ["13abcd"],
		"1,1" : ["14ab","13cd"],
		"2,1" : ["22a","13c","04b","00d"],
		"3,1" : ["14a","13c","04b","00d"],
		"4,1" : ["13ac","03bd"],
		"5,1" : ["14a","02b","13c","03d"],
		"6,1" : ["22a","04b","13c","03d"],
		"7,1" : ["14a","04b","13c","03d"],
		"0,2" : ["01abcd"],
		"1,2" : ["01ac","04b","00d"],
		"2,2" : ["01ac","02b","03d"],
		"3,2" : ["01ac","04b","03d"],
		"4,2" : ["10abcd"],
		"5,2" : ["10ab","20c","03d"],
		"6,2" : ["10ab","13c","00d"],
		"7,2" : ["10ab","13c","03d"],
		"0,3" : ["21abcd"],
		"1,3" : ["22a","13c","21bd"],
		"2,3" : ["14a","20c","21bd"],
		"3,3" : ["14a","13c","21bd"],
		"4,3" : ["12abcd"],
		"5,3" : ["14a","02b","12cd"],
		"6,3" : ["04b","22a","12cd"],
		"7,3" : ["14a","04b","12cd"],
		"0,4" : ["01ac","21bd"],
		"1,4" : ["10ab","12cd"],
		"2,4" : ["00abcd"],
		"3,4" : ["00abcd","03d"],
		"4,4" : ["20abcd"],
		"5,4" : ["20abcd","13c"],
		"6,4" : ["22abcd"],
		"7,4" : ["22abcd","14a"],
		"0,5" : ["02abcd"],
		"1,5" : ["02abcd","04b"],
		"2,5" : ["00ac","20bd"],
		"3,5" : ["00ab","02cd"],
		"4,5" : ["02ac","22bd"],
		"5,5" : ["20ab","22cd"],
		"6,5" : ["00a","20b","02c","22d"],
		"7,5" : ["24abcd"]
		
	}

# UNITY
# reorder tile for: https://pandaroo.itch.io/tilemap-auto-rule-tile-unity-template
var tileset_ruletile_w = 7
var tileset_ruletile_h = 7
var tileset_ruletile = {
		"0,0" : [2,4],
		"1,0" : [4,2],
		"2,0" : [4,4],
		"3,0" : [2,5],
		"4,0" : [4,0],
		"5,0" : [0,1],
		"6,0" : [3,0],
		"0,1" : [0,2],
		"1,1" : [0,0],
		"2,1" : [0,3],
		"3,1" : [0,4],
		"4,1" : [2,0],
		"5,1" : [1,0],
		"6,1" : [1,1],
		"0,2" : [0,5],
		"1,2" : [4,3],
		"2,2" : [6,4],
		"3,2" : [4,5],
		"4,2" : [7,0],
		"5,2" : [5,1],
		"6,2" : [6,0],
		"0,3" : [3,5],
		"1,3" : [1,4],
		"2,3" : [5,5],
		"3,3" : [6,5],
		"4,3" : [6,1],
		"5,3" : [3,1],
		"6,3" : [4,1],
		"0,4" : [2,2],
		"1,4" : [1,3],
		"2,4" : [5,2],
		"3,4" : [6,2],
		"4,4" : [3,4],
		"5,4" : [7,2],
		"6,4" : [5,4],
		"0,5" : [1,2],
		"1,5" : [2,3],
		"2,5" : [6,3],
		"3,5" : [5,3],
		"4,5" : [3,2],
		"5,5" : [7,1],
		"6,5" : [3,3],
		"0,6" : [7,5],
		"1,6" : [7,5],
		"2,6" : [2,1],
		"3,6" : [5,0],
		"4,6" : [1,5],
		"5,6" : [7,3],
		"6,6" : [7,4]
		
}

var bitmask = [ Vector2( 0, 0 ), 511, Vector2( 0, 1 ), 447, Vector2( 0, 2 ), 438, Vector2( 0, 3 ), 219, Vector2( 0, 4 ), 146, Vector2( 0, 5 ), 54, Vector2( 1, 0 ), 510, Vector2( 1, 1 ), 446, Vector2( 1, 2 ), 434, Vector2( 1, 3 ), 155, Vector2( 1, 4 ), 56, Vector2( 1, 5 ), 50, Vector2( 2, 0 ), 507, Vector2( 2, 1 ), 443, Vector2( 2, 2 ), 182, Vector2( 2, 3 ), 218, Vector2( 2, 4 ), 432, Vector2( 2, 5 ), 144, Vector2( 3, 0 ), 506, Vector2( 3, 1 ), 442, Vector2( 3, 2 ), 178, Vector2( 3, 3 ), 154, Vector2( 3, 4 ), 176, Vector2( 3, 5 ), 48, Vector2( 4, 0 ), 255, Vector2( 4, 1 ), 191, Vector2( 4, 2 ), 504, Vector2( 4, 3 ), 63, Vector2( 4, 4 ), 216, Vector2( 4, 5 ), 18, Vector2( 5, 0 ), 254, Vector2( 5, 1 ), 190, Vector2( 5, 2 ), 248, Vector2( 5, 3 ), 62, Vector2( 5, 4 ), 152, Vector2( 5, 5 ), 24, Vector2( 6, 0 ), 251, Vector2( 6, 1 ), 187, Vector2( 6, 2 ), 440, Vector2( 6, 3 ), 59, Vector2( 6, 4 ), 27, Vector2( 6, 5 ), 16, Vector2( 7, 0 ), 250, Vector2( 7, 1 ), 186, Vector2( 7, 2 ), 184, Vector2( 7, 3 ), 58, Vector2( 7, 4 ), 26, Vector2( 7, 5 ), 511 ] 

var tilset_collision = {
		"0,0" : "none",
		"1,0" : "none",
		"2,0" : "none",
		"3,0" : "none",
		"4,0" : "none",
		"5,0" : "none",
		"6,0" : "none",
		"7,0" : "none",
		"0,1" : "none",
		"1,1" : "none",
		"2,1" : "none",
		"3,1" : "none",
		"4,1" : "none",
		"5,1" : "none",
		"6,1" : "none",
		"7,1" : "none",
		"0,2" : "collision",
		"1,2" : "collision",
		"2,2" : "collision",
		"3,2" : "collision",
		"4,2" : "collision",
		"5,2" : "collision",
		"6,2" : "collision",
		"7,2" : "collision",
		"0,3" : "collision",
		"1,3" : "collision",
		"2,3" : "collision",
		"3,3" : "collision",
		"4,3" : "collision",
		"5,3" : "collision",
		"6,3" : "collision",
		"7,3" : "collision",
		"0,4" : "collision",
		"1,4" : "collision",
		"2,4" : "collision",
		"3,4" : "collision",
		"4,4" : "collision",
		"5,4" : "collision",
		"6,4" : "collision",
		"7,4" : "collision",
		"0,5" : "collision",
		"1,5" : "collision",
		"2,5" : "collision",
		"3,5" : "collision",
		"4,5" : "collision",
		"5,5" : "collision",
		"6,5" : "collision",
		"7,5" : "none"
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
func SetInputImage(img_in:Image)->void:
	self.tiles_input_image = img_in
	self.tileset_image = Image.new()
	self.tiles_input_imagename = img_in.get_name()
	
#--------------------------------------------------------------------
# Prepare data
#--------------------------------------------------------------------
func Prepare() -> void:

	self.tileset_image.create(8*self.tile_width,6*self.tile_height,false,Image.FORMAT_RGBA8)
	
	# create tilset template
	self.tileset_template_3x3M_16x16p.create_tile(self.tileset_id)
	self.tileset_template_3x3M_16x16p.autotile_set_bitmask_mode(self.tileset_id,TileSet.BITMASK_3X3_MINIMAL)
	
	
	for id in range(0,48):
		self.tileset_template_3x3M_16x16p.autotile_set_bitmask(self.tileset_id,bitmask[id*2],bitmask[id*2+1])
		
		
	self.tileset_template_3x3M_16x16p.autotile_set_size(self.tileset_id,Vector2(self.tile_width,self.tile_height))
	
	self.tileset_template_3x3M_16x16p.tile_set_region(self.tileset_id,Rect2( 0, 0, 128, 96 ))
	self.tileset_template_3x3M_16x16p.tile_set_tile_mode(self.tileset_id,TileSet.AUTO_TILE)
	self.tileset_template_3x3M_16x16p.autotile_set_icon_coordinate(self.tileset_id,Vector2( 6, 5 ))
	self.tileset_template_3x3M_16x16p.tile_set_name(self.tileset_id,self.tileset_name)
	
	
	if !self._directory.dir_exists(self._spritesheet_folder):
		self._directory.make_dir(self._spritesheet_folder)
	
	if !self._directory.dir_exists(self._tileset_folder):
		self._directory.make_dir(self._tileset_folder)	
	

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
func Build(collision:bool = false) -> void:
	
	# for all tile in template
	for tile in self.tileset_template:
		if _debug: print(tile)
		
		# for all composed tile from template
		for subtiles in tileset_template[tile]:
			if _debug: print("   :"+subtiles)
			var src_tile_pos:String = subtiles.substr(0,2)
			var src_sub_parts:String = subtiles.substr(2,subtiles.length()-2)
			
			# get tile position in source
			var tx:int = self._DecodePosition(src_tile_pos[0])
			var ty:int = self._DecodePosition(src_tile_pos[1])
			
			# calculate sub tile position 
			for sub_tile in src_sub_parts:
				var sub_pos:Vector2 = self._DecodeSubPosition(sub_tile)
				var read_subtile_at = Vector2(tx,ty)+sub_pos
				if _debug: print (read_subtile_at)
				
				#draw subtile to output image
				
				# calc blit rectangel
				var src_rect:Rect2 = Rect2(read_subtile_at.x,read_subtile_at.y,self.tile_width/2,self.tile_height/2)
				
				# calc dst tile position
				var pos_str:PoolStringArray = tile.split(",")
				var dst_pos:Vector2 = Vector2(sub_pos.x+self.tile_width*int(pos_str[0]),sub_pos.y+self.tile_height*int(pos_str[1]))
				
				# blit subtile to tile
				self.tileset_image.blit_rect(self.tiles_input_image,src_rect,dst_pos)
	
	var spritesheet_resource_path = self.SaveSpriteSheet()	
	var res = load(spritesheet_resource_path)
	
	tileset_template_3x3M_16x16p.tile_set_texture(self.tileset_id,res)
	
	tileset_template_3x3M_16x16p.resource_path = spritesheet_resource_path;
	
	if (collision):
		self.AddCollisionShape()
	pass

#--------------------------------------------------------------------
# Tileset REORDER by user defined scheme and save as new image
#--------------------------------------------------------------------
func ReorderTileset(input_tileset:String,output_tileset_name:String,tile_w:int,tile_h:int,order:Dictionary,w:int,h:int):
	var texture_src:Texture = load(input_tileset)
	var texture_tile_x_count:int = texture_src.get_width()/tile_w
	var texture_tile_y_count:int = texture_src.get_height()/tile_h
	var img_out:Image = Image.new()
	img_out.create(tile_w*w,tile_h*h,false,Image.FORMAT_RGBA8)
	var img_src:Image = texture_src.get_data()
	
	
	
	for x in range(w):
		for y in range(h):
			
			var dst_tile_pos  = order[String(x)+","+String(y)]
			var src_rect:Rect2 = Rect2(dst_tile_pos[0]*tile_w,dst_tile_pos[1]*tile_h,tile_w,tile_h);
			var dst_pos:Vector2 = Vector2(x*tile_w,y*tile_h);
			img_out.blit_rect(img_src,src_rect,dst_pos)
			pass
		pass
	
	img_out.save_png(output_tileset_name)
	
#--------------------------------------------------------------------
# Tileset REORDER by user defined scheme
#--------------------------------------------------------------------
func AddCollisionShape():
	var id:int = 0
	for tile in self.tilset_collision:
		var pos_str:PoolStringArray = tile.split(",")
		var state:String =tilset_collision[tile] 
		var tx:int = int(pos_str[0]) 
		var ty:int = int(pos_str[1])
		if (state=="collision"): 
			var shape = ConvexPolygonShape2D.new()
			shape.points = [Vector2(0,0),Vector2(0,self.tile_height),Vector2(self.tile_width,self.tile_height),Vector2(self.tile_width,0)]
			self.tileset_template_3x3M_16x16p.tile_add_shape(self.tileset_id,shape,Transform2D(0.0,Vector2(0,0)),false,Vector2(tx,ty))
		id=+1;
		pass
		
	pass

#--------------------------------------------------------------------
# Tilset RESULT
#--------------------------------------------------------------------
func GetResult() -> ImageTexture:
	var itex = ImageTexture.new()    
	itex.set_storage(ImageTexture.STORAGE_RAW)
	itex.create_from_image(self.tileset_image,0)
	itex.set_flags(2)
	return itex

#--------------------------------------------------------------------
# Tilset RESULT
#--------------------------------------------------------------------
func SaveSpriteSheet() -> String:
	var itex = ImageTexture.new()    
	itex.set_storage(ImageTexture.STORAGE_RAW)
	itex.create_from_image(self.tileset_image,0)
	itex.set_flags(2)
	var spritesheet_resource_path :String = self._spritesheet_folder+"/"+self.tiles_input_image.get_name()+".png"
	itex.get_data().save_png(spritesheet_resource_path);
	return spritesheet_resource_path
	
#--------------------------------------------------------------------
# Tileset SAVE
#--------------------------------------------------------------------	
func Save():
	
	ResourceSaver.save(self.tileset_output_name, self.tileset_template_3x3M_16x16p,0)
	
	pass


#--------------------------------------------------------------------
# BUILD and SAVE from Image
#--------------------------------------------------------------------
func BuildFromImage(width:int, height:int, src:Image,output_name:String, collision:bool = false):
	
	self.SetTileSize(width,height)	
	self.SetInputImage(src)
	self.tileset_output_name = output_name
	self.Prepare()
	self.Build(collision)
	self.Save()
	pass

#--------------------------------------------------------------------
# BUILD and SAVE from Images, defined as dictionary
#--------------------------------------------------------------------
func BuildFromImages(src_images, output_name:String):
	self.tileset_id = 0
	self.tileset_output_name = output_name
	
	for img in src_images:
		var data = src_images[img]
		self.SetTileSize(data.width,data.height)
		data.src.set_name(data.name+"_spritesheet")
		self.SetInputImage(data.src)
		self.tileset_name = data.name
		self.Prepare()
		self.Build(data.collshape)
		self.tileset_id += 1
		
	self.Save()
	
	pass

#--------------------------------------------------------------------
# BUILD and SAVE from Images, defined as dictionary
#--------------------------------------------------------------------
func BuildFromFile(src_images_definition, output_name:String):
	self.tileset_id = 0
	self.tileset_output_name = output_name
	
	for img in src_images_definition:
		var data = src_images_definition[img]
		var src_img = Image.new()
		src_img.load(data.src)
		data.src = src_img
		self.SetTileSize(data.width,data.height)
		data.src.set_name(data.name+"_spritesheet")
		self.SetInputImage(data.src)
		self.tileset_name = data.name
		self.Prepare()
		self.Build(data.collshape)
		self.tileset_id += 1
		
	self.Save()
	
	pass
	
#--------------------------------------------------------------------
# BUILD and SAVE from Texture
#--------------------------------------------------------------------
func BuildFromTexture(width:int, height:int, src:Texture,output_name:String):
	self.SetTileSize(width,height)
	self.SetInputImage(src.get_data())
	self.tileset_output_name = output_name	
	self.Prepare()
	self.Build()
	self.Save()
	pass

#--------------------------------------------------------------------
# BUILD and SAVE from Sprite node
#--------------------------------------------------------------------
func BuildFromSprite(width:int, height:int, src:Sprite,output_name:String):
	self.SetTileSize(width,height)
	self.SetInputImage(src.get_texture().get_data())
	self.tileset_output_name = output_name
	self.Prepare()
	self.Build()
	self.Save()
	pass	

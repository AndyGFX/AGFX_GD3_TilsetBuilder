# Godot 3.1 Tileset Builder
Create 3x3 MINIMAL tileset from image:

- Input example

![Alt text](Screenshots/AutoTile_1.png?raw=true "PREVIEW")

- Output:

![Alt text](Screenshots/Godot_v3.1-stable_win64_2019-03-18_21-39-47.png?raw=true "PREVIEW")

- Features:
  - build from Image
  - build from Texture
  - build from Sprite
  - user defined tile size
  - save tileset to user defined tres
  - get result as texture


# Usage:

- Example #1
``` python
var image = Image.new()
var Builder =  TilesetBuilder.new()
image.load("res://Sprites/Example/AutoTile_1.png")
Builder.SetTileSize(16,16)
Builder.SetInputImage(image)
Builder.Prepare()
Builder.Build()
Builder.SaveTileset("res://TestTilset_3x3M_16x16pix.tres")
get_node("UserInput/SpriteOutput").texture = Builder.GetResult()
```

- Example #2
``` python
var image = Image.new()
var Builder =  TilesetBuilder.new()
image.load("res://Sprites/Example/AutoTile_1.png")
Builder.BuildFromImage(16,16,image,"res://TestTilset_3x3M_16x16pix.tres")
```
- Example #3
``` python
var Builder =  TilesetBuilder.new()
Builder.BuildFromTexture(16,16,get_node("UserInput/SpriteInput").get_texture(),"res://TestTilset_3x3M_16x16pix.tres")
```
- Example #4
``` python
var Builder =  TilesetBuilder.new()
Builder.BuildFromSprite(16,16,get_node("UserInput/SpriteInput"),"res://TestTilset_3x3M_16x16pix.tres")
```

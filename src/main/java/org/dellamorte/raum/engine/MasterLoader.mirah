/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.engine
import DisplayMgr
import Loader
import MasterRenderer
#import OBJLoader
import EntityRenderer
import TerrainRenderer
import java.util.Random
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.entities.Entity
import org.dellamorte.raum.entities.Light
import org.dellamorte.raum.entities.Player
import org.dellamorte.raum.guis.GuiTexture
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.models.TexturedModel
import org.dellamorte.raum.objConverter.ModelData
import org.dellamorte.raum.objConverter.OBJFileLoader
import org.dellamorte.raum.objConverter.Vertex
import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderModel
import org.dellamorte.raum.shaders.ShaderTerrain
import org.dellamorte.raum.terrains.Terrain
import org.dellamorte.raum.textures.Texture
import org.dellamorte.raum.textures.TerrainTexture
import org.dellamorte.raum.textures.TerrainTexturePack
import org.dellamorte.raum.toolbox.EntityList
import org.dellamorte.raum.toolbox.IList
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.toolbox.MousePicker
import org.dellamorte.raum.toolbox.StrMap
import org.dellamorte.raum.toolbox.TModelBox
import org.dellamorte.raum.toolbox.TModelMap
import org.dellamorte.raum.toolbox.TerrainList
import org.dellamorte.raum.toolbox.V2List
import org.dellamorte.raum.toolbox.V3List
import org.dellamorte.raum.toolbox.LightList
import org.dellamorte.raum.toolbox.StringFontMap
import org.dellamorte.raum.toolbox.StringMap
import org.dellamorte.raum.toolbox.VertexList
import org.dellamorte.raum.toolbox.fontMeshCreator.GUIText
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Vector3f
/**
 *
 * @author Raum
 */
class MasterLoader 
	def initialize():void
		@loader = Loader.new()
    @fonts = StringFontMap.new()
    @tmap = StringMap.new()
    @ents = EntityList.new()
    @terrs = TerrainList.new()
    @lightList = LightList.new()
    @rand = Random.new()
    @renderer = MasterRenderer.new(@loader)
  end
  
  def loadPlayer(model:String, texture:String, x:Double, z:Double):void
    @player = Player.new(getTModel(model, texture), 0, Vector3f.new(x.floatValue, 0, z.floatValue), 0, float(180.0), 0, float(1.0))
    @camera = Camera.new(@player)
    @picker = MousePicker.new(@camera, @renderer.getProjectionMatrix(), @terrs)
  end
  
  def mousePicker():MousePicker
    @picker
  end
  
  def loader():Loader
    @loader
  end
  
  def update():void
    @player.move(@terrs)
    @camera.move()
    @picker.update()
  end
  
  def renderScene():void
    update()
    @renderer.renderScene(self)
  end
  
  def cleanUp():void
    @renderer.cleanUp()
    @loader.cleanUp()
  end
  
  def rand():Random
    @rand
  end
  
  def player():Player
    @player
  end
  
  def camera():Camera
    @camera
  end
  
  def entities():EntityList
    @ents
  end
  
  def addEntity(entity:Entity):void
    @ents.add(entity)
  end
  
  def terrains():TerrainList
    @terrs
  end
  
  def addTerrain(terrain:Terrain):void
    @terrs.add(terrain)
  end
  
  def lights():LightList
    @lightList
  end
  
  def addLight(pos1:Double, pos2:Double, pos3:Double, color1:Double, color2:Double, color3:Double, 
      atten1:Double, atten2:Double, atten3:Double):void
    @lightList.add(Light.new(Vector3f.new(pos1.floatValue(), pos2.floatValue(), pos3.floatValue()), 
                             Vector3f.new(color1.floatValue(), color2.floatValue(), color3.floatValue()), 
                             Vector3f.new(atten1.floatValue(), atten2.floatValue(), atten3.floatValue())))
  end
  
  def addLight(pos1:Double, pos2:Double, pos3:Double, color1:Double, color2:Double, color3:Double):void
    addLight(pos1, pos2, pos3, color1, color2, color3, 1.0, 0.0, 0.0)
  end
	
  def addTexture(fname:String):void
    @tmap.add(fname, @loader.loadTexture(fname))
  end
	
  def addFont(fname:String):void
    @fonts.add(fname)
  end
  
  def getTexture(fname:String):int
    out = @tmap.get(fname)
    return out.intValue if (out != nil)
    return -1
  end
  
  def getFont(fontName:String):int
    getTexture(fontName)
  end
  
	def getModel(objName:String):RawModel
		data = OBJFileLoader.loadOBJ(objName)
		@loader.loadToVAO(data.getVertices, data.getTextureCoords, data.getNormals, data.getIndices)
	end
	
	def getTModel(objName:String, textureName:String, trans:boolean, fakeLt:boolean, 
			textureRows:int, shineDamper:Double, reflectivity:Double):TexturedModel
    model = getModel(objName)
		tID = getTexture(textureName)
    texture = Texture.new(tID)
		texture.setShineDamper(shineDamper.floatValue())
		texture.setReflectivity(reflectivity.floatValue())
		texture.setTransparency(trans)
		texture.setUseFakeLighting(fakeLt)
		texture.setNumberOfRows(textureRows)
		return TexturedModel.new(model, texture)
	end
	
	def getTModel(objName:String, textureName:String, textureRows:int, shineDamper:Double, reflectivity:Double):TexturedModel
    return getTModel(objName, textureName, false, false, textureRows, shineDamper, reflectivity)
	end
	
	def getTModel(objName:String, textureName:String, trans:boolean, fakeLt:boolean, textureRows:int):TexturedModel
    return getTModel(objName, textureName, trans, fakeLt, textureRows, 1.0, 0.0)
	end
	
	def getTModel(objName:String, textureName:String, trans:boolean, fakeLt:boolean):TexturedModel
    return getTModel(objName, textureName, trans, fakeLt, 1, 1.0, 0.0)
	end
	
	def getTModel(objName:String, textureName:String, textureRows:int):TexturedModel
    return getTModel(objName, textureName, false, false, textureRows, 1.0, 0.0)
	end
	
	def getTModel(objName:String, textureName:String):TexturedModel
    return getTModel(objName, textureName, false, false, 1, 1.0, 0.0)
	end
	
	def genTerrainTexture(file:String):TerrainTexture
    TerrainTexture.new(getTexture(file))
	end
	
	def genTerrainTexturePack(bg:String, r:String, g:String, b:String):TerrainTexturePack
		TerrainTexturePack.new(genTerrainTexture(bg), genTerrainTexture(r),
			                     genTerrainTexture(g),  genTerrainTexture(b))
  end
  
  def getGuiTexture(texture:String, a:Double, b:Double, c:Double, d:Double):GuiTexture
    return GuiTexture.new(getTexture(texture), 
      Vector2f.new(a.floatValue(), b.floatValue()), 
      Vector2f.new(c.floatValue(), d.floatValue()))
  end
  
  def getGUIText(text:String, font:String, size:Double, x:Double, y:Double, w:Double, center = false)
    GUIText.new(text, @fonts.get(font), size.floatValue(), Vector2f.new(x.floatValue(), y.floatValue()), w.floatValue(), center)
  end
  
  def randomTerrainVector():Vector3f
    x = float(float(@rand.nextFloat() * float(800.0)) - float(400.0))
    z = float(@rand.nextFloat() * float(-600.0))
    trrn = @terrs.getTerrainAt(x, z)
    y = ((trrn == nil) ? float(0.0) : float(trrn.getHeightOfTerrain(x, z)))
    Vector3f.new(x,y,z)
  end
end

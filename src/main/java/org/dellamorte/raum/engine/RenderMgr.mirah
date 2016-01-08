/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.engine

#import java.util.HashMap
#import java.util.List
#import java.util.Map
import Loader
import MasterLoader
import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.entities.Entity
import org.dellamorte.raum.entities.Light
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.models.TexturedModel
import org.dellamorte.raum.render.RenderModel
import org.dellamorte.raum.render.RenderFont
import org.dellamorte.raum.render.RenderSkyBox
import org.dellamorte.raum.render.RenderTerrain
import org.dellamorte.raum.render.RenderWater
import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderModel
import org.dellamorte.raum.shaders.ShaderTerrain
import org.dellamorte.raum.terrains.Terrain
import org.dellamorte.raum.textures.Texture
import org.dellamorte.raum.toolbox.EntityList
import org.dellamorte.raum.toolbox.LightList
import org.dellamorte.raum.toolbox.TModelBox
import org.dellamorte.raum.toolbox.TModelMap
import org.dellamorte.raum.toolbox.TerrainList
import org.dellamorte.raum.toolbox.TerrainList
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector4f
import org.dellamorte.raum.shaders.ShaderWater
import org.dellamorte.raum.entities.TileWater
import org.lwjgl.opengl.GL11

/**
 *
 * @author Raum
 */
class RenderMgr 
  @@fov = float(70.0)
  @@nearPlane = float(0.1)
  @@farPlane = float(1000.0)
  @@red = float(0.5444)
  @@grn = float(0.62)
  @@blu = float(0.69)
  
  
  def self.enableCulling():void
    GL11.glEnable(GL11.GL_CULL_FACE)
    GL11.glCullFace(GL11.GL_BACK)
  end
  
  def self.disableCulling():void
    GL11.glDisable(GL11.GL_CULL_FACE)
  end
  
  def initialize(loader:Loader):void
    RenderMgr.enableCulling()
    createProjectionMatrix()
    @shader = ShaderModel.new()
    @terrainShader = ShaderTerrain.new()
    @waterShader = ShaderWater.new()
    @tmap = TModelMap.new()
    @terrains = TerrainList.new()
    @terrainRenderer = RenderTerrain.new(@terrainShader, @projectionMatrix)
    @waterRenderer = RenderWater.new(loader, @waterShader, @projectionMatrix)
    @renderer = RenderModel.new(@shader, @projectionMatrix)
    @skyRend = RenderSkyBox.new(loader, @projectionMatrix)
  end
  
  def prepare():void
    GL11.glEnable(GL11.GL_DEPTH_TEST)
    GL11.glClear(GL11.GL_COLOR_BUFFER_BIT|GL11.GL_DEPTH_BUFFER_BIT)
    GL11.glClearColor(@@red, @@grn, @@blu, float(1.0))
  end
  
  def render(lights:Light[], camera:Camera, clipPlane:Vector4f):void
    prepare()
    Shader0(@shader).start()
    @shader.loadClipPlane(clipPlane)
    @shader.loadSkyColour(@@red, @@grn, @@blu)
    @shader.loadLights(lights)
    @shader.loadViewMatrix(camera)
    @renderer.render(@tmap)
    Shader0(@shader).stop()
    Shader0(@terrainShader).start()
    @terrainShader.loadClipPlane(clipPlane)
    @terrainShader.loadSkyColour(@@red, @@grn, @@blu)
    @terrainShader.loadLights(lights)
    @terrainShader.loadViewMatrix(camera)
    @terrainRenderer.render(Terrain[].cast(@terrains.array))
    Shader0(@terrainShader).stop()
    @skyRend.render(camera, @@red, @@grn, @@blu)
    @tmap.clear()
    @terrains.clear()
  end
  
  def renderWater(wTiles:TileWater[], camera:Camera):void
    @waterRenderer.render(wTiles, camera)
  end
  
  def renderScene(mload:MasterLoader):void
    mload.terrains.array.each do |ter:Terrain|
      processTerrain(ter)
    end
    mload.entities.array.each do |ent:Entity|
      processEntity(ent)
    end
    processEntity(mload.player)
    render(mload.lights.array, mload.camera, mload.clipPlane)
    renderWater(mload.waterTiles, mload.camera)
  end
  
  def getProjectionMatrix():Matrix4f
    @projectionMatrix
  end
  
  def processTerrain(terrain:Terrain):void
    @terrains.add(terrain)
  end
  
  def processEntity(entity:Entity):void
    model = entity.getModel()
    @tmap.add(model)
    tbox = @tmap.get(model)
    tbox.add(entity)
  end
  
  def cleanUp():void
    Shader0(@shader).cleanUp()
    Shader0(@terrainShader).cleanUp()
  end
  
  def createProjectionMatrix():void
    DisplayMgr.updateWH()
    aspectRatio = float(float(DisplayMgr.getWidth()) / float(DisplayMgr.getHeight()))
    yScale = float(float(1.0) / Math.tan(Math.toRadians((@@fov / float(2.0)))) * aspectRatio)
    xScale = float(yScale / aspectRatio)
    frustumLength = float(@@farPlane - @@nearPlane)
    
    @projectionMatrix = Matrix4f.new()
    @projectionMatrix.m00 = xScale
    @projectionMatrix.m11 = yScale
    @projectionMatrix.m22 = -((@@farPlane + @@nearPlane) / frustumLength)
    @projectionMatrix.m23 = float(-1.0)
    @projectionMatrix.m32 = -(((2 * @@nearPlane) * @@farPlane) / frustumLength)
    @projectionMatrix.m33 = float(0.0)
  end
end


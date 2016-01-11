package org.dellamorte.raum.render

import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.engine.MasterLoader
import org.dellamorte.raum.engine.Loader
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.entities.Light
import org.dellamorte.raum.entities.TileWater
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderWater
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL20
import org.dellamorte.raum.toolbox.FloatArray
import org.lwjgl.opengl.GL13
import org.lwjgl.opengl.GL30

/**
 *
 * @author Raum
 */
class RenderWater 
  def initialize(loader:Loader, shadr:ShaderWater, projectionMatrix:Matrix4f):void
    @quad = RawModel(nil)
    @shdr = shadr
    @moveFactor = float(0.0)
    shader.start()
    shader.connectTextureUnits()
    shader.loadProjectionMatrix(projectionMatrix)
    shader.stop()
    setUpVAO(loader)
  end
  
  def shader():ShaderWater
    @shdr
  end
  
  def shader0():Shader0
    Shader0(@shdr)
  end

  def render(water:TileWater[], lights:Light[], camera:Camera):void # ## Generics: water:List -> WaterTile
    prepareRender(lights, camera)
    water.each do |tile:TileWater|
      modelMatrix = Matrix4f(Maths.createTransformationMatrix( tile.toVector(), 0, 0, 0, TileWater.TILE_SIZE))
      shader.loadModelMatrix(modelMatrix)
      GL11.glDrawArrays(GL11.GL_TRIANGLES, 0, @quad.getVertexCount())
    end
    unbind()
  end

  def prepareRender(lights:Light[], camera:Camera):void
    gameMgr = MasterLoader.gameMgr
    shader0.start()
    shader.loadViewMatrix(camera)
    @moveFactor += float(0.03) * DisplayMgr.getFrameTimeSeconds()
    @moveFactor %= 1
    shader.loadMoveFactor(@moveFactor)
    shader.loadLights(lights)
    GL30.glBindVertexArray(@quad.getVaoID())
    GL20.glEnableVertexAttribArray(0)
    GL13.glActiveTexture(GL13.GL_TEXTURE0)
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, gameMgr.fbWater.getReflectionTexture)
    GL13.glActiveTexture(GL13.GL_TEXTURE1)
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, gameMgr.fbWater.getRefractionTexture)
    GL13.glActiveTexture(GL13.GL_TEXTURE2)
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, gameMgr.getTexture("waterDUDV"))
    GL13.glActiveTexture(GL13.GL_TEXTURE3)
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, gameMgr.getTexture("normalMap"))
  end

  def unbind():void
    GL20.glDisableVertexAttribArray(0)
    GL30.glBindVertexArray(0)
    shader0.stop()
  end

  def setUpVAO(loader:Loader):void
    # Just x and z vectex positions here, y is set to 0 in v.shader
    vertices = FloatArray.gen([-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0])
    @quad = loader.loadToVAO(vertices, 2)
  end
end


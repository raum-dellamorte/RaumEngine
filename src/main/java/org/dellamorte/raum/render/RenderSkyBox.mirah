/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.render

import java.util.List
import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.engine.Loader
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderSkyBox
import org.dellamorte.raum.toolbox.FloatArray
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL13
import org.lwjgl.opengl.GL20
import org.lwjgl.opengl.GL30
/**
 *
 * @author Raum
 */
class RenderSkyBox 
  @@size = 500.0
  @@vertices = FloatArray.gen([
    -@@size,  @@size, -@@size,
    -@@size, -@@size, -@@size,
     @@size, -@@size, -@@size,
     @@size, -@@size, -@@size,
     @@size,  @@size, -@@size,
    -@@size,  @@size, -@@size,
    
    -@@size, -@@size,  @@size,
    -@@size, -@@size, -@@size,
    -@@size,  @@size, -@@size,
    -@@size,  @@size, -@@size,
    -@@size,  @@size,  @@size,
    -@@size, -@@size,  @@size,

     @@size, -@@size, -@@size,
     @@size, -@@size,  @@size,
     @@size,  @@size,  @@size,
     @@size,  @@size,  @@size,
     @@size,  @@size, -@@size,
     @@size, -@@size, -@@size,
     
    -@@size, -@@size,  @@size,
    -@@size,  @@size,  @@size,
     @@size,  @@size,  @@size,
     @@size,  @@size,  @@size,
     @@size, -@@size,  @@size,
    -@@size, -@@size,  @@size,
    
    -@@size,  @@size, -@@size,
     @@size,  @@size, -@@size,
     @@size,  @@size,  @@size,
     @@size,  @@size,  @@size,
    -@@size,  @@size,  @@size,
    -@@size,  @@size, -@@size,
    
    -@@size, -@@size, -@@size,
    -@@size, -@@size,  @@size,
     @@size, -@@size, -@@size,
     @@size, -@@size, -@@size,
    -@@size, -@@size,  @@size,
     @@size, -@@size,  @@size
  ])
  
  def initialize(loader:Loader, projectionMatrix:Matrix4f):void
    @cube = loader.loadToVAO(@@vertices, 3)
    @dtexture = loader.loadCubeMap("day")
    @ntexture = loader.loadCubeMap("night")
    @time = float(0.0)
    @shdr = ShaderSkyBox.new()
    shader0.start
    shader.loadProjectionMatrix(projectionMatrix)
    shader0.stop
  end
  
  def shader():ShaderSkyBox
    @shdr
  end
  
  def shader0():Shader0
    Shader0(@shdr)
  end
  
  def render(camera:Camera, r:float, g:float, b:float):void
    shader0.start
    shader.connectTextureUnits()
    shader.loadViewMatrix(camera)
    shader.loadFogColour(r, g, b)
    GL30.glBindVertexArray(@cube.getVaoID())
    GL20.glEnableVertexAttribArray(0)
    bindTextures()
    GL11.glDrawArrays(GL11.GL_TRIANGLES, 0, @cube.getVertexCount())
    GL20.glDisableVertexAttribArray(0)
    GL30.glBindVertexArray(0)
    shader0.stop
  end
  
  def bindTextures():void
    @time += DisplayMgr.getFrameTimeSeconds() * float(1000.0)
    @time = @time % float(24000.0)
    if ((@time >= 0) && (@time < 5000))
      texture1 = @ntexture
      texture2 = @ntexture
      blendFactor = float(@time) / float(5000.0)
    elsif ((@time >= 5000) && (@time < 8000))
      texture1 = @ntexture
      texture2 = @dtexture
      blendFactor = float(@time - 5000) / float(8000 - 5000)
    elsif ((@time >= 8000) && (@time < 21000))
      texture1 = @dtexture
      texture2 = @dtexture
      blendFactor = float(@time - 8000) / float(21000 - 8000)
    else
      texture1 = @dtexture
      texture2 = @ntexture
      blendFactor = float(@time - 21000) / float(24000 - 21000)
    end
    
    GL13.glActiveTexture(GL13.GL_TEXTURE0)
    GL11.glBindTexture(GL13.GL_TEXTURE_CUBE_MAP, texture1)
    GL13.glActiveTexture(GL13.GL_TEXTURE1)
    GL11.glBindTexture(GL13.GL_TEXTURE_CUBE_MAP, texture2)
    shader.loadBlendFactor(blendFactor)
  end
end


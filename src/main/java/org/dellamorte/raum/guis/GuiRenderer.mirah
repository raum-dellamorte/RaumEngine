/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.guis
import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderGui
import org.dellamorte.raum.entities.Player
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.engine.Loader
import org.dellamorte.raum.engine.MasterLoader
import org.dellamorte.raum.toolbox.FloatArray
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL13
import org.lwjgl.opengl.GL20
import org.dellamorte.raum.toolbox.Maths
import org.lwjgl.opengl.GL30

/**
 *
 * @author Raum
 */
class GuiRenderer 
  @@quad = RawModel(nil)
  
  def initialize(loader:Loader):void
    positions = FloatArray.gen([-1.0,1.0,-1.0,-1.0,1.0,1.0,1.0,-1.0])
    @@quad = loader.loadGui(positions) if (@@quad == nil)
    @shdr = ShaderGui.new()
  end
  
  def render(guis:GuiTexture[]):void
    Shader0(@shdr).start()
    @shdr.loadOffset(0, 0)
    @shdr.loadNumberOfRows(1)
    GL30.glBindVertexArray(@@quad.getVaoID())
    GL20.glEnableVertexAttribArray(0)
    GL11.glEnable(GL11.GL_BLEND)
    GL11.glBlendFunc(GL11.GL_SRC_ALPHA, GL11.GL_ONE_MINUS_SRC_ALPHA)
    GL11.glDisable(GL11.GL_DEPTH_TEST)
    guis.each do |gt:GuiTexture|
      GL13.glActiveTexture(GL13.GL_TEXTURE0)
      GL11.glBindTexture(GL11.GL_TEXTURE_2D, gt.getTextureID())
      matrix = Maths.createTransformationMatrix(gt.getPosition(), gt.getScale())
      @shdr.loadTransformation(matrix)
      GL11.glDrawArrays(GL11.GL_TRIANGLE_STRIP, 0, @@quad.getVertexCount())
    end
    GL11.glEnable(GL11.GL_DEPTH_TEST)
    GL11.glDisable(GL11.GL_BLEND)
    GL20.glDisableVertexAttribArray(0)
    GL30.glBindVertexArray(0)
    Shader0(@shdr).stop()
  end
  
  def cleanUp():void
    Shader0(@shdr).cleanUp()
  end
end


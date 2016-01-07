package org.dellamorte.raum.render

import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderFont
import org.dellamorte.raum.toolbox.fontMeshCreator.GUIText
import org.dellamorte.raum.toolbox.fontMeshCreator.GUITextList
import org.dellamorte.raum.toolbox.fontMeshCreator.FontType
import org.dellamorte.raum.toolbox.fontMeshCreator.FontTypeToGUITextListMap
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL30
import org.lwjgl.opengl.GL20
import org.lwjgl.opengl.GL13

class RenderFont
  def initialize():void
    @shdr = ShaderFont.new()
  end
  
  def render(texts:FontTypeToGUITextListMap):void
    prepare()
    texts.keySet.each do |font:FontType|
      GL13.glActiveTexture(GL13.GL_TEXTURE0)
      GL11.glBindTexture(GL11.GL_TEXTURE_2D, font.getTextureAtlas)
      texts.get(font).array.each do |text:GUIText|
        renderText(text)
      end
    end
    endRendering()
  end
  
  def shader():ShaderFont
    @shdr
  end
  
  def shader0():Shader0
    Shader0(@shdr)
  end

  def cleanUp():void
    shader0.cleanUp()
  end

  def prepare():void
    GL11.glEnable(GL11.GL_BLEND)
    GL11.glBlendFunc(GL11.GL_SRC_ALPHA, GL11.GL_ONE_MINUS_SRC_ALPHA)
    GL11.glDisable(GL11.GL_DEPTH_TEST)
    shader0.start
  end

  def renderText(text:GUIText):void
    GL30.glBindVertexArray(text.getMesh)
    GL20.glEnableVertexAttribArray(0)
    GL20.glEnableVertexAttribArray(1)
    shader.loadColour(text.getColour())
    shader.loadTranslation(text.getPosition())
    GL11.glDrawArrays(GL11.GL_TRIANGLES, 0, text.getVertexCount())
    GL20.glDisableVertexAttribArray(0)
    GL20.glDisableVertexAttribArray(1)
    GL30.glBindVertexArray(0)
  end

  def endRendering():void
    shader0.stop
    GL11.glDisable(GL11.GL_BLEND)
    GL11.glEnable(GL11.GL_DEPTH_TEST)
  end

end

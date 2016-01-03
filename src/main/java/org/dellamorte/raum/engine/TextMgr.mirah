/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.engine

import org.dellamorte.raum.engine.FontRenderer
import org.dellamorte.raum.engine.Loader
import org.dellamorte.raum.toolbox.fontMeshCreator.FontType
import org.dellamorte.raum.toolbox.fontMeshCreator.FontTypeToGUITextListMap
import org.dellamorte.raum.toolbox.fontMeshCreator.GUITextList
import org.dellamorte.raum.toolbox.fontMeshCreator.GUIText


/**
 *
 * @author Raum
 */
class TextMgr 
	def self.init(loader:Loader):void
    @@texts = FontTypeToGUITextListMap.new()
    @@rend = FontRenderer.new()
    @@ldr = loader
    FontType.init(loader)
  end
  
  def self.render():void
    @@rend.render(@@texts)
  end
  
  def self.loadText(text:GUIText):void
    font = text.getFont()
    data = font.loadText(text)
    vao = @@ldr.loadFontToVAO(data.getVertexPositions(), data.getTextureCoords())
    text.setMeshInfo(vao, data.getVertexCount)
    textBatch = @@texts.get(font)
    if (textBatch == nil)
      textBatch = GUITextList.new()
      @@texts.put(font, textBatch)
    end
    textBatch.add(text)
  end
  
  def self.removeText(text:GUIText):void
    textBatch = @@texts.get(text.getFont())
    textBatch.remove(text)
    @@texts.remove(text.getFont()) if textBatch.isEmpty()
  end
  
  def self.cleanUp():void
    @@rend.cleanUp()
  end
end


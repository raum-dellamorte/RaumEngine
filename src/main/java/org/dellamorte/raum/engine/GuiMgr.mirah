package org.dellamorte.raum.guis

import org.dellamorte.raum.toolbox.vector.Vector2f


/**
 *
 * @author Raum
 */
class FgMgr 
  def self.init(loader:Loader):void
    #@@guis = StringToGuiObjMap.new()
    @@rend = RenderGui.new()
    #@@ldr = loader
    #FontType.init(loader)
  end
  
  def self.render():void
    #@@rend.render(@@texts)
  end
  
  def self.loadText(text:GUIText):void
    #font = text.getFont()
    #data = font.loadText(text)
    #vao = @@ldr.loadToVAO(data.getVertexPositions(), data.getTextureCoords())
    #text.setMeshInfo(vao, data.getVertexCount)
    #textBatch = @@texts.get(font)
    #if (textBatch == nil)
    #  textBatch = GUITextList.new()
    #  @@texts.put(font, textBatch)
    #end
    #textBatch.add(text)
  end
  
  def self.removeText(text:GUIText):void
    #textBatch = @@texts.get(text.getFont())
    #textBatch.remove(text)
    #@@texts.remove(text.getFont()) if textBatch.isEmpty()
  end
  
  def self.cleanUp():void
    #@@rend.cleanUp()
  end
  
  def self.translate(x:int, y:int):Vector2f
    nx = (float((float(2.0) / float(1024.0)) * float(x)) - float(1.0))
    ny = -(float((float(2.0) / float(768.0)) * float(y)) - float(1.0))
    return Vector2f.new(nx,ny)
  end
end


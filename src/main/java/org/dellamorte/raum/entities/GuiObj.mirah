package org.dellamorte.raum.entities

import TextureGui
import org.dellamorte.raum.engine.TextMgr
import org.dellamorte.raum.textures.TextureGui
import org.dellamorte.raum.toolbox.GuiTxtrList

/**
 *
 * @author Raum
 */
class GuiObj 
  def initialize():void
    @txtrs = GuiTxtrList.new()
  end
  
  def addTexture(txtr:TextureGui):void
    @txtrs.add(txtr)
  end
  
  def guiTextures():TextureGui[]
    @txtrs.array()
  end
end


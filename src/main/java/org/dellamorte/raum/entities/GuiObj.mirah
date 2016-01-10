package org.dellamorte.raum.entities

import org.dellamorte.raum.engine.MasterLoader
import org.dellamorte.raum.engine.TextMgr
import org.dellamorte.raum.textures.TextureGui
import java.util.List
import org.dellamorte.raum.toolbox.GuiTxtrList

/**
 *
 * @author Raum
 */
class GuiObj 
  attr_accessor x:float
  attr_accessor y:float
  attr_accessor scaleX:float
  attr_accessor scaleY:float
  attr_accessor guiTextures:GuiTxtrList
  
  def initialize(xpos:Double, ypos:Double, scale:Double):void
    @x = xpos.floatValue
    @y = ypos.floatValue
    @scaleX = scale.floatValue
    @scaleY = scale.floatValue
    @guiTextures = GuiTxtrList.new()
    @gMgr = MasterLoader.gameMgr()
  end
  
  def loadTextures(textures:List):void
    textures.each do |txtr:String|
      @guiTextures.add(@gMgr.getTextureGui(txtr, @x, @y, @scaleX, @scaleY))
    end
  end
  
  def add(texture:int):void
    @guiTextures.add(@gMgr.getTextureGui(texture, @x, @y, @scaleX, @scaleY))
  end
  
  def addTexture(txtr:TextureGui):void
    @guiTextures.add(txtr)
  end
  
  def array():TextureGui[]
    @guiTextures.array()
  end
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.guis
import GuiTexture
import org.dellamorte.raum.engine.TextMgr
import org.dellamorte.raum.toolbox.GuiTxtrList

/**
 *
 * @author Raum
 */
class GuiObj 
	def initialize():void
    @txtrs = GuiTxtrList.new()
  end
  
  def addTexture(txtr:GuiTexture):void
    @txtrs.add(txtr)
  end
  
  def guiTextures():GuiTexture[]
    @txtrs.array()
  end
end


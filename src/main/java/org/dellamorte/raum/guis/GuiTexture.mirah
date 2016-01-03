/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.guis
import org.dellamorte.raum.toolbox.vector.Vector2f


/**
 *
 * @author Raum
 */
class GuiTexture 
	def initialize(textureID:int, position:Vector2f, scale2D:Vector2f):void
		@tID = textureID
		@pos = position
		@scale = scale2D
    @origScale = Vector2f.new(scale2D.x, scale2D.y)
	end
	
	def getTextureID():int
		@tID
	end
	
	def getPosition():Vector2f
		@pos
	end
	
	def getScale():Vector2f
		@scale
  end
  
  def setXScale(scale:float):void
    @scale.x = scale
  end
  
  def setXScalePercent(scale:float):void
    @scale.x = float(float(scale / float(100.0)) * @origScale.x)
  end
  
  def setYScale(scale:float):void
    @scale.y = scale
  end
  
  def setYScalePercent(scale:float):void
    @scale.y = float(float(scale / float(100.0))  * @origScale.y)
  end
end


package org.dellamorte.raum.guis

import org.dellamorte.raum.toolbox.vector.Vector2f


/**
 *
 * @author Raum
 */
class FgMgr 
	def initialize():void
    
  end
  
  def addGui():void
    
  end
  
  def translate(x:int, y:int):Vector2f
    nx = (float((float(2.0) / float(1024.0)) * float(x)) - float(1.0))
    ny = -(float((float(2.0) / float(768.0)) * float(y)) - float(1.0))
    return Vector2f.new(nx,ny)
  end
end


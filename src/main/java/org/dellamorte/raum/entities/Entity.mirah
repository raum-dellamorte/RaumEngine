/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.entities
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.models.TexturedModel


/**
 *
 * @author Raum
 */
class Entity 
  def initialize(model:TexturedModel, index:int, position:Vector3f, rotX:float, rotY:float, rotZ:float, scale:float):void
    setup(model, index, position, rotX, rotY, rotZ, scale)
  end
  
#  def initialize(model:TexturedModel, position:Vector3f, rotX:float, rotY:float, rotZ:float, scale:float):void
#    setup(model, 0, position, rotX, rotY, rotZ, scale)
#  end
  
  def setup(model:TexturedModel, index:int, position:Vector3f, rotX:float, rotY:float, rotZ:float, scale:float):void
    @emodel = model
    @epos = position
    @rx = rotX
    @ry = rotY
    @rz = rotZ
    @escale = scale
    @tIndex = index
  end
  
  def getTextureXOffset():float
    num = @emodel.getModelTexture().getNumberOfRows()
    col = @tIndex % num
    return float(float(col) / float(num))
  end
  
  def getTextureYOffset():float
    num = @emodel.getModelTexture().getNumberOfRows()
    row = int(@tIndex / num)
    return float(float(row) / float(num))
  end
  
  def increasePosition(dx:float, dy:float, dz:float):void
    @epos.x += dx
    @epos.y += dy
    @epos.z += dz
  end
  
  def increaseRotation(dx:float, dy:float, dz:float):void
    @rx += dx
    @ry += dy
    @rz += dz
  end
  
  def setModel(model:TexturedModel):void
    @emodel = model
  end
  
  def getModel():TexturedModel
    @emodel
  end
  
  def setPosition(position:Vector3f):void
    @epos = position
  end
  
  def getPosition():Vector3f
    @epos
  end
  
  def setRotX(rotX:float):void
    @rx = rotX
  end
  
  def getRotX():float
    @rx
  end
  
  def setRotY(rotY:float):void
    @ry = rotY
  end
  
  def getRotY():float
    @ry
  end
  
  def setRotZ(rotZ:float):void
    @rz = rotZ
  end
  
  def getRotZ():float
    @rz
  end
  
  def setScale(scale:float):void
    @escale = scale
  end
  
  def getScale():float
    @escale
  end
end


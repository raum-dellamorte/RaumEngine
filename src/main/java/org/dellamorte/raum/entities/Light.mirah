/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.entities
import org.dellamorte.raum.toolbox.vector.Vector3f


/**
 *
 * @author Raum
 */
class Light 
  def initialize(position:Vector3f, colour:Vector3f, attenuation = Vector3f.new(float(1.0), 0, 0)):void
    @pos = position
    @color = colour
    @atten = attenuation
  end
  
  def setAttenuation(attenuation:Vector3f):void
    @atten = attenuation
  end
  
  def getAttenuation():Vector3f
    @atten
  end
  
  def setPosition(position:Vector3f):void
    @pos = position
  end
  
  def getPosition():Vector3f
    @pos
  end
  
  def setColour(colour:Vector3f):void
    @color = colour
  end
  
  def getColour():Vector3f
    @color
  end
end


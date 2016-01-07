/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.textures

/**
 *
 * @author Raum
 */
class Texture 
  def initialize(tID:int):void
    @textureID = tID
    @shineDamper = float(1.0)
    @reflectivity = float(0.0)
    @hasTransparency = false
    @useFakeLighting = false
    @numOfRows = 1
  end
  
  def getID():int
    @textureID
  end
  
  def getShineDamper():float
    @shineDamper
  end
  
  def setShineDamper(val:float):void
    @shineDamper = val
  end
  
  def getReflectivity():float
    @reflectivity
  end
  
  def setReflectivity(val:float):void
    @reflectivity = val
  end
  
  def getTransparency():boolean
    @hasTransparency
  end
  
  def setTransparency(bool:boolean):void
    @hasTransparency = bool
  end
  
  def getUseFakeLighting():boolean
    @useFakeLighting
  end
  
  def setUseFakeLighting(bool:boolean):void
    @useFakeLighting = bool
  end
  
  def setNumberOfRows(val:int):void
    @numOfRows = val
  end
  
  def getNumberOfRows():int
    @numOfRows
  end
end


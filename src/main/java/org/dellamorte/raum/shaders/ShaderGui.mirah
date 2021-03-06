/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.shaders

import Shader0
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Matrix4f

/**
 *
 * @author Raum
 */
class ShaderGui < Shader0
  def initialize():void
    super("gui")
  end

  $Override
  def getAllUniformLocations():void
    newLoc("transformationMatrix")
    newLoc("numOfRows")
    newLoc("offset")
  end

  $Override
  def bindAttributes():void
    bindAttribute(0, "position")
  end
  
  def loadNumberOfRows(val:int)
    loadFloat(getLoc("numOfRows"), float(val))
  end
  
  def loadOffset(x:float, y:float):void
    loadVector(getLoc("offset"), Vector2f.new(x,y))
  end
  
  def loadTransformation(matrix:Matrix4f):void
    loadMatrix(getLoc("transformationMatrix"), matrix)
  end
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.models

/**
 *
 * @author Raum
 */
class RawModel 
  #@@vaoID = 0
  #@@vertexCount = 0
  
  def initialize(vaoID:int, vertexCount:int)
    @vaoID = vaoID
    @vertexCount = vertexCount
  end
  
  def getVaoID():int
    @vaoID
  end
  
  def getVertexCount():int
    @vertexCount
  end
end


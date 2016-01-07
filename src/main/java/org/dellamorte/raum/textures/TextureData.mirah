/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.textures

import java.nio.ByteBuffer

/**
 *
 * @author Raum
 */
class TextureData 
  def initialize(buffer:ByteBuffer, width:int, height:int):void
    @buff = buffer
    @w = width
    @h = height
  end
  
  def getWidth():int
    return @w
  end
  
  def getHeight():int
    return @h
  end
  
  def getBuffer():ByteBuffer
    return @buff
  end
end


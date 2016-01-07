/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.textures
import java.io.IOException
import org.lwjgl.BufferUtils
import org.lwjgl.stb.STBImage
import java.nio.ByteBuffer
import java.nio.IntBuffer

/**
 *
 * @author Raum
 */
class Image 
  attr_reader image:ByteBuffer
  attr_reader width:int
  attr_reader height:int
  attr_reader components:int
  
  def initialize(buffer:ByteBuffer):void
    w = IntBuffer(BufferUtils.createIntBuffer(1))
    h = IntBuffer(BufferUtils.createIntBuffer(1))
    c = IntBuffer(BufferUtils.createIntBuffer(1))
    
    @image = STBImage.stbi_load_from_memory(buffer, w, h, c, 0)
    @width = int(w.get(0))
    @height = int(h.get(0))
    @components = int(c.get(0))
    
  end
  
  def dispose():void
    STBImage.stbi_image_free(@image)
  end
end


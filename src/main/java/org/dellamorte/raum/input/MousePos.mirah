/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.input
import org.lwjgl.glfw.GLFWCursorPosCallback


/**
 *
 * @author Raum
 */
class MousePos < GLFWCursorPosCallback
	@@xPos = double(0.0)
	@@yPos = double(0.0)
	@@dx = double(0.0)
	@@dy = double(0.0)
  
  def initialize()
    
  end
  
  $Override
  def invoke(window:long, xpos:double, ypos:double):void
    @@dx = ((@@xPos == double(0.0)) ? double(0.0) : (@@xPos - xpos))
    @@dy = ((@@yPos == double(0.0)) ? double(0.0) : (@@yPos - ypos))
    @@xPos = xpos
    @@yPos = ypos
  end
  
  def self.getX():double
    @@xPos
  end
  
  def self.getY():double
    @@yPos
  end
  
  def self.getDX():double
    out = @@dx
    @@dx = double(0.0)
    return out
  end
  
  def self.getDY():double
    out = @@dy
    @@dy = double(0.0)
    return out
  end
  
end


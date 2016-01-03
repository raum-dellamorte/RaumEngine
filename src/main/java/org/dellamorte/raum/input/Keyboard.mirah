/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.input

import org.lwjgl.glfw.GLFWKeyCallback
import org.lwjgl.glfw.GLFW

/**
 *
 * @author Raum
 */
class Keyboard < GLFWKeyCallback
	@@keys = boolean[65536]
  def initialize()
    
  end
  
  $Override
  def invoke(window:long, key:int, scancode:int, action:int, mods:int):void
    @@keys[key] = action != GLFW.GLFW_RELEASE
  end
  
  def self.isKeyDown(key:int):boolean
    @@keys[key]
  end
end


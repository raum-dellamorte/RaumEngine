/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.input

import org.dellamorte.raum.toolbox.Block
import org.dellamorte.raum.toolbox.StringBlockMap
import org.lwjgl.glfw.GLFW
import org.lwjgl.glfw.GLFWKeyCallback

/**
 *
 * @author Raum
 */
class Keyboard < GLFWKeyCallback
  @@actions = StringBlockMap.new()
  @@keys = boolean[65536]
  def initialize()
    
  end
  
  $Override
  def invoke(window:long, key:int, scancode:int, action:int, mods:int):void
    puts "w" + window + "-k" + key + "-s" + scancode + "-a" + action + "-m" + mods
    @@keys[key] = action != GLFW.GLFW_RELEASE
    runme = @@actions.get("w" + window + "-k" + key + "-a" + action + "-m" + mods)
    runme.run() unless (runme == nil)
  end
  
  def self.addListener(window:long, key:int, action:int, mods:int, block:Block)
    @@actions.add("w" + window + "-k" + key + "-a" + action + "-m" + mods, block)
  end
  
  def self.isKeyDown(key:int):boolean
    @@keys[key]
  end
end


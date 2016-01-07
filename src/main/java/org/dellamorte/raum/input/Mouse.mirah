/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.input

import org.dellamorte.raum.toolbox.Block
import org.dellamorte.raum.toolbox.StringBlockMap
import org.lwjgl.glfw.GLFW
import org.lwjgl.glfw.GLFWMouseButtonCallback
/**
 *
 * @author Raum
 */
class Mouse < GLFWMouseButtonCallback
  @@actions = StringBlockMap.new()
  @@buttons = boolean[12]
  
  def initialize():void
    
  end
  
  $Override
  def invoke(window:long, button:int, action:int, mods:int)
    puts "w" + window + "-b" + button + "-a" + action + "-m" + mods
    @@buttons[button] = (action != GLFW.GLFW_RELEASE)
    runme = @@actions.get("w" + window + "-b" + button + "-a" + action + "-m" + mods)
    runme.run() unless (runme == nil)
  end
  
  def self.addListener(window:long, button:int, action:int, mods:int, block:Block)
    @@actions.add("w" + window + "-b" + button + "-a" + action + "-m" + mods, block)
  end
  
  def self.isButtonDown(btn:int):boolean
    @@buttons[btn]
  end
end


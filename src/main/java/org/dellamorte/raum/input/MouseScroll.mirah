/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.input
import org.lwjgl.glfw.GLFWScrollCallback


/**
 *
 * @author Raum
 */
class MouseScroll < GLFWScrollCallback
  @@scrollAction = MScroll(nil)
  
  def initialize():void
    
  end
  
  $Override
  def invoke(window:long, dx:double, dy:double):void
    @@scrollAction.run(dx, dy) unless (@@scrollAction == nil)
  end
  
  def self.setListener(block:MScroll):void
    @@scrollAction = block
  end
  
end

interface MScroll do
  def run(dx:double, dy:double):void; end
end
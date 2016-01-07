/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.entities

import org.dellamorte.raum.entities.Entity
import org.dellamorte.raum.entities.Player
import org.dellamorte.raum.input.Keyboard
import org.dellamorte.raum.input.Mouse
import org.dellamorte.raum.input.MousePos
import org.dellamorte.raum.input.MouseScroll
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.toolbox.vector.Matrix4f

/**
 *
 * @author Raum
 */
class Camera 
  attr_accessor distanceFromPlayer:float
  
  def initialize(player:Player):void
    @pos = Vector3f.new(float(0.0),float(5.0),float(0.0))
    @pitch = float(20.0)
    @yaw = float(0.0)
    @roll = float(0.0)
    @playr = player
    @distanceFromPlayer = float(30.0)
    @angleAroundPlayer  = float(0.0)
    selfie = self
    MouseScroll.setListener() do |dx:double, dy:double|
      zoomLevel = float(dy * float(0.5))
      Camera(selfie).distanceFromPlayer -= zoomLevel
    end
  end
  
  def move():void
    calcPitch()
    calcAngle()
    calcCamPos()
  end
  
  def getPosition():Vector3f; @pos; end
  def getPitch():float; @pitch; end
  def getYaw():float; @yaw; end
  def getRoll():float; @roll; end
  
  def calcCamPos():void
    hDist = calcHDistance()
    vDist = calcVDistance() + float(10.0)
    theta = @playr.getRotY + @angleAroundPlayer
    xOffset = float(hDist * Math.sin(Math.toRadians(theta)))
    zOffset = float(hDist * Math.cos(Math.toRadians(theta)))
    @pos.x = float(@playr.getPosition().x() - xOffset)
    @pos.z = float(@playr.getPosition().z() - zOffset)
    @pos.y = float(@playr.getPosition().y() + vDist)
    @yaw = float(180.0) - float(@playr.getRotY() + @angleAroundPlayer)
  end
  
  def calcPitch():void
    if (Mouse.isButtonDown(1))
      pitchChange = float(MousePos.getDY() * float(0.1))
      @pitch -= pitchChange
    end
  end
  
  def calcAngle():void
    if (Mouse.isButtonDown(0))
      angleChange = float(MousePos.getDX() * float(0.3))
      @angleAroundPlayer -= angleChange
    end
  end
  
  def calcHDistance():float
    float(@distanceFromPlayer * float(Math.cos(Math.toRadians(@pitch))))
  end
  
  def calcVDistance():float
    float(@distanceFromPlayer * float(Math.sin(Math.toRadians(@pitch))))
  end
end


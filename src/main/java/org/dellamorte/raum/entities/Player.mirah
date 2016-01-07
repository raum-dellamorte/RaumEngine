/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.entities
import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.input.Keyboard
import org.dellamorte.raum.models.TexturedModel
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.terrains.Terrain
import org.dellamorte.raum.toolbox.TerrainList
import org.dellamorte.raum.toolbox.StringFloatMap
import org.lwjgl.glfw.GLFW
import Entity


/**
 *
 * @author Raum
 */
class Player < Entity
  @@runSpeed = float(20.0)
  @@turnSpeed = float(160.0)
  @@gravity = float(-50.0)
  @@jumpPower = float(30.0)
  #@@terrainHt = float(0.0)
  
  def initialize(model:TexturedModel, index:int, position:Vector3f, rotX:float, rotY:float, rotZ:float, scale:float):void
    super(model, index, position, rotX, rotY, rotZ, scale)
    @curSpeed = float(0.0)
    @curTurnSpeed = float(0.0)
    @upwardSpeed = float(0.0)
    @isInAir = false
    @stats = StringFloatMap.new()
    @stats.add("Health", float(100.0))
  end
  
  def getStat(stat:String):float
    val = @stats.get(stat)
    return float(0.0) if (val == nil)
    return val.floatValue()
  end
  
  def setStat(stat:String, newVal:float):void
    @stats.set(stat, newVal)
  end
  
  def incStat(stat:String, amount:float, max = 100):void
    val = @stats.get(stat)
    return if (val == nil)
    newVal = val.floatValue + amount
    newVal = float(max) if (newVal > max)
    @stats.set(stat, newVal)
  end
  
  def decStat(stat:String, amount:float, min = 0):void
    val = @stats.get(stat)
    return if (val == nil)
    newVal = val.floatValue - amount
    newVal = float(min) if (newVal < min)
    @stats.set(stat, newVal)
  end
  
  def isAlive():boolean
    health = @stats.get("Health")
    return true if (health == nil)
    return (health.floatValue() > 0)
  end
  
  def jump():void
    unless @isInAir
      @upwardSpeed = @@jumpPower
      @isInAir = true
    end
  end
  
  def move(terrains:TerrainList):void
    checkInputs()
    rate = DisplayMgr.getFrameTimeSeconds()
    self.increaseRotation(float(0.0), float(@curTurnSpeed * rate), float(0.0))
    distance = float(@curSpeed * rate)
    dx = float(distance * float(Math.sin(Math.toRadians(self.getRotY()))))
    dz = float(distance * float(Math.cos(Math.toRadians(self.getRotY()))))
    self.increasePosition(dx, float(0.0), dz)
    @upwardSpeed += float(@@gravity * rate)
    self.increasePosition(float(0.0), float(@upwardSpeed * rate), float(0.0))
    pos = self.getPosition()
    terrain = terrains.getTerrainAt(pos.x, pos.z)
    terrainHt = ((terrain == nil) ? float(0.0) : terrain.getHeightOfTerrain(pos.x, pos.z))
    if (self.getPosition().y < terrainHt)
      @upwardSpeed = float(0.0)
      @isInAir = false
      self.getPosition().y = terrainHt
    end
  end
  
  def checkInputs():void
    if (Keyboard.isKeyDown(GLFW.GLFW_KEY_W))
      (@curSpeed = @@runSpeed)
    elsif (Keyboard.isKeyDown(GLFW.GLFW_KEY_S))
      (@curSpeed = -@@runSpeed) 
    else
      (@curSpeed = float(0.0))
    end
    if (Keyboard.isKeyDown(GLFW.GLFW_KEY_D))
      (@curTurnSpeed = -@@turnSpeed)
    elsif (Keyboard.isKeyDown(GLFW.GLFW_KEY_A))
      (@curTurnSpeed = @@turnSpeed)
    else
      (@curTurnSpeed = float(0.0))
    end
    jump() if (Keyboard.isKeyDown(GLFW.GLFW_KEY_SPACE))
    if (Keyboard.isKeyDown(GLFW.GLFW_KEY_L))
      incStat("Health", float(1.0))
    elsif (Keyboard.isKeyDown(GLFW.GLFW_KEY_K))
      decStat("Health", float(1.0))
    end
  end
end


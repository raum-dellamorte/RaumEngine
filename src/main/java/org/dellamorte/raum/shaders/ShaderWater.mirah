/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.shaders
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector4f
import org.dellamorte.raum.entities.Light
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.toolbox.Maths


/**
 *
 * @author Raum
 */
class ShaderWater < Shader0
  def self.VERTEX_FILE():String(); "res/opengl/waterVertex.txt"; end
  def self.FRAGMENT_FILE():String(); "res/opengl/waterFragment.txt"; end
  def self.MAX_LIGHTS():int(); 4; end
  def initialize():void
    super(VERTEX_FILE(), FRAGMENT_FILE())
  end

  $Override
  def bindAttributes():void
    bindAttribute(0, "position")
  end

  $Override
  def getAllUniformLocations():void
    newLoc("projectionMatrix")
    newLoc("viewMatrix")
    newLoc("modelMatrix")
    newLoc("reflectionTexture")
    newLoc("refractionTexture")
    newLoc("dudvMap")
    newLoc("normalMap")
    newLoc("moveFactor")
    newLoc("camPos")
    MAX_LIGHTS().times do |i:int|
      newLoc("lightPos[" + i + "]")
      newLoc("lightColour[" + i + "]")
      newLoc("attenuation[" + i + "]")
    end
  end

  def connectTextureUnits():void
    loadInt(getLoc("reflectionTexture"), 0)
    loadInt(getLoc("refractionTexture"), 1)
    loadInt(getLoc("dudvMap"), 2)
    loadInt(getLoc("normalMap"), 3)
  end
  
  def loadMoveFactor(factor:float)
    loadFloat(getLoc("moveFactor"), factor)
  end
  
  def loadLights(lights:Light[])
    l = lights.length()
    MAX_LIGHTS().times do |i:int|
      if (i < l)
        loadVector(getLoc("lightPos[" + i + "]"), lights[i].getPosition())
        loadVector(getLoc("lightColour[" + i + "]"), lights[i].getColour())
        loadVector(getLoc("attenuation[" + i + "]"), lights[i].getAttenuation())
      else
        loadVector(getLoc("lightPos[" + i + "]"), Vector3f.new(0,0,0))
        loadVector(getLoc("lightColour[" + i + "]"), Vector3f.new(0,0,0))
        loadVector(getLoc("attenuation[" + i + "]"), Vector3f.new(float(1.0),0,0))
      end
    end
  end

  def loadProjectionMatrix(projection:Matrix4f):void
    loadMatrix(getLoc("projectionMatrix"), projection)
  end

  def loadViewMatrix(camera:Camera):void
    viewMatrix = Matrix4f(Maths.createViewMatrix(camera))
    loadMatrix(getLoc("viewMatrix"), viewMatrix)
    loadVector(getLoc("camPos"), camera.getPosition)
  end

  def loadModelMatrix(modelMatrix:Matrix4f):void
    loadMatrix(getLoc("modelMatrix"), modelMatrix)
  end
  
end


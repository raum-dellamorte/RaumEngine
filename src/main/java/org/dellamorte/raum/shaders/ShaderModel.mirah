/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.shaders

import Shader0
import java.io.BufferedReader
import java.io.FileReader
import java.nio.FloatBuffer
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.entities.Light
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.toolbox.StrMap
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.lwjgl.BufferUtils
import org.lwjgl.opengl.GL11
import org.dellamorte.raum.toolbox.vector.Vector4f
import org.lwjgl.opengl.GL20


/**
 *
 * @author Raum
 */
class ShaderModel < Shader0
  @@maxLights = 4
  
  def initialize():void
    super("model")
    puts "new ShaderOne"
  end
  
  $Override
  def bindAttributes():void
    #puts "bindAttributes " + programID()
    bindAttribute(0, "position")
    bindAttribute(1, "textureCoords")
  end
  
  $Override
  def getAllUniformLocations():void
    newLoc("transformationMatrix")
    newLoc("projectionMatrix")
    newLoc("viewMatrix")
    newLoc("shineDamper")
    newLoc("reflectivity")
    newLoc("useFakeLighting")
    newLoc("skyColour")
    newLoc("numOfRows")
    newLoc("offset")
    newLoc("plane")
    @@maxLights.times do |i:int|
      newLoc("lightPosition[" + i + "]")
      newLoc("lightColour[" + i + "]")
      newLoc("attenuation[" + i + "]")
    end
  end
  
  def loadNumberOfRows(val:int)
    loadFloat(getLoc("numOfRows"), float(val))
  end
  
  def loadOffset(x:float, y:float):void
    loadVector(getLoc("offset"), Vector2f.new(x,y))
  end
  
  def loadSkyColour(r:float, g:float, b:float):void
    loadVector(getLoc("skyColour"), Vector3f.new(r,g,b))
  end
  
  def loadFakeLightingVariable(bool:boolean):void
    loadBoolean(getLoc("useFakeLighting"), bool)
  end
  
  def loadShineVariables(damper:float, reflectivity:float)
    loadFloat(getLoc("shineDamper"), damper)
    loadFloat(getLoc("reflectivity"), reflectivity)
  end
  
  def loadLights(lights:Light[])
    l = lights.length()
    @@maxLights.times do |i:int|
      if (i < l)
        loadVector(getLoc("lightPosition[" + i + "]"), lights[i].getPosition())
        loadVector(getLoc("lightColour[" + i + "]"), lights[i].getColour())
        loadVector(getLoc("attenuation[" + i + "]"), lights[i].getAttenuation())
      else
        loadVector(getLoc("lightPosition[" + i + "]"), Vector3f.new(0,0,0))
        loadVector(getLoc("lightColour[" + i + "]"), Vector3f.new(0,0,0))
        loadVector(getLoc("attenuation[" + i + "]"), Vector3f.new(float(1.0),0,0))
      end
    end
  end
  
  def loadClipPlane(plane:Vector4f):void
    loadVector(getLoc("plane"), plane)
  end
  
  def loadTransformationMatrix(matrix:Matrix4f):void
    loadMatrix(getLoc("transformationMatrix"), matrix)
  end
  
  def loadViewMatrix(camera:Camera):void
    viewMatrix = Maths.createViewMatrix(camera)
    loadMatrix(getLoc("viewMatrix"), viewMatrix)
  end
  
  def loadProjectionMatrix(matrix:Matrix4f):void
    loadMatrix(getLoc("projectionMatrix"), matrix)
  end
end


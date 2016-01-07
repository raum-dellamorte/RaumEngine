package org.dellamorte.raum.shaders

import Shader0
import org.dellamorte.raum.entities.Camera

import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.engine.DisplayMgr

/**
 *
 * @author Raum
 */
class ShaderSkyBox < Shader0
  @@vertexFile = "res/opengl/skyboxVertexShader.txt";
  @@fragmentFile = "res/opengl/skyboxFragmentShader.txt";
  
  @@rotSpeed = float(1.0)
  
  def initialize()
    super(@@vertexFile, @@fragmentFile)
    @rotation = float(0.0)
  end
  
  def loadProjectionMatrix(matrix:Matrix4f):void
    loadMatrix(getLoc("projectionMatrix"), matrix)
  end

  def loadViewMatrix(camera:Camera):void
    matrix = Maths.createViewMatrix(camera)
    matrix.m30 = float(0.0)
    matrix.m31 = float(0.0)
    matrix.m32 = float(0.0)
    @rotation = float(@rotation + float(float(@@rotSpeed) * float(DisplayMgr.getFrameTimeSeconds())))
    rads = float(Math.toRadians(Float.new(@rotation).doubleValue))
    Matrix4f.rotate(rads, Vector3f.new(float(0.0),float(1.0), float(0.0)), matrix, matrix)
    loadMatrix(getLoc("viewMatrix"), matrix)
  end
  
  def loadFogColour(r:float, g:float, b:float):void
    loadVector(getLoc("fogColour"), Vector3f.new(r,g,b))
  end
  
  def connectTextureUnits():void
    loadInt(getLoc("cubeMap1"), 0)
    loadInt(getLoc("cubeMap2"), 1)
  end
  
  def loadBlendFactor(factor:float):void
    loadFloat(getLoc("blendFactor"), factor)
  end
  
  $Override
  def getAllUniformLocations():void
    newLoc("projectionMatrix")
    newLoc("viewMatrix")
    newLoc("fogColour")
    newLoc("cubeMap1")
    newLoc("cubeMap2")
    newLoc("blendFactor")
  end

  $Override
  def bindAttributes():void
    bindAttribute(0, "position")
  end
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.shaders
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector4f
import org.dellamorte.raum.toolbox.Maths


/**
 *
 * @author Raum
 */
class ShaderWater < Shader0
  def self.VERTEX_FILE():String(); "res/opengl/waterVertex.txt"; end
  def self.FRAGMENT_FILE():String(); "res/opengl/waterFragment.txt"; end
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
    newLoc("plane")
  end

  def loadProjectionMatrix(projection:Matrix4f):void
    loadMatrix(getLoc("projectionMatrix"), projection)
  end

  def loadViewMatrix(camera:Camera):void
    viewMatrix = Matrix4f(Maths.createViewMatrix(camera))
    loadMatrix(getLoc("viewMatrix"), viewMatrix)
  end

  def loadModelMatrix(modelMatrix:Matrix4f):void
    loadMatrix(getLoc("modelMatrix"), modelMatrix)
  end
  
  def loadPlane(plane:Vector4f):void
    loadVector(getLoc("plane"), plane)
  end
  
end


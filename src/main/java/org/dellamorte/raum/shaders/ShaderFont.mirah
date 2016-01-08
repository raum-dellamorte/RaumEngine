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
import org.lwjgl.opengl.GL20

class ShaderFont < Shader0
  
  def self.VERTEX_FILE():String; "res/opengl/fontVertex.txt"; end
  def self.FRAGMENT_FILE():String; "res/opengl/fontFragment.txt"; end
  
  def initialize():void
    super(VERTEX_FILE(), FRAGMENT_FILE())
    puts "new FontShader"
  end
  
  $Override
  def getAllUniformLocations():void
    newLoc("translation")
    newLoc("colour")
  end
  
  $Override
  def bindAttributes():void
    bindAttribute(0, "position")
    bindAttribute(1, "textureCoords")
  end
  
  def loadColour(colour:Vector3f):void
    loadVector(getLoc("colour"), colour)
  end
  
  def loadTranslation(translation:Vector2f):void
    loadVector(getLoc("translation"), translation)
  end
  
  
end

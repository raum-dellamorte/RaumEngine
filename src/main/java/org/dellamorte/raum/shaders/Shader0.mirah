package org.dellamorte.raum.shaders

import java.io.BufferedReader
import java.io.FileReader
#import java.io.IOException
import java.nio.FloatBuffer
import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.entities.Light
import org.dellamorte.raum.input.Keyboard
import org.dellamorte.raum.toolbox.Block
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.toolbox.StrMap
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.toolbox.vector.Vector4f
import org.lwjgl.BufferUtils
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL20


/**
 *
 * @author Raum
 */
abstract class Shader0
  def initialize(shaderType:String):void
    @matrixBuffer = FloatBuffer(BufferUtils.createFloatBuffer(16))
    @vertShaderFile = shaderFile(shaderType, "Vert")
    @fragShaderFile = shaderFile(shaderType, "Frag")
    setupShader()
  end
  
  def shaderFile(fname:String, type:String):String
    return "res/opengl/" + fname + type + ".glsl"
  end
  
  def setupShader():void
    @vertexShaderID = loadShader(@vertShaderFile, GL20.GL_VERTEX_SHADER) 
    @fragmentShaderID = loadShader(@fragShaderFile, GL20.GL_FRAGMENT_SHADER)
    @programID = GL20.glCreateProgram(); puts "programID " + @programID
    @locations = StrMap.new()
    GL20.glAttachShader(@programID, @vertexShaderID)
    GL20.glAttachShader(@programID, @fragmentShaderID)
    bindAttributes()
    GL20.glLinkProgram(@programID)
    GL20.glValidateProgram(@programID)
    getAllUniformLocations()
  end
  
  def reloadShader():void
    cleanUp()
    setupShader()
  end
  
  def attachReloadKey():void
    thisShader = self
    Keyboard.addListener(DisplayMgr.mainWindow(), 301, 0, 0) do
      thisShader.reloadShader()
    end
  end
  
  def getLoc(key:String):int
    @locations.get(key)
  end
  
  def newLoc(key:String):void
    @locations.set(key, getUniformLocation(key))
  end
  
  def setLoc(key:String, loc:int):void
    @locations.set(key, loc)
  end
  
  def vertexShaderID():int
    @vertexShaderID
  end
  
  def fragmentShaderID():int
    @fragmentShaderID
  end
  
  def programID():int
    @programID
  end
  
  def getMatrixBuffer():FloatBuffer
    @matrixBuffer
  end
  
  def setMatrixBuffer(matrix:FloatBuffer):void
    @matrixBuffer = matrix
  end
  
  def getUniformLocation(uniformName:String):int
    GL20.glGetUniformLocation(@programID, uniformName)
  end
  
  def start():void
    GL20.glUseProgram(@programID);
  end
  
  def stop():void
    GL20.glUseProgram(0);
  end
  
  def cleanUp():void
    stop()
    GL20.glDetachShader(@programID, @vertexShaderID)
    GL20.glDetachShader(@programID, @fragmentShaderID)
    GL20.glDeleteShader(@vertexShaderID)
    GL20.glDeleteShader(@fragmentShaderID)
    GL20.glDeleteProgram(@programID)
  end
  
  def bindAttribute(attribute:int, variableName:String):void
    GL20.glBindAttribLocation(@programID, attribute, variableName)
  end
  
  def loadInt(location:int, value:int):void
    GL20.glUniform1i(location, value)
  end
  
  def loadFloat(location:int, value:float):void
    GL20.glUniform1f(location, value)
  end
  
  def loadVector(location:int, vector:Vector4f):void
    GL20.glUniform4f(location, vector.x, vector.y, vector.z, vector.w)
  end
  
  def loadVector(location:int, vector:Vector3f):void
    GL20.glUniform3f(location, vector.x, vector.y, vector.z)
  end
  
  def loadVector(location:int, vector:Vector2f):void
    GL20.glUniform2f(location, vector.x, vector.y)
  end
  
  def loadBoolean(location:int, value:boolean):void
    toLoad = float(value ? 1.0 : 0.0)
    GL20.glUniform1f(location, toLoad)
  end
  
  def loadMatrix(location:int, matrix:Matrix4f):void
    matrix.store(@matrixBuffer)
    @matrixBuffer.flip()
    #puts "prog " + programID() + " matrix\n" + @matrixBuffer.toString
    GL20.glUniformMatrix4fv(location, false, @matrixBuffer)
  end
  
  def loadShader(file:String, type:int):int
    shaderSource = StringBuilder.new()
    begin
      reader = BufferedReader.new(FileReader.new(file))
      until ((line = reader.readLine()) == nil)
        shaderSource.append(line).append("\n")
      end
      reader.close()
    rescue # |e:IOException|
      System.err.println("Could not read file!")
      #e.printStackTrace()
      System.exit(-1)
    end
    shaderID = GL20.glCreateShader(type)
    GL20.glShaderSource(shaderID, shaderSource)
    GL20.glCompileShader(shaderID)
    if (GL20.glGetShaderi(shaderID, GL20.GL_COMPILE_STATUS) == GL11.GL_FALSE)
      #System.out.println(GL20.glGetShaderInfoLog(shaderID, 500))
      System.err.println("Could not compile shader.")
      System.exit(-1)
    end
    return shaderID
  end
  
  abstract def bindAttributes():void
  end
  
  abstract def getAllUniformLocations():void
  end
end


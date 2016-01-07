package org.dellamorte.raum.engine

import java.util.List
import java.util.ArrayList
import java.io.FileInputStream
import java.nio.ByteBuffer
import java.nio.FloatBuffer
import java.nio.IntBuffer
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.textures.TextureData
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL12
import org.lwjgl.opengl.GL13
import org.lwjgl.opengl.GL14
import org.lwjgl.opengl.GL15
import org.lwjgl.opengl.GL20
import org.lwjgl.opengl.GL30
import org.lwjgl.BufferUtils
import de.matthiasmann.twl.utils.PNGDecoder
import de.matthiasmann.twl.utils.PNGDecoder.Format
import java.io.File
import java.nio.channels.FileChannel
import java.io.IOException
import org.dellamorte.raum.textures.Image
import static org.lwjgl.system.jemalloc.JEmalloc.*


/**
 *
 * @author Raum
 */
class Loader 
  @@vaos = ArrayList.new()
  @@vbos = ArrayList.new()
  @@textures = ArrayList.new()
  
  @@skyOrder = strArray(["right", "left", "top", "bottom", "back", "front"])
  
  def self.strArray(vals:List):String[]
    out = String[vals.size()]
    vals.size().times {|i:int| out[i] = String(vals.get(i)) }
    return out
  end
  
  def loadToVAO(positions:float[], textureCoords:float[], normals:float[], indices:int[]):RawModel
    vaoID = createVAO()
    bindIndecesBuffer(indices)
    storeDataInAttributeList(0, 3, positions)
    storeDataInAttributeList(1, 2, textureCoords)
    storeDataInAttributeList(2, 3, normals)
    unbindVAO()
    return RawModel.new(vaoID, indices.length())
  end
  
  def loadToVAO(positions:float[], textureCoords:float[]):int
    vaoID = createVAO()
    storeDataInAttributeList(0, 2, positions)
    storeDataInAttributeList(1, 2, textureCoords)
    unbindVAO()
    return vaoID
  end
  
  def loadToVAO(positions:float[], dimensions = 2):RawModel
    vaoID = createVAO()
    storeDataInAttributeList(0, dimensions, positions)
    unbindVAO()
    return RawModel.new(vaoID, positions.length() / dimensions)
  end
  
  def loadTexture(fileName:String):int
    /*begin
      #texture = Texture(TextureLoader.getTexture("PNG", FileInputStream.new("res/textures/"+fileName+".png")))
      texture = loadImage(fileName)
      GL30.glGenerateMipmap(GL11.GL_TEXTURE_2D)
      GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_MIN_FILTER, GL11.GL_LINEAR_MIPMAP_LINEAR)
      GL11.glTexParameterf(GL11.GL_TEXTURE_2D, GL14.GL_TEXTURE_LOD_BIAS, float(0.0))
    rescue
      puts "Failed to load Texture."
      System.exit(-1)
    end
    textureID = GL11.glGenTextures()
    @@textures.add(textureID)
    return textureID*/
    texID = GL11.glGenTextures()
    GL13.glActiveTexture(GL13.GL_TEXTURE0)
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, texID)
    image = loadImage("res/textures/"+fileName+".png")
    GL11.glTexImage2D(GL11.GL_TEXTURE_2D, 0, GL11.GL_RGBA, image.width, image.height, 0, 
      ((image.components == 4) ? GL11.GL_RGBA : GL11.GL_RGB), GL11.GL_UNSIGNED_BYTE, image.image)
    GL30.glGenerateMipmap(GL11.GL_TEXTURE_2D)
    GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_MIN_FILTER, GL11.GL_LINEAR_MIPMAP_LINEAR)
    GL11.glTexParameterf(GL11.GL_TEXTURE_2D, GL14.GL_TEXTURE_LOD_BIAS, float(0.0))
    #GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_MAG_FILTER, GL11.GL_LINEAR)
    #GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_WRAP_S, GL12.GL_CLAMP_TO_EDGE)
    #GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_WRAP_T, GL12.GL_CLAMP_TO_EDGE)
    @@textures.add(texID)
    return texID
  end
  
  def createVAO():int
    vaoID = GL30.glGenVertexArrays()
    @@vaos.add(Integer.new(vaoID))
    GL30.glBindVertexArray(vaoID)
    return vaoID
  end
  
  def cleanUp():void
    @@vaos.each do |vao:Integer|
      GL30.glDeleteVertexArrays(vao.intValue())
    end
    @@vbos.each do |vbo:Integer|
      GL15.glDeleteBuffers(vbo.intValue())
    end
    @@textures.each do |tID:Integer|
      GL11.glDeleteTextures(tID.intValue())
    end
  end
  
  def storeDataInAttributeList(attributeNumber:int, coordSize:int, data:float[]):void
    vboID = GL15.glGenBuffers()
    @@vbos.add(Integer.new(vboID))
    GL15.glBindBuffer(GL15.GL_ARRAY_BUFFER, vboID)
    buffer = storeDataInFloatBuffer(data)
    GL15.glBufferData(GL15.GL_ARRAY_BUFFER, buffer, GL15.GL_STATIC_DRAW)
    GL20.glVertexAttribPointer(attributeNumber, coordSize, GL11.GL_FLOAT, false, 0, 0)
    GL15.glBindBuffer(GL15.GL_ARRAY_BUFFER, 0)
  end
  
  def unbindVAO():void
    GL30.glBindVertexArray(0)
  end
  
  def bindIndecesBuffer(indices:int[]):void
    vboID = GL15.glGenBuffers()
    @@vbos.add(vboID)
    GL15.glBindBuffer(GL15.GL_ELEMENT_ARRAY_BUFFER, vboID)
    buffer = storeDataInIntBuffer(indices)
    GL15.glBufferData(GL15.GL_ELEMENT_ARRAY_BUFFER, buffer, GL15.GL_STATIC_DRAW)
  end
  
  def storeDataInIntBuffer(data:int[]):IntBuffer
    buffer = BufferUtils.createIntBuffer(data.length())
    buffer.put(data)
    buffer.flip()
    return buffer
  end
  
  def storeDataInFloatBuffer(data:float[]):FloatBuffer
    buffer = FloatBuffer(BufferUtils.createFloatBuffer(data.length))
    buffer.put(data)
    buffer.flip()
    return buffer
  end
  
  def loadCubeMap(sky:String):int
    texID = GL11.glGenTextures()
    GL13.glActiveTexture(GL13.GL_TEXTURE0)
    GL11.glBindTexture(GL13.GL_TEXTURE_CUBE_MAP, texID)
    loc = "res/skybox/" + sky + "/"
    @@skyOrder.length().times do |i:int|
      data = TextureData(decodeTextureFile(loc + @@skyOrder[i] + ".png"))
      GL11.glTexImage2D(GL13.GL_TEXTURE_CUBE_MAP_POSITIVE_X + i, 0, 
        GL11.GL_RGBA, data.getWidth(), data.getHeight(), 0, 
        GL11.GL_RGBA, GL11.GL_UNSIGNED_BYTE, data.getBuffer())
    end
    GL11.glTexParameteri(GL13.GL_TEXTURE_CUBE_MAP, GL11.GL_TEXTURE_MAG_FILTER, GL11.GL_LINEAR)
    GL11.glTexParameteri(GL13.GL_TEXTURE_CUBE_MAP, GL11.GL_TEXTURE_MIN_FILTER, GL11.GL_LINEAR)
    GL11.glTexParameteri(GL13.GL_TEXTURE_CUBE_MAP, GL11.GL_TEXTURE_WRAP_S, GL12.GL_CLAMP_TO_EDGE)
    GL11.glTexParameteri(GL13.GL_TEXTURE_CUBE_MAP, GL11.GL_TEXTURE_WRAP_T, GL12.GL_CLAMP_TO_EDGE);
    @@textures.add(texID)
    return texID
  end
  
  def decodeTextureFile(fileName:String):TextureData
    width = 0
    height = 0
    buffer = ByteBuffer(nil)
    begin
      infile = FileInputStream.new(fileName)
      decoder = PNGDecoder.new(infile)
      width = decoder.getWidth()
      height = decoder.getHeight()
      buffer = ByteBuffer.allocateDirect(4 * width * height)
      decoder.decode(buffer, width * 4, Format.RGBA)
      buffer.flip()
      infile.close()
    rescue #} catch (Exception e) {
      #e.printStackTrace()
      System.err.println("Tried to load texture " + fileName + ", didn't work")
      System.exit(-1)
    end
    return TextureData.new(buffer, width, height)
  end
  
  def loadImage(path:String):Image
    begin
      imageBuffer = fileToByteBuffer(path, 8 * 1024)
    rescue IOException => e
      puts "Failed to load image file: " + path
    end
    
    return Image.new(imageBuffer)
  end
  
  def createByteBuffer(size:long):ByteBuffer
    je_malloc(size)
  end
  
  def fileToByteBuffer(path:String, bufferSize:int):ByteBuffer
    file = File.new(path)
    fis = FileInputStream.new(file)
    fc = FileChannel(fis.getChannel())
    buffer = createByteBuffer(int(fc.size()) + 1)
    until (fc.read(buffer) == -1) do; end
    fc.close
    fis.close
    buffer.flip
    
    return buffer
  end
  
end


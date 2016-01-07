/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.terrains
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.engine.Loader
import org.dellamorte.raum.textures.TextureTerrain
import java.awt.image.BufferedImage
import javax.imageio.ImageIO
import java.io.File
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.textures.TexturePackTerrain
import org.dellamorte.raum.toolbox.FloatArray
import org.dellamorte.raum.toolbox.FloatArrays
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.toolbox.vector.Vector2f


/**
 *
 * @author Raum
 */
class Terrain 
  @@size = 800
  @@maxHeight = float(40.0)
  @@maxPixelColour = float(256 * 256 * 256)
  
  def initialize(gridX:int, gridZ:int, loader:Loader, 
                 texture:TexturePackTerrain, blendMap:TextureTerrain, heightMap:String):void
    @textures = texture
    @bMap = blendMap
    @x = gridX * @@size
    @z = gridZ * @@size
    @model = generateTerrain(loader, heightMap)
  end
  
  def getX():int
    @x
  end
  
  def getZ():int
    @z
  end
  
  def getTexturePack():TexturePackTerrain
    @textures
  end
  
  def getBlendMap():TextureTerrain
    @bMap
  end
  
  def getModel():RawModel
    @model
  end
  
  def pointInBorder(worldX:float, worldZ:float):boolean
    terrainX = worldX - @x
    terrainZ = worldZ - @z
    htln = float(@heights.array().length() - 1)
    gridSquareSize = (@@size / htln)
    gridX = int(Math.floor(terrainX / gridSquareSize))
    gridZ = int(Math.floor(terrainZ / gridSquareSize))
    return (((gridX > -1) and (gridZ > -1)) and ((gridX < htln) and (gridZ < htln)))
  end
  
  def getHeightOfTerrain(worldX:float, worldZ:float):float
    terrainX = worldX - @x
    terrainZ = worldZ - @z
    htln = float(@heights.array().length() - 1)
    gridSquareSize = (@@size / htln)
    gridX = int(Math.floor(terrainX / gridSquareSize))
    gridZ = int(Math.floor(terrainZ / gridSquareSize))
    return float(0.0) unless (((gridX > -1) and (gridZ > -1)) and ((gridX < htln) and (gridZ < htln)))
    xCoord = float((terrainX % gridSquareSize) / gridSquareSize)
    zCoord = float((terrainZ % gridSquareSize) / gridSquareSize)
    if (xCoord <= (1 - zCoord))
      answer = Maths.barryCentric(
        Vector3f.new(float(0.0), @heights.array()[gridX].array()[gridZ], float(0.0)), 
        Vector3f.new(float(1.0), @heights.array()[gridX + 1].array()[gridZ], float(0.0)), 
        Vector3f.new(float(0.0), @heights.array()[gridX].array()[gridZ + 1], float(1.0)), 
        Vector2f.new(xCoord, zCoord))
    else
      answer = Maths.barryCentric(
        Vector3f.new(float(1.0), @heights.array()[gridX + 1].array()[gridZ], float(0.0)),
        Vector3f.new(float(1.0), @heights.array()[gridX + 1].array()[gridZ + 1], float(1.0)), 
        Vector3f.new(float(0.0), @heights.array()[gridX].array()[gridZ + 1], float(1.0)), 
        Vector2f.new(xCoord, zCoord))
    end
    return answer
  end
  
  def generateTerrain(loader:Loader, heightMap:String):RawModel
    image = BufferedImage(nil)
    begin
      image = ImageIO.read(File.new("res/textures/" + heightMap + ".png"))
    rescue
      puts "Failed to load heightMap file."
    end
    @vertexCount = image.getHeight()
    
    @heights = FloatArrays.new(@vertexCount, @vertexCount)
    count = @vertexCount * @vertexCount
    vertices = float[count * 3]
    normals = float[count * 3]
    textureCoords = float[count * 2]
    indices = int[(6 * (@vertexCount - 1)) * (@vertexCount - 1)]
    vertexPointer = 0
    @vertexCount.times do |i:int|
      @vertexCount.times do |j:int|
        vertices[vertexPointer * 3] = 
          float((float(j) / float(@vertexCount - 1)) * float(@@size))
        height = getHeight(j, i, image)
        @heights.set(j, i, height)
        vertices[(vertexPointer * 3) + 1] = height
        vertices[(vertexPointer * 3) + 2] = 
          float((float(i) / float(@vertexCount - 1)) * float(@@size))
        normal = calcNormal(j, i, image)
        normals[vertexPointer * 3] = normal.x
        normals[(vertexPointer * 3) + 1] = normal.y
        normals[(vertexPointer * 3) + 2] = normal.z
        textureCoords[vertexPointer * 2] = 
          float(float(j) / float(@vertexCount - 1))
        textureCoords[(vertexPointer * 2) + 1] = 
          float(float(i) / float(@vertexCount - 1))
        vertexPointer += 1
      end
    end
    pointer = 0
    (@vertexCount - 1).times do |gz:int|
      (@vertexCount - 1).times do |gx:int|
        topLeft = (gz * @vertexCount) + gx
        topRight = topLeft + 1
        bottomLeft = ((gz + 1) * @vertexCount) + gx
        bottomRight = bottomLeft + 1
        indices[pointer] = topLeft; pointer += 1
        indices[pointer] = bottomLeft; pointer += 1
        indices[pointer] = topRight; pointer += 1
        indices[pointer] = topRight; pointer += 1
        indices[pointer] = bottomLeft; pointer += 1
        indices[pointer] = bottomRight; pointer += 1
      end
    end
    return RawModel(loader.loadToVAO(vertices, textureCoords, normals, indices))
  end
  
  def calcNormal(x:int, z:int, image:BufferedImage):Vector3f
    out = Vector3f.new(getHeight(x - 1, z, image) - getHeight(x + 1, z, image), float(2.0), 
                       getHeight(x, z - 1, image) - getHeight(x, z + 1, image))
    out.normalize()
    return out
  end
  
  def getHeight(x:int, z:int, image:BufferedImage):float
    return float(0.0) if ((x < 0) or ((x >= image.getHeight()) or ((z < 0) or (z >= image.getHeight()))))
    mp2 = float(@@maxPixelColour / float(2.0))
    return float(((image.getRGB(x, z) + mp2) / mp2) * @@maxHeight)
  end
end


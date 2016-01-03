package org.dellamorte.raum.toolbox.fontMeshCreator

/**
 * Stores the vertex data for all the quads on which a text will be rendered.
 * @author Karl
 *
 */
class TextMeshData
  def initialize(vertexPositions:float[], textureCoords:float[]):void
    @vertexPositions = vertexPositions
    @textureCoords = textureCoords
  end

  def getVertexPositions():float[]
    return @vertexPositions
  end

  def getTextureCoords():float[]
    return @textureCoords
  end

  def getVertexCount():int
    return @vertexPositions.length / 2
  end
end

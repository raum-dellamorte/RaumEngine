package org.dellamorte.raum.toolbox.fontMeshCreator

/**
 * Simple data structure class holding information about a certain glyph in the
 * font texture atlas. All sizes are for a font-size of 1.
 * 
 * @author Karl
 *
 */
class Character
  def initialize(id:int, xTextureCoord:double, yTextureCoord:double, xTexSize:double, yTexSize:double, xOffset:double, yOffset:double, sizeX:double, sizeY:double, xAdvance:double):void
    @id = id
    @xTextureCoord = xTextureCoord
    @yTextureCoord = yTextureCoord
    @xOffset = xOffset
    @yOffset = yOffset
    @sizeX = sizeX
    @sizeY = sizeY
    @xMaxTextureCoord = xTexSize + xTextureCoord
    @yMaxTextureCoord = yTexSize + yTextureCoord
    @xAdvance = xAdvance
  end

  def getId():int
    return @id
  end

  def getxTextureCoord():double
    return @xTextureCoord
  end

  def getyTextureCoord():double
    return @yTextureCoord
  end

  def getXMaxTextureCoord():double
    return @xMaxTextureCoord
  end

  def getYMaxTextureCoord():double
    return @yMaxTextureCoord
  end

  def getxOffset():double
    return @xOffset
  end

  def getyOffset():double
    return @yOffset
  end

  def getSizeX():double
    return @sizeX
  end

  def getSizeY():double
    return @sizeY
  end

  def getxAdvance():double
    return @xAdvance
  end

end

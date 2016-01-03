package org.dellamorte.raum.toolbox.fontMeshCreator;

import org.dellamorte.raum.engine.TextMgr
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Vector3f

/**
 * Represents a piece of text in the game.
 * 
 * @author Karl
 *
 */
class GUIText
  def initialize(text:String, font:FontType, fontSize:float, position:Vector2f, maxLineLength:float, centered:boolean):void
    @colour = Vector3f.new(0, 0, 0);
    @textString = text
    @fontSize = fontSize
    @font = font
    @position = position
    @lineMaxSize = maxLineLength
    @centerText = centered
    TextMgr.loadText(self)
  end

  def remove():void
    TextMgr.removeText(self)
  end

  def getFont():FontType
    return @font
  end

  def setColour(r:float, g:float, b:float):void
    @colour.set(r, g, b)
  end

  def getColour():Vector3f
    return @colour
  end

  def getNumberOfLines():int
    return @numberOfLines
  end

  def getPosition():Vector2f
    return @position
  end

  def getMesh():int
    return @textMeshVao
  end

  def setMeshInfo(vao:int, verticesCount:int):void
    @textMeshVao = vao
    @vertexCount = verticesCount
  end

  def getVertexCount():int
    return @vertexCount
  end

  def getFontSize():float
    return @fontSize
  end

  def setNumberOfLines(number:int):void
    @numberOfLines = number
  end

  def isCentered():boolean
    return @centerText
  end

  def getMaxLineSize():float
    return @lineMaxSize
  end

  def getTextString():String
    return @textString
  end

end

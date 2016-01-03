package org.dellamorte.raum.toolbox.fontMeshCreator

import java.io.BufferedReader
import java.io.File
import java.io.FileReader
import java.io.IOException
import java.util.HashMap
import java.util.Map
import org.dellamorte.raum.engine.DisplayMgr

import Character

class MetaFile
  def self.PAD_TOP():int; 0; end
  def self.PAD_LEFT():int; 1; end
  def self.PAD_BOTTOM():int; 2; end
  def self.PAD_RIGHT():int; 3; end
  def self.DESIRED_PADDING():int; 8; end
  def self.SPLITTER():String; " "; end
  def self.NUMBER_SEPARATOR():String; ","; end
  
  def initialize(file:File):void
    @verticalPerPixelSize = double(0.0)
    @horizontalPerPixelSize = double(0.0)
    @metaData = IntegerToCharacterMap.new() # <Integer, Character> ##Fix Generics by Hand
    @reader = BufferedReader(nil)
    @values = StringToStringMap.new() # <String, String> ##Fix Generics by Hand
    DisplayMgr.updateWH()
    @aspectRatio = double(DisplayMgr.getWidth()) / double(DisplayMgr.getHeight())
    openFile(file)
    loadPaddingData()
    loadLineSizes()
    imageWidth = int(getValueOfVariable("scaleW"))
    loadCharacterData(imageWidth)
    close()
  end

  def getSpaceWidth():double
    return @spaceWidth
  end

  def getCharacter(ascii:int):Character
    return Character(@metaData.get(Integer.new(ascii)))
  end

  def processNextLine():boolean
    @values.clear()
    line = String(nil)
    begin
      line = @reader.readLine()
    rescue IOException => e1
    end
    if (line == nil)
      return false
    end
    line.split(SPLITTER()).each do |part:String|
      valuePairs = String[].cast(part.split("="))
      if (valuePairs.length == 2)
        @values.put(valuePairs[0], valuePairs[1])
      end
    end
    return true
  end

  def getValueOfVariable(variable:String):int
    begin
      return Integer.parseInt(@values.get(variable))
    rescue
      #puts "getValueOfVariable: Fail " + variable + " " + @values.get(variable)
      return 0
    end
  end

  def getValuesOfVariable(variable:String):int[]
    numbers = String(@values.get(variable)).split(NUMBER_SEPARATOR())
    actualValues = int[numbers.length]
    actualValues.length.times do |i:int|
      actualValues[i] = Integer.parseInt(numbers[i])
    end
    return actualValues
  end

  def close():void
    begin
      @reader.close()
    rescue IOException => e
      e.printStackTrace()
    end
  end

  def openFile(file:File):void
    begin
      @reader = BufferedReader.new(FileReader.new(file))
    rescue Exception => e
      e.printStackTrace()
      System.err.println("Couldn't read font meta file!")
    end
  end

  def loadPaddingData():void
    processNextLine()
    @padding = getValuesOfVariable("padding")
    @paddingWidth = @padding[PAD_LEFT()] + @padding[PAD_RIGHT()]
    @paddingHeight = @padding[PAD_TOP()] + @padding[PAD_BOTTOM()]
  end

  def loadLineSizes():void
    processNextLine()
    lineHeightPixels = int(getValueOfVariable("lineHeight") - @paddingHeight)
    @verticalPerPixelSize = TextMeshCreator.LINE_HEIGHT / double(lineHeightPixels)
    @horizontalPerPixelSize = @verticalPerPixelSize / @aspectRatio
  end

  def loadCharacterData(imageWidth:int):void
    processNextLine()
    processNextLine()
    while (processNextLine())
      c = Character(loadCharacter(imageWidth))
      if (c != nil)
        @metaData.put(c.getId(), c)
      end
    end
  end

  def loadCharacter(imageSize:int):Character
    id = int(getValueOfVariable("id"))
    if (id == TextMeshCreator.SPACE_ASCII)
      @spaceWidth = (getValueOfVariable("xadvance") - @paddingWidth) * @horizontalPerPixelSize
      return nil
    end
    xTex = double((double(getValueOfVariable("x")) + (@padding[PAD_LEFT()] - DESIRED_PADDING())) / imageSize)
    yTex = double((double(getValueOfVariable("y")) + (@padding[PAD_TOP()] - DESIRED_PADDING())) / imageSize)
    width = int(getValueOfVariable("width") - (@paddingWidth - (2 * DESIRED_PADDING())))
    height = int(getValueOfVariable("height") - ((@paddingHeight) - (2 * DESIRED_PADDING())))
    quadWidth = double(width * @horizontalPerPixelSize)
    quadHeight = double(height * @verticalPerPixelSize)
    xTexSize = double(double(width) / imageSize)
    yTexSize = double(double(height) / imageSize)
    xOff = double((getValueOfVariable("xoffset") + @padding[PAD_LEFT()] - DESIRED_PADDING()) * @horizontalPerPixelSize)
    yOff = double((getValueOfVariable("yoffset") + (@padding[PAD_TOP()] - DESIRED_PADDING())) * @verticalPerPixelSize)
    xAdvance = double((getValueOfVariable("xadvance") - @paddingWidth) * @horizontalPerPixelSize)
    return Character.new(id, xTex, yTex, xTexSize, yTexSize, xOff, yOff, quadWidth, quadHeight, xAdvance)
  end

end

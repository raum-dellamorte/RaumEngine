package org.dellamorte.raum.toolbox.fontMeshCreator;

import MetaFile

import org.dellamorte.raum.toolbox.FloatList

import java.io.File;
import java.util.ArrayList;
import java.util.List;

class TextMeshCreator
  def self.LINE_HEIGHT():double; float(0.03); end
  def self.SPACE_ASCII():int; 32; end
  def initialize(metaFile:File):void
    @metaData = MetaFile.new(metaFile)
  end

  def createTextMesh(text:GUIText):TextMeshData
    lines = List(createStructure(text)) # Generic: Line ## Fix Generics by Hand
    data = TextMeshData(createQuadVertices(text, lines))
    return data
  end

  def createStructure(text:GUIText):List # Generic: Line ##Fix Generics by Hand
    chars = char[].cast(text.getTextString().toCharArray())
    lines = List(ArrayList.new()) # Generic: Line ## Fix Generics by Hand
    currentLine = Line.new(@metaData.getSpaceWidth(), text.getFontSize(), text.getMaxLineSize())
    currentWord = Word.new(text.getFontSize())
    chars.each do |c:char|
      ascii = int(int(c))
      if (ascii == SPACE_ASCII())
        added = boolean(currentLine.attemptToAddWord(currentWord))
        if (!added)
          lines.add(currentLine)
          currentLine = Line.new(@metaData.getSpaceWidth(), text.getFontSize(), text.getMaxLineSize())
          currentLine.attemptToAddWord(currentWord)
        end
        currentWord = Word.new(text.getFontSize())
        next
      end
      character = Character(@metaData.getCharacter(ascii))
      currentWord.addCharacter(character)
    end
    completeStructure(lines, currentLine, currentWord, text)
    return lines
  end

  def completeStructure(lines:List, currentLine:Line, currentWord:Word, text:GUIText):void # ## Generics: lines:List -> Line
    added = boolean(currentLine.attemptToAddWord(currentWord))
    if (!added)
      lines.add(currentLine)
      currentLine = Line.new(@metaData.getSpaceWidth(), text.getFontSize(), text.getMaxLineSize())
      currentLine.attemptToAddWord(currentWord)
    end
    lines.add(currentLine)
  end

  def createQuadVertices(text:GUIText, lines:List):TextMeshData # ## Generics: lines:List -> Line
    text.setNumberOfLines(lines.size())
    curserX = double(float(0))
    curserY = double(float(0))
    vertices = List(ArrayList.new()) # Generic: Float ## Fix Generics by Hand
    textureCoords = List(ArrayList.new()) # Generic: Float ## Fix Generics by Hand
    lines.each do |line:Line|
      curserX = (line.getMaxLength() - line.getLineLength()) / 2 if (text.isCentered())
      line.getWords().array.each do |word:Word|
        word.getCharacters().array.each do |letter:Character|
          addVerticesForCharacter(curserX, curserY, letter, text.getFontSize(), vertices)
          addTexCoords(textureCoords, letter.getxTextureCoord(), letter.getyTextureCoord(),
          letter.getXMaxTextureCoord(), letter.getYMaxTextureCoord())
          curserX += letter.getxAdvance() * text.getFontSize()
        end
        curserX += @metaData.getSpaceWidth() * text.getFontSize()
      end
      curserX = 0
      curserY += LINE_HEIGHT() * text.getFontSize()
    end
    return TextMeshData.new(listToArray(vertices), listToArray(textureCoords))
  end

  def addVerticesForCharacter(curserX:double, curserY:double, character:Character, fontSize:double, vertices:List):void # ## Generics: vertices:List -> Float
    x = double(curserX + (character.getxOffset() * fontSize))
    y = double(curserY + (character.getyOffset() * fontSize))
    maxX = double(x + (character.getSizeX() * fontSize))
    maxY = double(y + (character.getSizeY() * fontSize))
    properX = double((2 * x) - 1)
    properY = double((-2 * y) + 1)
    properMaxX = double((2 * maxX) - 1)
    properMaxY = double((-2 * maxY) + 1)
    addVertices(vertices, properX, properY, properMaxX, properMaxY)
  end

  def self.addVertices(vertices:List, x:double, y:double, maxX:double, maxY:double):void # ## Generics: vertices:List -> Float
    vertices.add(float(x))
    vertices.add(float(y))
    vertices.add(float(x))
    vertices.add(float(maxY))
    vertices.add(float(maxX))
    vertices.add(float(maxY))
    vertices.add(float(maxX))
    vertices.add(float(maxY))
    vertices.add(float(maxX))
    vertices.add(float(y))
    vertices.add(float(x))
    vertices.add(float(y))
  end

  def self.addTexCoords(texCoords:List, x:double, y:double, maxX:double, maxY:double):void # ## Generics: texCoords:List -> Float
    texCoords.add(float(x))
    texCoords.add(float(y))
    texCoords.add(float(x))
    texCoords.add(float(maxY))
    texCoords.add(float(maxX))
    texCoords.add(float(maxY))
    texCoords.add(float(maxX))
    texCoords.add(float(maxY))
    texCoords.add(float(maxX))
    texCoords.add(float(y))
    texCoords.add(float(x))
    texCoords.add(float(y))
  end

  def self.listToArray(listOfFloats:List):float[] # ## Generics: listOfFloats:List -> Float
    array = float[listOfFloats.size()]
    array.length.times do |i:int|
      array[i] = Float(listOfFloats.get(i)).floatValue()
    end
    return array
  end

end

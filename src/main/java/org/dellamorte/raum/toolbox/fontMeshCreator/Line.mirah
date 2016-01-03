package org.dellamorte.raum.toolbox.fontMeshCreator;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents a line of text during the loading of a text.
 * 
 * @author Karl
 *
 */
class Line
  def initialize(spaceWidth:double, fontSize:double, maxLength:double):void
    @words = WordList.new() # Generic: Word ##Fix Generics by Hand
    @currentLineLength = double(0.0)
    @spaceSize = spaceWidth * fontSize
    @maxLength = maxLength
  end

  def attemptToAddWord(word:Word):boolean
    additionalLength = double(word.getWordWidth())
    additionalLength += double((!@words.isEmpty()) ? (@spaceSize) : double(0))
    if (@currentLineLength + additionalLength <= @maxLength)
      @words.add(word)
      @currentLineLength += additionalLength
      return true
    else
      return false
    end
  end

  def getMaxLength():double
    return @maxLength
  end

  def getLineLength():double
    return @currentLineLength
  end

  def getWords():WordList # Generic: Word ##Fix Generics by Hand
    return @words
  end

end

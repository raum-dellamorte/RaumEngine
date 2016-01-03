package org.dellamorte.raum.toolbox.fontMeshCreator

import java.util.ArrayList
import java.util.List

/**
 * During the loading of a text this represents one word in the text.
 * @author Karl
 *
 */
class Word
  def initialize(fontSize:double):void
    @characters = CharacterList.new() # Generic: Character ##Fix Generics by Hand
    @width = 0;
    @fontSize = fontSize
  end

  def addCharacter(character:Character):void
    @characters.add(character)
    @width += character.getxAdvance() * @fontSize
  end

  def getCharacters():CharacterList # Generic: Character ##Fix Generics by Hand
    return @characters
  end

  def getWordWidth():double
    return @width
  end
end

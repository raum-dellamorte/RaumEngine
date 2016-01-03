package org.dellamorte.raum.toolbox.fontMeshCreator

/**
 *
 * @author Raum
 */
class WordList
	def initialize():void
		@x = Word[0]
	end

	def get(i:int):Word
		return @x[i] if ((i > -1) and (i < @x.length()))
		return Word(nil)
	end

	def add(lt:Word):void
		tmp = Word[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = lt
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():Word[]
		@x
  end
  
  def isEmpty():boolean
    @x.length == 0
  end
end


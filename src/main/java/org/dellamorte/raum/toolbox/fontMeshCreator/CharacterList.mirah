/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox.fontMeshCreator

/**
 *
 * @author Raum
 */
class CharacterList
	def initialize():void
		@x = Character[0]
	end

	def get(i:int):Character
		return @x[i] if ((i > -1) and (i < @x.length()))
		return Character(nil)
	end

	def add(lt:Character):void
		tmp = Character[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = lt
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():Character[]
		@x
	end
  
  def isEmpty():boolean
    @x.length == 0
  end
end


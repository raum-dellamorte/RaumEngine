/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.entities.Entity


/**
 *
 * @author Raum
 */
class EntityList 
	def initialize():void
		@x = Entity[0]
	end

	def get(i:int):Entity
		return @x[i] if ((i > -1) and (i < @x.length()))
		return Entity(nil)
	end

	def add(entity:Entity):void
		tmp = Entity[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = entity
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():Entity[]
		@x
	end
end


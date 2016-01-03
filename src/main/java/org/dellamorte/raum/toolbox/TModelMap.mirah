/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import TModelBox
import org.dellamorte.raum.entities.Entity
import org.dellamorte.raum.models.TexturedModel


/**
 *
 * @author Raum
 */
class TModelMap 
	def initialize():void
		clear()
	end
	
	def clear():void
		@x = TModelBox[0]
	end
	
	def get(tmodel:TexturedModel):TModelBox
		out = TModelBox(nil)
		@x.length().times do |i:int|
			next unless tmodel == TModelBox(@x[i]).model()
			out = TModelBox(@x[i])
			break
		end
		return out
	end
	
	def add(tmodel:TexturedModel):void
		return unless (get(tmodel) == nil)
		tmp = TModelBox[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = TModelBox.new(tmodel)
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():TModelBox[]
		@x
	end
end


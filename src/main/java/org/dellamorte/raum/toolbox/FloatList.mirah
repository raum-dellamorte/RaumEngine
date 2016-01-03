/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox

/**
 *
 * @author Raum
 */
class FloatList
	def initialize():void
		@x = Float[0]
	end

	def get(i:int):Float
		return @x[i] if ((i > -1) and (i < @x.length()))
		return Float(nil)
	end

	def add(lt:Float):void
		tmp = Float[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = lt
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():Float[]
		@x
	end
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.toolbox.vector.Vector2f


/**
 *
 * @author Raum
 */
class V2List
	def initialize():void
		@x = Vector2f[0]
	end

	def get(i:int):Vector2f
		return @x[i] if ((i > -1) and (i < @x.length()))
		return Vector2f(nil)
	end

	def add(v3:Vector2f):void
		tmp = Vector2f[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = v3
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():Vector2f[]
		@x
	end
end


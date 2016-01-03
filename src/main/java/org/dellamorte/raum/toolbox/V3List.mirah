/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.toolbox.vector.Vector3f


/**
 *
 * @author Raum
 */
class V3List
	def initialize():void
		@x = Vector3f[0]
	end

	def get(i:int):Vector3f
		return @x[i] if ((i > -1) and (i < @x.length()))
		return Vector3f(nil)
	end

	def add(v3:Vector3f):void
		tmp = Vector3f[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = v3
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():Vector3f[]
		@x
	end
end


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
class StrMap
	def initialize():void
		@x = String[0]
		@y = int[0]
	end
	
	def getStrLoc(str:String):int
		out = -1
		@x.length().times do |i:int|
			next unless (str.equals(@x[i]))
			out = i
			break
		end
		return out
	end

	def get(str:String):int
		i = getStrLoc(str)
		return @y[i] if ((i > -1) and (i < @y.length()))
		return i
	end

	def add(str:String, i:int):void
		return unless (getStrLoc(str) < 0)
		l = @x.length()
		nl = l + 1
		tmps = String[nl]
		tmpi = int[nl]
		@x.length().times do |v:int|
			tmps[v] = @x[v]
			tmpi[v] = @y[v]
		end
		tmps[l] = str
		tmpi[l] = i
		@x = tmps
		@y = tmpi
		return
	end

	def set(str:String, i:int):void
		out = getStrLoc(str)
		if (out < 0)
			add(str, i)
		else
			@y[out] = i
		end
	end
	
	def size():int
		@x.length()
	end
	
	def array():String[]
		@x
	end
end


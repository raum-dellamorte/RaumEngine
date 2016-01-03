/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox

import java.lang.String as KeyKlass
import java.lang.Float as ValKlass
/**
 *
 * @author Raum
 */
class StringFloatMap 
	def initialize():void
		clear()
	end
	
	def clear():void
		@keys = KeyKlass[0]
    @vals = ValKlass[0]
	end
	
	def getLoc(str:KeyKlass):int
		out = -1
		@vals.length().times do |i:int|
			next unless str.equals(@keys[i])
			out = i
			break
		end
		return out
	end
	
	def get(str:KeyKlass):ValKlass
		loc = getLoc(str)
    return ValKlass(nil) if (loc < 0)
		return @vals[loc]
	end
	
	def add(str:KeyKlass, i:float):void
		return if (getLoc(str) > -1)
    tmpS = KeyKlass[@keys.length() + 1]
		tmpX = ValKlass[@vals.length() + 1]
		@vals.length().times do |loc:int|
			tmpS[loc] = @keys[loc]
			tmpX[loc] = @vals[loc]
		end
		tmpS[@keys.length()] = str
		tmpX[@vals.length()] = ValKlass.new(i)
		@keys = tmpS
		@vals = tmpX
  end
	
	def add(str:KeyKlass, i:ValKlass):void
		return if (getLoc(str) > -1)
    tmpS = KeyKlass[@keys.length() + 1]
		tmpX = ValKlass[@vals.length() + 1]
		@vals.length().times do |loc:int|
			tmpS[loc] = @keys[loc]
			tmpX[loc] = @vals[loc]
		end
		tmpS[@keys.length()] = str
		tmpX[@vals.length()] = i
		@keys = tmpS
		@vals = tmpX
  end
  
  def set(str:KeyKlass, i:float):void
    loc = getLoc(str)
    return if (loc < 0)
    @vals[loc] = ValKlass.new(i)
  end
  
  def set(str:KeyKlass, i:ValKlass):void
    loc = getLoc(str)
    return if (loc < 0)
    @vals[loc] = i
  end
	
	def size():int
		@vals.length()
  end
  
  def keys():KeyKlass[]
    @keys
  end
  
  def values():ValKlass[]
    @vals
  end
end


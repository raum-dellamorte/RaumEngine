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
class StringMap 
  def initialize():void
    clear()
  end
  
  def clear():void
    @s = String[0]
    @x = Integer[0]
  end
  
  def getLoc(str:String):int
    out = -1
    @x.length().times do |i:int|
      next unless str.equals(@s[i])
      out = i
      break
    end
    return out
  end
  
  def get(str:String):Integer
    loc = getLoc(str)
    return Integer(nil) if (loc < 0)
    return @x[loc]
  end
  
  def add(str:String, i:int):void
    return if (getLoc(str) > -1)
    tmpS = String[@s.length() + 1]
    tmpX = Integer[@x.length() + 1]
    @x.length().times do |loc:int|
      tmpS[loc] = @s[loc]
      tmpX[loc] = @x[loc]
    end
    tmpS[@s.length()] = str
    tmpX[@x.length()] = Integer.new(i)
    @s = tmpS
    @x = tmpX
  end
  
  def set(str:String, i:int):void
    loc = getLoc(str)
    return if (loc < 0)
    @x[loc] = Integer.new(i)
  end
  
  def size():int
    @x.length()
  end
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox

import java.lang.String as KeyKlass
import org.dellamorte.raum.toolbox.fontMeshCreator.FontType as ValKlass

/**
 *
 * @author Raum
 */
class StringFontMap 
  def initialize():void
    clear()
  end
  
  def clear():void
    @keys = KeyKlass[0]
    @vals = ValKlass[0]
  end
  
  def getLoc(key:KeyKlass):int
    out = -1
    @vals.length().times do |val:int|
      next unless key.equals(@keys[val])
      out = val
      break
    end
    return out
  end
  
  def get(key:KeyKlass):ValKlass
    loc = getLoc(key)
    return ValKlass(nil) if (loc < 0)
    return @vals[loc]
  end
  
  def add(key:KeyKlass, val:ValKlass):void
    (set(key, val); return) if (getLoc(key) > -1)
    tmpS = KeyKlass[@keys.length() + 1]
    tmpX = ValKlass[@vals.length() + 1]
    @vals.length().times do |loc:int|
      tmpS[loc] = @keys[loc]
      tmpX[loc] = @vals[loc]
    end
    tmpS[@keys.length()] = key
    tmpX[@vals.length()] = val
    @keys = tmpS
    @vals = tmpX
  end
  
  def add(key:KeyKlass):void
    (set(key); return) if (getLoc(key) > -1)
    tmpS = KeyKlass[@keys.length() + 1]
    tmpX = ValKlass[@vals.length() + 1]
    @vals.length().times do |loc:int|
      tmpS[loc] = @keys[loc]
      tmpX[loc] = @vals[loc]
    end
    tmpS[@keys.length()] = key
    tmpX[@vals.length()] = ValKlass.new(key)
    @keys = tmpS
    @vals = tmpX
  end
  
  def set(key:KeyKlass, val:ValKlass):void
    loc = getLoc(key)
    return if (loc < 0)
    @vals[loc] = val
  end
  
  def set(key:KeyKlass):void
    loc = getLoc(key)
    return if (loc < 0)
    @vals[loc] = ValKlass.new(key)
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


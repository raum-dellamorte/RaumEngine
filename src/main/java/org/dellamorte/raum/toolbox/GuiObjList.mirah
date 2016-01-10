/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.entities.GuiObj as ListObj


/**
 *
 * @author Raum
 */
class GuiObjList
  def initialize():void
    @x = ListObj[0]
  end

  def get(i:int):ListObj
    return @x[i] if ((i > -1) and (i < @x.length()))
    return ListObj(nil)
  end

  def add(v3:ListObj):void
    tmp = ListObj[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = v3
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():ListObj[]
    @x
  end
end


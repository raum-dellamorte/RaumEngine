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
class IList
  def initialize():void
    @x = Integer[0]
  end

  def get(i:int):Integer
    return @x[i] if ((i > -1) and (i < @x.length()))
    return Integer(nil)
  end

  def add(v3:Integer):void
    tmp = Integer[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = v3
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():Integer[]
    @x
  end
end


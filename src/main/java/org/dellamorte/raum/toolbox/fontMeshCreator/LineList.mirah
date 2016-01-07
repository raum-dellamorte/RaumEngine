/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox.fontMeshCreator

/**
 *
 * @author Raum
 */
class LineList
  def initialize():void
    @x = Line[0]
  end

  def get(i:int):Line
    return @x[i] if ((i > -1) and (i < @x.length()))
    return Line(nil)
  end

  def add(lt:Line):void
    tmp = Line[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = lt
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():Line[]
    @x
  end
  
  def isEmpty():boolean
    @x.length == 0
  end
end


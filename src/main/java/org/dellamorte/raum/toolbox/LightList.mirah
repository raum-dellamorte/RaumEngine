/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.entities.Light

/**
 *
 * @author Raum
 */
class LightList 
  def initialize():void
    @x = Light[0]
  end

  def get(i:int):Light
    return @x[i] if ((i > -1) and (i < @x.length()))
    return Light(nil)
  end

  def add(lt:Light):void
    tmp = Light[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = lt
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():Light[]
    @x
  end
end


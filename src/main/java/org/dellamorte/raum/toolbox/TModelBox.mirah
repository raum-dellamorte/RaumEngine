/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.entities.Entity
import org.dellamorte.raum.models.TexturedModel


/**
 *
 * @author Raum
 */
class TModelBox 
  def initialize(texturedModel:TexturedModel):void
    @tmodel = texturedModel
    clear()
  end
  
  def clear():void
    @x = Entity[0]
  end
  
  def model():TexturedModel
    @tmodel
  end
  
  def get(i:int):Entity
    return @x[i] if ((i > -1) and (i < @x.length()))
    return Entity(nil)
  end

  def add(v3:Entity):void
    tmp = Entity[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = v3
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():Entity[]
    @x
  end
  
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox

import org.dellamorte.raum.textures.TextureGui as MyListItem

/**
 *
 * @author Raum
 */
class GuiTxtrList 
  def initialize():void
    @x = MyListItem[0]
  end

  def get(i:int):MyListItem
    return @x[i] if ((i > -1) and (i < @x.length()))
    return MyListItem(nil)
  end

  def add(itm:MyListItem):void
    tmp = MyListItem[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = itm
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():MyListItem[]
    @x
  end
end


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
class GUITextList
  def initialize():void
    @x = GUIText[0]
  end

  def get(i:int):GUIText
    return @x[i] if ((i > -1) and (i < @x.length()))
    return GUIText(nil)
  end

  def add(lt:GUIText):void
    tmp = GUIText[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = lt
    @x = tmp
  end

  def remove(lt:GUIText):void
    j = 0
    @x.length().times do |i:int|
      next if @x[i] == lt
      j += 1
    end
    tmp = GUIText[j]
    j = 0
    @x.length().times do |i:int|
      next if @x[i] == lt
      tmp[j] = @x[i]
      j += 1
    end
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():GUIText[]
    @x
  end
  
  def isEmpty():boolean
    @x.length == 0
  end
end


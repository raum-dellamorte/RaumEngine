/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import FloatArray

/**
 *
 * @author Raum
 */
class FloatArrays 
  def initialize(szh:int, szw:int):void
    @x = FloatArray[szh]
    @y = szw
    szh.times do |i:int|
      @x[i] = FloatArray.new(szw)
    end
  end

  def get(row:int):FloatArray
    return @x[row] if ((row > -1) and (row < @x.length()))
    return FloatArray(nil)
  end
  
  def set(locR:int, locC:int, val:float):void
    (@x[locR].array()[locC] = val) if ((locR > -1) and (locR < @x.length())) and ((locC > -1) and (locC < @y))
  end
  
  def array():FloatArray[]
    @x
  end
end


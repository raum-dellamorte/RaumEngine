/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.entities
import org.dellamorte.raum.toolbox.vector.Vector3f


/**
 *
 * @author Raum
 */
class TileWater 
  def self.TILE_SIZE():float; 60; end
  attr_accessor x:float
  attr_accessor z:float
  attr_accessor h:float
  def initialize(centerX:float, centerZ:float, height:float):void
    @x = centerX
    @z = centerZ
    @h = height
  end
  
  def toVector():Vector3f
    Vector3f.new(@x, @h, @z)
  end
end


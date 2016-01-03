/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.terrains.Terrain


/**
 *
 * @author Raum
 */
class TerrainList 
	def initialize():void
		clear()
	end
	
	def clear():void
		@x = Terrain[0]
	end
	
	def get(i:int):Terrain
		return @x[i] if ((i > -1) and (i < @x.length()))
		return Terrain(nil)
	end

	def add(terrain:Terrain):void
		tmp = Terrain[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = terrain
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():Terrain[]
		@x
  end
  
  def getTerrainAt(x:float, z:float):Terrain
    out = Terrain(nil)
    @x.length().times do |i:int|
      next unless @x[i].pointInBorder(x, z)
      out = @x[i]
      break
    end
    return out
  end
	
end


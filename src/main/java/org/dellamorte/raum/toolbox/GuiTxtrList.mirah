/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.guis.GuiTexture


/**
 *
 * @author Raum
 */
class GuiTxtrList 
	def initialize():void
		@x = GuiTexture[0]
	end

	def get(i:int):GuiTexture
		return @x[i] if ((i > -1) and (i < @x.length()))
		return GuiTexture(nil)
	end

	def add(v3:GuiTexture):void
		tmp = GuiTexture[@x.length() + 1]
		@x.length().times do |i:int|
			tmp[i] = @x[i]
		end
		tmp[@x.length()] = v3
		@x = tmp
	end
	
	def size():int
		@x.length()
	end
	
	def array():GuiTexture[]
		@x
	end
end


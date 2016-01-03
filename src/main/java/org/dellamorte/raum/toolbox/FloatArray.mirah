/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox

import java.util.List
/**
 *
 * @author Raum
 */
class FloatArray 
	def self.gen(vals:List):float[]
		out = float[vals.size()]
		vals.size().times {|i:int| out[i] = Double(vals.get(i)).floatValue() }
		return out
	end
	
	def initialize(sz:int):void
		@x = float[sz]
	end
	
	def set(loc:int, val:float):void
		(@x[loc] = val) if ((loc > -1) and (loc < @x.length()))
	end
	
	def reset(loc:int):void
		(@x[loc] = float(0.0)) if ((loc > -1) and (loc < @x.length()))
	end
	
	def array():float[]
		@x
	end
end


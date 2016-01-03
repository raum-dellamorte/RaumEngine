/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.textures

import TerrainTexture

/**
 *
 * @author Raum
 */
class TerrainTexturePack 
	def initialize(bgTexture:TerrainTexture, 
								 rTexture:TerrainTexture, 
								 gTexture:TerrainTexture, 
								 bTexture:TerrainTexture):void
		@bg = bgTexture
		@r = rTexture
		@g = gTexture
		@b = bTexture
	end
	
	def getBGTexture():TerrainTexture
		@bg
	end
	
	def getRTexture():TerrainTexture
		@r
	end
	
	def getGTexture():TerrainTexture
		@g
	end
	
	def getBTexture():TerrainTexture
		@b
	end
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.textures

import TextureTerrain

/**
 *
 * @author Raum
 */
class TexturePackTerrain 
  def initialize(bgTexture:TextureTerrain, 
                 rTexture:TextureTerrain, 
                 gTexture:TextureTerrain, 
                 bTexture:TextureTerrain):void
    @bg = bgTexture
    @r = rTexture
    @g = gTexture
    @b = bTexture
  end
  
  def getBGTexture():TextureTerrain
    @bg
  end
  
  def getRTexture():TextureTerrain
    @r
  end
  
  def getGTexture():TextureTerrain
    @g
  end
  
  def getBTexture():TextureTerrain
    @b
  end
end


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.textures

/**
 *
 * @author Raum
 */
class TextureTerrain 
  def initialize(id:int):void
    @ttid = id
  end
  
  def getID():int
    @ttid
  end
end


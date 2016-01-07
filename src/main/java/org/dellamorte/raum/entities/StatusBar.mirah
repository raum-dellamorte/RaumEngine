/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.entities
import Player
import org.dellamorte.raum.textures.TextureGui


/**
 *
 * @author Raum
 */
class StatusBar 
  def initialize(player:Player, statusbar:TextureGui, statType:String):void
    @plyr = player
    @bar = statusbar
    @stat = statType
  end
  
  def update():void
    @bar.setXScalePercent(@plyr.getStat(@stat))
  end
end


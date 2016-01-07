/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.models
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.textures.Texture


/**
 *
 * @author Raum
 */
class TexturedModel 
  def initialize(model:RawModel, modelTexture:Texture):void
    @rawModel = model
    @texture = modelTexture
  end
  
  def getRawModel():RawModel
    @rawModel
  end
  
  def getModelTexture():Texture
    @texture
  end
end


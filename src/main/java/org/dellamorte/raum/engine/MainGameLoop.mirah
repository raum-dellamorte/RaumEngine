/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.engine
import org.dellamorte.raum.entities.Entity
import org.dellamorte.raum.entities.StatusBar
import org.dellamorte.raum.render.RenderGui
import org.dellamorte.raum.terrains.Terrain
import org.dellamorte.raum.textures.TextureGui
import org.dellamorte.raum.toolbox.vector.Vector3f


/**
 *
 * @author Raum
 */
class MainGameLoop 
  def self.main(args:String[]):void
    DisplayMgr.init()
    DisplayMgr.setBGColor(0.0, 0.0, 0.0, 0.0)
    
    mload = MasterLoader.new()
    
    TextMgr.init(mload.loader)
    
    ["arial", "berlinSans", "calibri", "candara", "courier", "harrington", 
     "pirate", "sans", "segoe", "segoeUI", "tahoma", "TimesNewRoman"].each do |str:String|
      mload.addFont(str)
    end
    
    ["HealthMeter", "HealthBarBG", "HealthBarFG", 
     "mytexture", "grassy2", "mud", "path", 
     "grassTexture", "fern", "stall", "playerTexture", 
     "blendMap", "pine"].each do |str:String|
      mload.addTexture(str)
    end
    
    mload.loadPlayer("person", "playerTexture", 50.0, -50.0)
    
    mload.addLight(0.0, 1000.0, -7000.0, 1.0, 1.0, 1.0)
    mload.addLight(185.0, 10.0, -293.0, 
                   2.0, 0.0, 0.0,
                   1.0, 0.01, 0.002)
    
    gui = mload.getTextureGui("HealthMeter", -0.73, 0.82, 0.25, 0.25)
    guis = TextureGui[3]
    guis[0] = mload.getTextureGui("HealthBarBG", -0.73, 0.82, 0.25, 0.25)
    guis[1] = mload.getTextureGui("HealthBarFG", -0.73, 0.82, 0.25, 0.25)
    guis[2] = mload.getTextureGui("HealthMeter", -0.73, 0.82, 0.25, 0.25)
    guiRend = RenderGui.new(mload.loader)
    
    #testGuiStrings = GuiString[1]
    #testGuiStrings[0] = mload.getGuiString("Hello World", -0.94, 0.88, 50)
    
    guiString = mload.getGUIText("Hello World", "candara", 2.5, 0.016, 0.02, 0.24, true)
    TextMgr.loadText(guiString)
    
    terrainTexture = mload.genTexturePackTerrain("grassy2", "mud", "mytexture", "path")
    bmap = mload.genTextureTerrain("blendMap")
    mload.addTerrain(Terrain.new( 0,-1, mload.loader, terrainTexture, bmap, "heightmap"))
    mload.addTerrain(Terrain.new(-1,-1, mload.loader, terrainTexture, bmap, "heightmap"))
    
    grass = mload.getTModel("grassModel", "grassTexture", true, true)
    fern = mload.getTModel("fern", "fern", true, true, 2)
    tree = mload.getTModel("pine", "pine")
    
    500.times do |i:int|
      if ((i % 2) == 0)
        mload.addEntity(Entity.new(fern, mload.rand.nextInt(4), mload.randomTerrainVector(),
          0, mload.rand.nextFloat() * float(360.0), 0, float(0.9)))
      end
      if ((i % 3) == 0)
        mload.addEntity(Entity.new(tree, 0, mload.randomTerrainVector(), 
          0, mload.rand.nextFloat() * float(360.0), 0, float(1.2)))
      end
      if ((i % 5) == 0)
        mload.addEntity(Entity.new(grass, 0, mload.randomTerrainVector(),
          0, mload.rand.nextFloat() * float(360.0), 0, float(1.2)))
      end
    end
    
    mload.addEntity(Entity.new(mload.getTModel("stall", "stall", 1, 10.0, 0.5), 0, Vector3f.new(
      float(0.0),float(0.0),float(-25.0)),
      float(0.0), float(135.0), float(0.0), float(3.0)))
    healthBar = StatusBar.new(mload.player, guis[1], "Health")
    
    until (DisplayMgr.isCloseRequested()) do
      DisplayMgr.prep()
      mload.renderScene()
      healthBar.update()
      guiRend.render(guis)
      TextMgr.render()
      DisplayMgr.updateDisplay()
    end
    
    TextMgr.cleanUp()
    guiRend.cleanUp()
    mload.cleanUp()
    DisplayMgr.close()
  end
end


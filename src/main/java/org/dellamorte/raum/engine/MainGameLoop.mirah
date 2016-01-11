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
import org.dellamorte.raum.fbuffers.FBufferWater
import org.dellamorte.raum.entities.GuiObj
import org.dellamorte.raum.toolbox.GuiObjList
import org.dellamorte.raum.toolbox.vector.Vector3f


/**
 *
 * @author Raum
 */
class MainGameLoop 
  def self.main(args:String[]):void
    DisplayMgr.init()
    DisplayMgr.setBGColor(0.0, 0.0, 0.0, 0.0)
    MasterLoader.init()
    
    gameMgr = MasterLoader.gameMgr()
    
    TextMgr.init(gameMgr.loader)
    
    ["arial", "berlinSans", "calibri", "candara", "courier", "harrington", 
     "pirate", "sans", "segoe", "segoeUI", "tahoma", "TimesNewRoman"].each do |str:String|
      gameMgr.addFont(str)
    end
    
    ["HealthMeter", "HealthBarBG", "HealthBarFG", 
     "mytexture", "grassy2", "mud", "path", 
     "grassTexture", "fern", "stall", "playerTexture", 
     "blendMap", "pine", "waterDUDV", "normalMap"].each do |str:String|
      gameMgr.addTexture(str)
    end
    
    gameMgr.loadPlayer("person", "playerTexture", 50.0, -50.0)
    
    gameMgr.addLight(0.0, 1000.0, -7000.0, 1.0, 1.0, 1.0)
    gameMgr.addLight(185.0, 10.0, -293.0, 
                   2.0, 0.0, 0.0,
                   1.0, 0.01, 0.002)
    
    guis = GuiObjList.new()
    guis.add(GuiObj.new(0.135, 0.08, 0.25).loadTextures(["HealthBarBG", "HealthBarFG", "HealthMeter"]))
    #guis.add(GuiObj.new(0.80, 0.20, 0.25).add(gameMgr.fbWater.getReflectionTexture))
    #guis.add(GuiObj.new(0.80, 0.80, 0.25).add(gameMgr.fbWater.getRefractionTexture))
    
    guiRend = RenderGui.new(gameMgr.loader)
    
    guiString = gameMgr.getGUIText("Hello World", "candara", 2.5, 0.015, 0.02, 0.24, true)
    TextMgr.loadText(guiString)
    
    terrainTexture = gameMgr.genTexturePackTerrain("grassy2", "mud", "mytexture", "path")
    bmap = gameMgr.genTextureTerrain("blendMap")
    gameMgr.addTerrain(Terrain.new( 0,-1, gameMgr.loader, terrainTexture, bmap, "heightmap"))
    gameMgr.addTerrain(Terrain.new(-1,-1, gameMgr.loader, terrainTexture, bmap, "heightmap"))
    
    grass = gameMgr.getTModel("grassModel", "grassTexture", true, true)
    fern = gameMgr.getTModel("fern", "fern", true, true, 2)
    tree = gameMgr.getTModel("pine", "pine")
    
    500.times do |i:int|
      if ((i % 2) == 0)
        gameMgr.addEntity(Entity.new(fern, gameMgr.rand.nextInt(4), gameMgr.randomTerrainVector(),
          0, gameMgr.rand.nextFloat() * float(360.0), 0, float(0.9)))
      end
      if ((i % 3) == 0)
        gameMgr.addEntity(Entity.new(tree, 0, gameMgr.randomTerrainVector(), 
          0, gameMgr.rand.nextFloat() * float(360.0), 0, float(1.2)))
      end
      if ((i % 5) == 0)
        gameMgr.addEntity(Entity.new(grass, 0, gameMgr.randomTerrainVector(),
          0, gameMgr.rand.nextFloat() * float(360.0), 0, float(1.2)))
      end
    end
    
    gameMgr.addEntity(Entity.new(gameMgr.getTModel("stall", "stall", 1, 10.0, 0.5), 0, Vector3f.new(
      float(0.0),float(0.0),float(-25.0)),
      float(0.0), float(135.0), float(0.0), float(3.0)))
    #healthBar = StatusBar.new(gameMgr.player, guis[1], "Health")
    
    
    
    until (DisplayMgr.isCloseRequested()) do
      DisplayMgr.prep()
      
      gameMgr.renderScene(true)
      #healthBar.update()
      guiRend.render(guis)
      TextMgr.render()
      DisplayMgr.updateDisplay()
    end
    
    TextMgr.cleanUp()
    guiRend.cleanUp()
    gameMgr.cleanUp()
    DisplayMgr.close()
  end
end


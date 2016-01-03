/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import Maths
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.terrains.Terrain
#import org.lwjgl.input.Mouse
import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.input.Mouse
import org.dellamorte.raum.input.MousePos
import org.dellamorte.raum.toolbox.vector.Vector4f

/**
 *
 * @author Raum
 */
class MousePicker 
	def self.recursionCount():int; 200; end
	def self.rayRange():float; float(600); end
  
	def initialize(camera:Camera, projection:Matrix4f, terrains:TerrainList):void
    @cam = camera
    @pMatrix = projection
    @vMatrix = Maths.createViewMatrix(@cam)
    @terrs = terrains
    @curRay = Vector3f(nil)
    @curTerrainPoint = Vector3f(nil)
  end
	
	def getCurrentTerrainPoint():Vector3f
		@curTerrainPoint
	end
  
  def getCurrentRay():Vector3f
    @curRay
  end
  
  def update():void
    @vMatrix = Maths.createViewMatrix(@cam)
    @curRay = calcMouseRay()
		if (intersectionInRange(0, MousePicker.rayRange(), @curRay))
			currentTerrainPoint = binarySearch(0, 0, MousePicker.rayRange(), @curRay)
		else
			currentTerrainPoint = nil
		end
  end
  
  def calcMouseRay():Vector3f
    mx = MousePos.getX()
    my = MousePos.getY()
    normCoords = getNormalizedDeviceCoords(mx, my)
    return toWorldCoords(toEyeCoords(Vector4f.new(normCoords.x, normCoords.y, float(-1.0), float(1.0))))
  end
  
  def getNormalizedDeviceCoords(mouseX:double, mouseY:double):Vector2f
    DisplayMgr.updateWH()
    x = double(((double(2.0) * mouseX) / double(DisplayMgr.getWidth())) - double(1.0))
    y = double(((double(2.0) * mouseY) / double(DisplayMgr.getHeight())) - double(1.0))
    return Vector2f.new(float(x), float(y))
  end
  
  def toEyeCoords(clipCoords:Vector4f):Vector4f
    invPMatrix = Matrix4f.invert(@pMatrix, Matrix4f(nil))
    eyeCoords = Matrix4f.transform(invPMatrix, clipCoords, nil)
    return Vector4f.new(eyeCoords.x, eyeCoords.y, float(-1.0), float(0.0))
  end
  
  def toWorldCoords(eyeCoords:Vector4f):Vector3f
    Matrix4f.invert(@vMatrix, (invVMatrix = Matrix4f.new()))
    rayWorld = Matrix4f.transform(invVMatrix, eyeCoords, nil)
    mouseRay = Vector3f.new(rayWorld.x, rayWorld.y, rayWorld.z)
    mouseRay.normalize()
    return mouseRay
  end
  
  def getPointOnRay(ray:Vector3f, distance:float):Vector3f
		camPos = @cam.getPosition()
		start = Vector3f.new(camPos.x, camPos.y, camPos.z)
		scaledRay = Vector3f.new(ray.x * distance, ray.y * distance, ray.z * distance)
		return Vector3f.add(start, scaledRay, nil)
	end
	
	def binarySearch(count:int, start:float, finish:float, ray:Vector3f):Vector3f
		half = float(start + ((finish - start) / float(2)))
		if (count >= MousePicker.recursionCount())
			endPoint = getPointOnRay(ray, half)
			terrain = getTerrain(endPoint.x, endPoint.z)
			return ((terrain != nil) ? endPoint : nil)
		end
		return ((intersectionInRange(start, half, ray)) ? 
      binarySearch(count + 1, start, half, ray) : binarySearch(count + 1, half, finish, ray))
	end

	def intersectionInRange(start:float, finish:float, ray:Vector3f):boolean
		startPoint = getPointOnRay(ray, start)
		endPoint = getPointOnRay(ray, finish)
		return (!isUnderGround(startPoint) and isUnderGround(endPoint))
	end

	def isUnderGround(testPoint:Vector3f):boolean
		terrain = Terrain(getTerrain(testPoint.x, testPoint.z))
		height = float(0.0)
		height = terrain.getHeightOfTerrain(testPoint.x(), testPoint.z()) if (terrain != nil)
		return (testPoint.y < height)
	end

	def getTerrain(worldX:float, worldZ:float):Terrain
    @terrs.getTerrainAt(worldX, worldZ)
	end
end


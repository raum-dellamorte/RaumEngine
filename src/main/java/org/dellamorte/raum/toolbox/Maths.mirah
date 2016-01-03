/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.dellamorte.raum.toolbox.vector.Matrix4f


/**
 *
 * @author Raum
 */
class Maths 
	def self.barryCentric(p1:Vector3f, p2:Vector3f, p3:Vector3f, pos:Vector2f):float
		det = float(((p2.z - p3.z) * (p1.x - p3.x)) + ((p3.x - p2.x) * (p1.z - p3.z)))
		l1 = float((((p2.z - p3.z) * (pos.x - p3.x)) + ((p3.x - p2.x) * (pos.y - p3.z))) / det)
		l2 = float((((p3.z - p1.z) * (pos.x - p3.x)) + ((p1.x - p3.x) * (pos.y - p3.z))) / det)
		l3 = float(float(1.0) - float(l1)) - float(l2)
		return float(((l1 * p1.y) + (l2 * p2.y)) + (l3 * p3.y))
	end
	
	def self.createTransformationMatrix(translation:Vector3f, rx:float, ry:float, rz:float, scale:float):Matrix4f
		matrix = Matrix4f.new()
		matrix.setIdentity()
		Matrix4f.translate(translation, matrix, matrix)
		Matrix4f.rotate(float(Math.toRadians(rx)), Vector3f.new(1,0,0), matrix, matrix)
		Matrix4f.rotate(float(Math.toRadians(ry)), Vector3f.new(0,1,0), matrix, matrix)
		Matrix4f.rotate(float(Math.toRadians(rz)), Vector3f.new(0,0,1), matrix, matrix)
		Matrix4f.scale(Vector3f.new(scale, scale, scale), matrix, matrix)
		return matrix
	end
  
  def self.createTransformationMatrix(translation:Vector2f, scale:Vector2f, drawOrder:int):Matrix4f
		matrix = Matrix4f.new()
		matrix.setIdentity()
    depth = float(-(float(drawOrder) * float(0.00001)))
		trans = Vector3f.new(translation.x, translation.y, depth)
    Matrix4f.translate(trans, matrix, matrix)
		Matrix4f.scale(Vector3f.new(scale.x, scale.y, float(1.0)), matrix, matrix)
		return matrix
	end
  
  def self.createTransformationMatrix(translation:Vector2f, scale:Vector2f):Matrix4f
    createTransformationMatrix(translation, scale, 0)
  end
	
	def self.createViewMatrix(camera:Camera):Matrix4f
		viewMatrix = Matrix4f.new()
		viewMatrix.setIdentity()
		Matrix4f.rotate(float(Math.toRadians(camera.getPitch())), Vector3f.new(1,0,0), viewMatrix, viewMatrix)
		Matrix4f.rotate(float(Math.toRadians(camera.getYaw())), Vector3f.new(0,1,0), viewMatrix, viewMatrix)
		camPos = camera.getPosition()
		negCam = Vector3f.new(-camPos.x,-camPos.y,-camPos.z)
		Matrix4f.translate(negCam, viewMatrix, viewMatrix)
		return viewMatrix
  end
end


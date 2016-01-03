/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.engine
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL13
import org.lwjgl.opengl.GL20
import org.lwjgl.opengl.GL30
import org.dellamorte.raum.entities.Camera
import org.dellamorte.raum.entities.Entity
import org.dellamorte.raum.entities.Light
import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.models.TexturedModel
import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderModel
import org.dellamorte.raum.textures.Texture
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.toolbox.TModelBox
import org.dellamorte.raum.toolbox.TModelMap
import org.dellamorte.raum.engine.DisplayMgr
import org.dellamorte.raum.toolbox.vector.Matrix4f


/**
 *
 * @author Raum
 */
class EntityRenderer
	def initialize(shader:ShaderModel, projectionMatrix:Matrix4f):void
		@shdr = shader
		Shader0(@shdr).start()
		@shdr.loadProjectionMatrix(projectionMatrix)
		Shader0(@shdr).stop()
	end
	
	def render(tmap:TModelMap):void
		models = tmap.array()
		models.each do |modelBox:TModelBox|
			model = modelBox.model()
			prepareTexturedModel(model)
			entities = modelBox.array()
			entities.each do |entity:Entity|
				prepareInstance(entity)
				GL11.glDrawElements(
					GL11.GL_TRIANGLES, 
					model.getRawModel().getVertexCount(), 
					GL11.GL_UNSIGNED_INT, 0); #puts "drawing entity"
			end
			unbindTexturedModel()
		end
	end
	
	def prepareTexturedModel(model:TexturedModel):void
		rawModel = RawModel(model.getRawModel())
		GL30.glBindVertexArray(rawModel.getVaoID())
		GL20.glEnableVertexAttribArray(0)
		GL20.glEnableVertexAttribArray(1)
		GL20.glEnableVertexAttribArray(2)
		texture = model.getModelTexture()
		@shdr.loadNumberOfRows(texture.getNumberOfRows())
		MasterRenderer.disableCulling() if (texture.getTransparency())
		@shdr.loadFakeLightingVariable(texture.getUseFakeLighting())
		@shdr.loadShineVariables(texture.getShineDamper(), texture.getReflectivity())
		GL13.glActiveTexture(GL13.GL_TEXTURE0)
		GL11.glBindTexture(GL11.GL_TEXTURE_2D, model.getModelTexture().getID())
	end
	
	def unbindTexturedModel():void
		MasterRenderer.enableCulling()
		GL20.glDisableVertexAttribArray(0)
		GL20.glDisableVertexAttribArray(1)
		GL20.glDisableVertexAttribArray(2)
		GL30.glBindVertexArray(0)
	end
	
	def prepareInstance(entity:Entity):void
		transformationMatrix = Matrix4f(Maths.createTransformationMatrix(
			entity.getPosition(), 
			entity.getRotX(), 
			entity.getRotY(), 
			entity.getRotZ(), 
			entity.getScale()))
		@shdr.loadTransformationMatrix(transformationMatrix)
		@shdr.loadOffset(entity.getTextureXOffset(), entity.getTextureYOffset())
	end
end


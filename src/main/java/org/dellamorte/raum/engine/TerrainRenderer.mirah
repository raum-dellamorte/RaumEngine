package org.dellamorte.raum.engine

import org.dellamorte.raum.models.RawModel
import org.dellamorte.raum.shaders.Shader0
import org.dellamorte.raum.shaders.ShaderTerrain
import org.dellamorte.raum.terrains.Terrain
import org.dellamorte.raum.textures.TerrainTexture
import org.dellamorte.raum.textures.TerrainTexturePack
import org.dellamorte.raum.toolbox.Maths
import org.dellamorte.raum.toolbox.vector.Matrix4f
import org.dellamorte.raum.toolbox.vector.Vector3f
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL13
import org.lwjgl.opengl.GL20
import org.lwjgl.opengl.GL30


/**
 *
 * @author Raum
 */
class TerrainRenderer 
	def initialize(shader:ShaderTerrain, projectionMatrix:Matrix4f):void
		@shdr = shader
		Shader0(@shdr).start
		@shdr.loadProjectionMatrix(projectionMatrix)
		@shdr.connectTextureUnits()
		Shader0(@shdr).stop
	end
	
	def render(terrains:Terrain[]):void
		terrains.each do |terrain:Terrain|
			prepareTerrain(terrain)
			loadModelMatrix(terrain)
			GL11.glDrawElements(
				GL11.GL_TRIANGLES, 
				terrain.getModel().getVertexCount(), 
				GL11.GL_UNSIGNED_INT, 0)
			unbindTexturedModel()
		end
	end
	
	def prepareTerrain(terrain:Terrain):void
		rawModel = RawModel(terrain.getModel())
		GL30.glBindVertexArray(rawModel.getVaoID())
		GL20.glEnableVertexAttribArray(0)
		GL20.glEnableVertexAttribArray(1)
		GL20.glEnableVertexAttribArray(2)
		bindTextures(terrain)
		@shdr.loadShineVariables(float(1.0), float(0.0))
	end
	
	def bindTextures(terrain:Terrain):void
		textures = terrain.getTexturePack()
		GL13.glActiveTexture(GL13.GL_TEXTURE0)
		GL11.glBindTexture(GL11.GL_TEXTURE_2D, textures.getBGTexture.getID())
		GL13.glActiveTexture(GL13.GL_TEXTURE1)
		GL11.glBindTexture(GL11.GL_TEXTURE_2D, textures.getRTexture.getID())
		GL13.glActiveTexture(GL13.GL_TEXTURE2)
		GL11.glBindTexture(GL11.GL_TEXTURE_2D, textures.getGTexture.getID())
		GL13.glActiveTexture(GL13.GL_TEXTURE3)
		GL11.glBindTexture(GL11.GL_TEXTURE_2D, textures.getBTexture.getID())
		GL13.glActiveTexture(GL13.GL_TEXTURE4)
		GL11.glBindTexture(GL11.GL_TEXTURE_2D, terrain.getBlendMap.getID())
	end
	
	def unbindTexturedModel():void
		GL20.glDisableVertexAttribArray(0)
		GL20.glDisableVertexAttribArray(1)
		GL20.glDisableVertexAttribArray(2)
		GL30.glBindVertexArray(0)
	end
	
	def loadModelMatrix(terrain:Terrain):void
		transformationMatrix = Matrix4f(Maths.createTransformationMatrix(
			Vector3f.new(terrain.getX(), float(0.0), terrain.getZ()), 
			float(0.0), float(0.0), float(0.0), float(1.0)))
		@shdr.loadTransformationMatrix(transformationMatrix)
	end
end


package org.dellamorte.raum.objConverter

class ModelData

	def initialize(verticesArray:float[], textureCoordsArray:float[], normalsArray:float[], indicesArray:int[], furthestPointFloat:float):void
		@vertices = verticesArray
		@textureCoords = textureCoordsArray
		@normals = normalsArray
		@indices = indicesArray
		@furthestPoint = furthestPointFloat
	end

	def getVertices():float[]
		@vertices
	end

	def getTextureCoords():float[]
		@textureCoords
	end

	def getNormals():float[]
		@normals
	end

	def getIndices():int[]
		@indices
	end

	def getFurthestPoint():float
		@furthestPoint
	end

end

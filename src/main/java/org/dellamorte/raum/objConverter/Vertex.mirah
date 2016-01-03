package org.dellamorte.raum.objConverter

import org.dellamorte.raum.toolbox.vector.Vector3f

class Vertex
	@@noIndex = -1
	
	def initialize(indexInt:int, positionVect:Vector3f)
		@@noInxex = -1
		@index = indexInt
		@position = positionVect
		@length = @position.length()
		@textureIndex = @@noIndex
		@normalIndex = @@noIndex
		@duplicateVertex = Vertex(nil)
	end
	
	def getIndex():int
		@index
	end
	
	def getLength():float
		@length
	end
	
	def isSet():boolean
		((@textureIndex != @@noIndex) && (@normalIndex != @@noIndex))
	end
	
	def hasSameTextureAndNormal(textureIndexOther:int, normalIndexOther:int):boolean
		((textureIndexOther == @textureIndex) && (normalIndexOther == @normalIndex))
	end
	
	def setTextureIndex(textureIndexInt:int):void
		@textureIndex = textureIndexInt
	end
	
	def setNormalIndex(normalIndexInt:int):void
		@normalIndex = normalIndexInt
	end

	def getPosition():Vector3f
		@position
	end

	def getTextureIndex():int
		@textureIndex
	end

	def getNormalIndex():int
		@normalIndex
	end

	def getDuplicateVertex():Vertex
		@duplicateVertex
	end

	def setDuplicateVertex(vertexDuplicate:Vertex):void
		@duplicateVertex = vertexDuplicate
	end

end

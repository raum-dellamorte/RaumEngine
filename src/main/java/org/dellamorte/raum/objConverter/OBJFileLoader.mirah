package org.dellamorte.raum.objConverter

import java.io.BufferedReader
import java.io.File
import java.io.FileNotFoundException
import java.io.FileReader
import java.io.IOException

import org.dellamorte.raum.toolbox.IList
import org.dellamorte.raum.toolbox.V2List
import org.dellamorte.raum.toolbox.V3List
import org.dellamorte.raum.toolbox.VertexList
import org.dellamorte.raum.toolbox.vector.Vector2f
import org.dellamorte.raum.toolbox.vector.Vector3f

class OBJFileLoader
	
	@@resLoc = "res/obj/"

	def self.loadOBJ(objFileName:String):ModelData
		isr = FileReader(nil)
		objFile = File.new(@@resLoc + objFileName + ".obj")
		begin
			isr = FileReader.new(objFile)
		rescue #} catch (e:FileNotFoundException) {
			System.err.println("File not found in res; don't use any extention")
		end
		reader = BufferedReader.new(isr)
		line = ""
		vertices = VertexList.new()
		textures = V2List.new()
		normals = V3List.new()
		indices = IList.new()
		begin #try {
			while (true) do
				line = reader.readLine()
				if (line.startsWith("v "))
					currentLine = line.split(" ")
					vertex = Vector3f.new(Float.parseFloat(currentLine[1]),
							Float.parseFloat(currentLine[2]),
							Float.parseFloat(currentLine[3]))
					newVertex = Vertex.new(vertices.size(), vertex);
					vertices.add(newVertex)

				elsif (line.startsWith("vt "))
					currentLine = line.split(" ")
					texture = Vector2f.new(Float.parseFloat(currentLine[1]),
							Float.parseFloat(currentLine[2]));
					textures.add(texture)
				elsif (line.startsWith("vn "))
					currentLine = line.split(" ")
					normal = Vector3f.new(Float.parseFloat(currentLine[1]),
							Float.parseFloat(currentLine[2]),
							Float.parseFloat(currentLine[3]))
					normals.add(normal)
				elsif (line.startsWith("f "))
					break
				end
			end
			while (line != nil && line.startsWith("f ")) do
				currentLine = line.split(" ");
				vertex1 = currentLine[1].split("/");
				vertex2 = currentLine[2].split("/");
				vertex3 = currentLine[3].split("/");
				processVertex(vertex1, vertices, indices);
				processVertex(vertex2, vertices, indices);
				processVertex(vertex3, vertices, indices);
				line = reader.readLine();
			end
			reader.close()
		rescue#} catch (e:IOException) {
			System.err.println("Error reading the file")
		end
		removeUnusedVertices(vertices)
		verticesArray = float[vertices.size() * 3]
		texturesArray = float[vertices.size() * 2]
		normalsArray = float[vertices.size() * 3]
		furthest = convertDataToArrays(vertices, textures, normals, verticesArray,
				texturesArray, normalsArray)
		indicesArray = convertIndicesListToArray(indices)
		data = ModelData.new(verticesArray, texturesArray, normalsArray, indicesArray, furthest)
		return data
	end

	def self.processVertex(vertex:String[], vertices:VertexList, indices:IList):void
		index = Integer.parseInt(vertex[0]) - 1
		currentVertex = vertices.get(index)
		textureIndex = Integer.parseInt(vertex[1]) - 1
		normalIndex = Integer.parseInt(vertex[2]) - 1
		if (!currentVertex.isSet())
			currentVertex.setTextureIndex(textureIndex)
			currentVertex.setNormalIndex(normalIndex)
			indices.add(index)
		else
			dealWithAlreadyProcessedVertex(currentVertex, textureIndex, normalIndex, indices, vertices)
		end
	end

	def self.convertIndicesListToArray(indices:IList):int[]
		indicesArray = int[indices.size()]
		indicesArray.length.times do |i:int|
			indicesArray[i] = indices.get(i).intValue
		end
		return indicesArray
	end

	def self.convertDataToArrays(vertices:VertexList, textures:V2List,
			normals:V3List, verticesArray:float[], texturesArray:float[],
			normalsArray:float[]):float
		furthestPoint = float(0.0)
		vertices.size().times do |i:int|
			currentVertex = vertices.get(i)
			(furthestPoint = currentVertex.getLength()) if (currentVertex.getLength() > furthestPoint)
			position = currentVertex.getPosition()
			textureCoord = textures.get(currentVertex.getTextureIndex())
			normalVector = normals.get(currentVertex.getNormalIndex())
			verticesArray[i * 3]       = position.x
			verticesArray[(i * 3) + 1] = position.y
			verticesArray[(i * 3) + 2] = position.z
			texturesArray[i * 2]       = textureCoord.x
			texturesArray[(i * 2) + 1] = 1 - textureCoord.y
			normalsArray[i * 3]        = normalVector.x
			normalsArray[(i * 3) + 1]  = normalVector.y
			normalsArray[(i * 3) + 2]  = normalVector.z
		end
		return furthestPoint
	end

	def self.dealWithAlreadyProcessedVertex(previousVertex:Vertex, newTextureIndex:int,
			newNormalIndex:int, indices:IList, vertices:VertexList):void
		if (previousVertex.hasSameTextureAndNormal(newTextureIndex, newNormalIndex))
			indices.add(previousVertex.getIndex())
		else
			anotherVertex = previousVertex.getDuplicateVertex()
			if (anotherVertex != nil)
				dealWithAlreadyProcessedVertex(anotherVertex, newTextureIndex, newNormalIndex,
						indices, vertices)
			else
				duplicateVertex = Vertex.new(vertices.size(), previousVertex.getPosition())
				duplicateVertex.setTextureIndex(newTextureIndex)
				duplicateVertex.setNormalIndex(newNormalIndex)
				previousVertex.setDuplicateVertex(duplicateVertex)
				vertices.add(duplicateVertex)
				indices.add(duplicateVertex.getIndex())
			end
		end
	end
	
	def self.removeUnusedVertices(vertices:VertexList):void
		vertices.array.each do |vertex:Vertex|
			if (!vertex.isSet())
				vertex.setTextureIndex(0);
				vertex.setNormalIndex(0);
			end
		end
	end
end
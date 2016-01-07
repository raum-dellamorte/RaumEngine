package org.dellamorte.raum.toolbox

import org.dellamorte.raum.objConverter.Vertex


/**
 *
 * @author Raum
 */
class VertexList
  def initialize():void
    @x = Vertex[0]
  end

  def get(i:int):Vertex
    return @x[i] if ((i > -1) and (i < @x.length()))
    return Vertex(nil)
  end

  def add(v:Vertex):void
    tmp = Vertex[@x.length() + 1]
    @x.length().times do |i:int|
      tmp[i] = @x[i]
    end
    tmp[@x.length()] = v
    @x = tmp
  end
  
  def size():int
    @x.length()
  end
  
  def array():Vertex[]
    @x
  end
end


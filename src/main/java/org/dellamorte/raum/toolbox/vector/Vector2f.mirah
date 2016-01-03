
package org.dellamorte.raum.toolbox.vector
#import java.io.Serializable
import java.nio.FloatBuffer

class Vector2f < Vector
  #private static final serialVersionUID = long(1L)
  attr_accessor x:float
  attr_accessor y:float
  def initialize():void
    super()
  end
  
  def initialize(x:float, y:float):void
    set(x, y)
  end
  
  def set(x:float, y:float):void
    @x = x
    @y = y
  end
  
  def lengthSquared():float
    return x * x + y * y
  end
  
  def translate(x:float, y:float):Vector2f
    @x += x
    @y += y
    return self
  end
  
  def negate():Vector
    x = -x
    y = -y
    return Vector(self)
  end
  
  def negate(dest:Vector2f):Vector2f
    (dest = Vector2f.new()) if (dest == nil)
    dest.x = -x
    dest.y = -y
    return dest
  end
  
  def normalize(dest:Vector2f):Vector2f
    l = Vector(self).length()
    if (dest == nil)
      dest = Vector2f.new(@x / l, @y / l)
    else
      dest.set(@x / l, @y / l)
    end
    return dest
  end
  
  def self.dot(left:Vector2f, right:Vector2f):float
    return left.x * right.x + left.y * right.y
  end
  
  def self.angle(a:Vector2f, b:Vector2f):float
    dls = float(dot(a, b) / (Vector(a).length() * Vector(b).length()))
    if (dls < -float(1))
      dls = -float(1)
    elsif (dls > float(1.0))
      dls = float(1.0)
    end
    return float(Math.acos(dls))
  end
  
  def self.add(left:Vector2f, right:Vector2f, dest:Vector2f):Vector2f
    if (dest == nil)
    return Vector2f.new(left.x + right.x, left.y + right.y)
    else
      dest.set(left.x + right.x, left.y + right.y)
      return dest
    end
  end
  
  def self.sub(left:Vector2f, right:Vector2f, dest:Vector2f):Vector2f
    if (dest == nil)
    return Vector2f.new(left.x - right.x, left.y - right.y)
    else
      dest.set(left.x - right.x, left.y - right.y)
      return dest
    end
  end
  
  def store(buf:FloatBuffer):Vector
    buf.put(@x)
    buf.put(@y)
    return self
  end
  
  def load(buf:FloatBuffer):Vector
    @x = buf.get()
    @y = buf.get()
    return self
  end
  
  def scale(scale:float):Vector
    @x *= scale
    @y *= scale
    return self
  end
  
  def toString():String
    sb = StringBuilder(StringBuilder.new(64))
    sb.append("Vector2f[")
    sb.append(x)
    sb.append(", ")
    sb.append(y)
    sb.append(']')
    return sb.toString()
  end
  
  def equals(obj:Object):boolean
    return true if (obj == Object(self))
    return false if (obj == nil)
    return false if (getClass() != obj.getClass())
    other = Vector2f(obj)
    return true if (x == other.x && y == other.y)
    return false
  end
  
end
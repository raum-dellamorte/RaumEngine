
package org.dellamorte.raum.toolbox.vector

#import java.io.Serializable
import java.nio.FloatBuffer

class Vector4f < Vector
  #private static final serialVersionUID = long(1L)
  attr_accessor x:float
  attr_accessor y:float
  attr_accessor z:float
  attr_accessor w:float
  def initialize():void
    super()
  end
  
  def initialize(x:float, y:float, z:float, w:float):void
    set(x, y, z, w)
  end
  
  def set(x:float, y:float):void
    @x = x
    @y = y
  end
  
  def set(x:float, y:float, z:float):void
    @x = x
    @y = y
    @z = z
  end
  
  def set(x:float, y:float, z:float, w:float):void
    @x = x
    @y = y
    @z = z
    @w = w
  end
  
  def lengthSquared():float
    return x * x + y * y + z * z + w * w
  end
  
  def translate(x:float, y:float, z:float, w:float):Vector4f
    @x += x
    @y += y
    @z += z
    @w += w
    return self
  end
  
  def self.add(left:Vector4f, right:Vector4f, dest:Vector4f):Vector4f
    if (dest == nil)
    return Vector4f.new(left.x + right.x, left.y + right.y, left.z + right.z, left.w + right.w)
    else
      dest.set(left.x + right.x, left.y + right.y, left.z + right.z, left.w + right.w)
      return dest
    end
  end
  
  def self.sub(left:Vector4f, right:Vector4f, dest:Vector4f):Vector4f
    if (dest == nil)
    return Vector4f.new(left.x - right.x, left.y - right.y, left.z - right.z, left.w - right.w)
    else
      dest.set(left.x - right.x, left.y - right.y, left.z - right.z, left.w - right.w)
      return dest
    end
  end
  
  def negate():Vector
    x = -x
    y = -y
    z = -z
    w = -w
    return self
  end
  
  def negate(dest:Vector4f):Vector4f
    dest = Vector4f.new() if (dest == nil)
    dest.x = -@x
    dest.y = -@y
    dest.z = -@z
    dest.w = -@w
    return dest
  end
  
  def normalize(dest:Vector4f):Vector4f
    l = Vector(self).length()
    if (dest == nil)
      dest = Vector4f.new(@x / l, @y / l, @z / l, @w / l)
    else
      dest.set(@x / l, @y / l, @z / l, @w / l)
    end
    return dest
  end
  
  def self.dot(left:Vector4f, right:Vector4f):float
    return left.x * right.x + left.y * right.y + left.z * right.z + left.w * right.w
  end
  
  def self.angle(a:Vector4f, b:Vector4f):float
    dls = float(dot(a, b) / (Vector(a).length() * Vector(b).length()))
    if (dls < -float(1))
      dls = -float(1)
    elsif (dls > float(1.0))
      dls = float(1.0)
    end
    return float(Math.acos(dls))
  end
  
  def load(buf:FloatBuffer):Vector
    @x = buf.get()
    @y = buf.get()
    @z = buf.get()
    @w = buf.get()
    return self
  end
  
  def scale(scale:float):Vector
    @x *= scale
    @y *= scale
    @z *= scale
    @w *= scale
    return self
  end
  
  def store(buf:FloatBuffer):Vector
    buf.put(@x)
    buf.put(@y)
    buf.put(@z)
    buf.put(@w)
    return self
  end
  
  def toString():String
    return "Vector4f: " + @x + " " + @y + " " + @z + " " + @w
  end
  
  def equals(obj:Object):boolean
    return true if (Object(self) == obj)
    return false if (obj == nil)
    return false if (getClass() != obj.getClass())
    other = Vector4f(obj)
    return true if (@x == other.x && @y == other.y && @z == other.z && @w == other.w)
    return false
  end
  
end
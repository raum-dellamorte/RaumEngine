
/*
 * Copyright (c) 2002-2008 LWJGL Project
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the name of 'LWJGL' nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/
package org.dellamorte.raum.toolbox.vector

#import java.io.Serializable
import java.nio.FloatBuffer
/**
 *
 * Holds a 3-tuple vector.
 *
 * @author cix_foo <cix_foo@users.sourceforge.net>
 * @version $Revision$
 * $Id$
 **/
class Vector3f < Vector
  #private static final serialVersionUID = long(1L)
  attr_accessor x:float
  attr_accessor y:float
  attr_accessor z:float
  /**
	 * Constructor for Vector3f.
	 **/
  def initialize():void
    super()
  end
  
  /**
	 * Constructor
	 **/
  def initialize(x:float, y:float, z:float):void
    set(x, y, z)
  end
  
  /* (non-Javadoc)
	 * @see org.lwjgl.util.vector.WritableVector2f#set(float, float)
	 **/
  def set(x:float, y:float):void
    @x = x
    @y = y
  end
  
  /* (non-Javadoc)
	 * @see org.lwjgl.util.vector.WritableVector3f#set(float, float, float)
	 **/
  def set(x:float, y:float, z:float):void
    @x = x
    @y = y
    @z = z
  end
  
  /**
	 * @return the length squared of the vector
	 **/
  def lengthSquared():float
    return @x * @x + @y * @y + @z * @z
  end
  
  /**
	 * Translate a vector
	 * @param x The translation in x
	 * @param y the translation in y
	 * @return this
	 **/
  def translate(x:float, y:float, z:float):Vector3f
    @x += x
    @y += y
    @z += z
    return self
  end
  
  /**
	 * Add a vector to another vector and place the result in a destination
	 * vector.
	 * @param left The LHS vector
	 * @param right The RHS vector
	 * @param dest The destination vector, or null if a new vector is to be created
	 * @return the sum of left and right in dest
	 **/
  def self.add(left:Vector3f, right:Vector3f, dest:Vector3f):Vector3f
    if (dest == nil)
      return Vector3f.new(left.x + right.x, left.y + right.y, left.z + right.z)
    else
      dest.set(left.x + right.x, left.y + right.y, left.z + right.z)
      return dest
    end
  end
  
  /**
	 * Subtract a vector from another vector and place the result in a destination
	 * vector.
	 * @param left The LHS vector
	 * @param right The RHS vector
	 * @param dest The destination vector, or null if a new vector is to be created
	 * @return left minus right in dest
	 **/
  def self.sub(left:Vector3f, right:Vector3f, dest:Vector3f):Vector3f
    if (dest == nil)
      return Vector3f.new(left.x - right.x, left.y - right.y, left.z - right.z)
    else
      dest.set(left.x - right.x, left.y - right.y, left.z - right.z)
      return dest
    end
  end
  
  /**
	 * The cross product of two vectors.
	 *
	 * @param left The LHS vector
	 * @param right The RHS vector
	 * @param dest The destination result, or null if a new vector is to be created
	 * @return left cross right
	 **/
  def self.cross(left:Vector3f, right:Vector3f, dest:Vector3f):Vector3f
    dest = Vector3f.new() if (dest == nil)
    dest.set( left.y * right.z - left.z * right.y, right.x * left.z - right.z * left.x, left.x * right.y - left.y * right.x )
    return dest
  end
  
  /**
	 * Negate a vector
	 * @return this
	 **/
  def negate():Vector
    @x = -@x
    @y = -@y
    @z = -@z
    return self
  end
  
  /**
	 * Negate a vector and place the result in a destination vector.
	 * @param dest The destination vector or null if a new vector is to be created
	 * @return the negated vector
	 **/
  def negate(dest:Vector3f):Vector3f
    dest = Vector3f.new() if (dest == nil)
    dest.x = -@x
    dest.y = -@y
    dest.z = -@z
    return dest
  end
  
  /**
	 * Normalise this vector and place the result in another vector.
	 * @param dest The destination vector, or null if a new vector is to be created
	 * @return the normalised vector
	 **/
  def normalize(dest:Vector3f):Vector3f
    l = Vector(self).length()
    if (dest == nil)
      dest = Vector3f.new(@x / l, @y / l, @z / l)
    else
      dest.set(x / l, y / l, z / l)
    end
    return dest
  end
  
  /**
	 * The dot product of two vectors is calculated as
	 * v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
	 * @param left The LHS vector
	 * @param right The RHS vector
	 * @return left dot right
	 **/
  def self.dot(left:Vector3f, right:Vector3f):float
    return left.x * right.x + left.y * right.y + left.z * right.z
  end
  
  /**
	 * Calculate the angle between two vectors, in radians
	 * @param a A vector
	 * @param b The other vector
	 * @return the angle between the two vectors, in radians
	 **/
  def self.angle(a:Vector3f, b:Vector3f):float
    dls = float(dot(a, b) / (Vector(a).length() * Vector(b).length()))
    if (dls < -float(1.0))
      dls = -float(1.0)
    elsif (dls > float(1.0))
      dls = float(1.0)
    end
    return float(Math.acos(dls))
  end
  
  /* (non-Javadoc)
	 * @see org.lwjgl.vector.Vector#load(FloatBuffer)
	 **/
  def load(buf:FloatBuffer):Vector
    x = buf.get()
    y = buf.get()
    z = buf.get()
    return self
  end
  
  /* (non-Javadoc)
	 * @see org.lwjgl.vector.Vector#scale(float)
	 **/
  def scale(scale:float):Vector
    @x *= scale
    @y *= scale
    @z *= scale
    return self
  end
  
  /* (non-Javadoc)
	 * @see org.lwjgl.vector.Vector#store(FloatBuffer)
	 **/
  def store(buf:FloatBuffer):Vector
    buf.put(x)
    buf.put(y)
    buf.put(z)
    return self
  end
  
  /* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 **/
  def toString():String
    sb = StringBuilder(StringBuilder.new(64))
    sb.append("Vector3f[")
    sb.append(x)
    sb.append(", ")
    sb.append(y)
    sb.append(", ")
    sb.append(z)
    sb.append(']')
    return sb.toString()
  end
  
  def equals(obj:Object):boolean
    return true if (self == obj)
    return false if (obj == nil)
    return false if (getClass() != obj.getClass())
    other = Vector3f(obj)
    return true if (x == other.x && y == other.y && z == other.z)
    return false
  end
  
end
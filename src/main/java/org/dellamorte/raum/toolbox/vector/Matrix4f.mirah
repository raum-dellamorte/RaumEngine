
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
 * Holds a 4x4 float matrix.
 *
 * @author foo
 **/
class Matrix4f < Matrix
  #private static final serialVersionUID = long(1L)
  attr_accessor m00:float
  attr_accessor m01:float
  attr_accessor m02:float
  attr_accessor m03:float
  attr_accessor m10:float
  attr_accessor m11:float
  attr_accessor m12:float
  attr_accessor m13:float
  attr_accessor m20:float
  attr_accessor m21:float
  attr_accessor m22:float
  attr_accessor m23:float
  attr_accessor m30:float
  attr_accessor m31:float
  attr_accessor m32:float
  attr_accessor m33:float
  /**
	 * Construct a new matrix, initialized to the identity.
	 **/
  def initialize():void
    super()
    setIdentity()
  end
  
  def initialize(src:Matrix4f):void
    super()
    load(src)
  end
  
  /**
	 * Returns a string representation of this matrix
	 **/
  def toString():String
    buf = StringBuilder(StringBuilder.new())
    buf.append(m00).append(':').append(m10).append(':').append(m20).append(':').append(m30).append('\n')
    buf.append(m01).append(':').append(m11).append(':').append(m21).append(':').append(m31).append('\n')
    buf.append(m02).append(':').append(m12).append(':').append(m22).append(':').append(m32).append('\n')
    buf.append(m03).append(':').append(m13).append(':').append(m23).append(':').append(m33).append('\n')
    return buf.toString()
  end
  
  /**
	 * Set this matrix to be the identity matrix.
	 * @return this
	 **/
  def setIdentity():Matrix
    return setIdentity(self)
  end
  
  /**
	 * Set the given matrix to be the identity matrix.
	 * @param m The matrix to set to the identity
	 * @return m
	 **/
  def self.setIdentity(m:Matrix4f):Matrix4f
    m.m00 = float(1.0)
    m.m01 = float(0.0)
    m.m02 = float(0.0)
    m.m03 = float(0.0)
    m.m10 = float(0.0)
    m.m11 = float(1.0)
    m.m12 = float(0.0)
    m.m13 = float(0.0)
    m.m20 = float(0.0)
    m.m21 = float(0.0)
    m.m22 = float(1.0)
    m.m23 = float(0.0)
    m.m30 = float(0.0)
    m.m31 = float(0.0)
    m.m32 = float(0.0)
    m.m33 = float(1.0)
    return m
  end
  
  /**
	 * Set this matrix to 0.
	 * @return this
	 **/
  def setZero():Matrix
    return setZero(self)
  end
  
  /**
	 * Set the given matrix to 0.
	 * @param m The matrix to set to 0
	 * @return m
	 **/
  def self.setZero(m:Matrix4f):Matrix4f
    m.m00 = float(0.0)
    m.m01 = float(0.0)
    m.m02 = float(0.0)
    m.m03 = float(0.0)
    m.m10 = float(0.0)
    m.m11 = float(0.0)
    m.m12 = float(0.0)
    m.m13 = float(0.0)
    m.m20 = float(0.0)
    m.m21 = float(0.0)
    m.m22 = float(0.0)
    m.m23 = float(0.0)
    m.m30 = float(0.0)
    m.m31 = float(0.0)
    m.m32 = float(0.0)
    m.m33 = float(0.0)
    return m
  end
  
  /**
	 * Load from another matrix4f
	 * @param src The source matrix
	 * @return this
	 **/
  def load(src:Matrix4f):Matrix4f
    return load(src, self)
  end
  
  /**
	 * Copy the source matrix to the destination matrix
	 * @param src The source matrix
	 * @param dest The destination matrix, or null of a new one is to be created
	 * @return The copied matrix
	 **/
  def self.load(src:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    dest.m00 = src.m00
    dest.m01 = src.m01
    dest.m02 = src.m02
    dest.m03 = src.m03
    dest.m10 = src.m10
    dest.m11 = src.m11
    dest.m12 = src.m12
    dest.m13 = src.m13
    dest.m20 = src.m20
    dest.m21 = src.m21
    dest.m22 = src.m22
    dest.m23 = src.m23
    dest.m30 = src.m30
    dest.m31 = src.m31
    dest.m32 = src.m32
    dest.m33 = src.m33
    return dest
  end
  
  /**
	 * Load from a float buffer. The buffer stores the matrix in column major
	 * (OpenGL) order.
	 *
	 * @param buf A float buffer to read from
	 * @return this
	 **/
  def load(buf:FloatBuffer):Matrix
    m00 = buf.get()
    m01 = buf.get()
    m02 = buf.get()
    m03 = buf.get()
    m10 = buf.get()
    m11 = buf.get()
    m12 = buf.get()
    m13 = buf.get()
    m20 = buf.get()
    m21 = buf.get()
    m22 = buf.get()
    m23 = buf.get()
    m30 = buf.get()
    m31 = buf.get()
    m32 = buf.get()
    m33 = buf.get()
    return self
  end
  
  /**
	 * Load from a float buffer. The buffer stores the matrix in row major
	 * (maths) order.
	 *
	 * @param buf A float buffer to read from
	 * @return this
	 **/
  def loadTranspose(buf:FloatBuffer):Matrix
    m00 = buf.get()
    m10 = buf.get()
    m20 = buf.get()
    m30 = buf.get()
    m01 = buf.get()
    m11 = buf.get()
    m21 = buf.get()
    m31 = buf.get()
    m02 = buf.get()
    m12 = buf.get()
    m22 = buf.get()
    m32 = buf.get()
    m03 = buf.get()
    m13 = buf.get()
    m23 = buf.get()
    m33 = buf.get()
    return self
  end
  
  /**
	 * Store this matrix in a float buffer. The matrix is stored in column
	 * major (openGL) order.
	 * @param buf The buffer to store this matrix in
	 **/
  def store(buf:FloatBuffer):Matrix
    buf.put(m00)
    buf.put(m01)
    buf.put(m02)
    buf.put(m03)
    buf.put(m10)
    buf.put(m11)
    buf.put(m12)
    buf.put(m13)
    buf.put(m20)
    buf.put(m21)
    buf.put(m22)
    buf.put(m23)
    buf.put(m30)
    buf.put(m31)
    buf.put(m32)
    buf.put(m33)
    return self
  end
  
  /**
	 * Store this matrix in a float buffer. The matrix is stored in row
	 * major (maths) order.
	 * @param buf The buffer to store this matrix in
	 **/
  def storeTranspose(buf:FloatBuffer):Matrix
    buf.put(m00)
    buf.put(m10)
    buf.put(m20)
    buf.put(m30)
    buf.put(m01)
    buf.put(m11)
    buf.put(m21)
    buf.put(m31)
    buf.put(m02)
    buf.put(m12)
    buf.put(m22)
    buf.put(m32)
    buf.put(m03)
    buf.put(m13)
    buf.put(m23)
    buf.put(m33)
    return self
  end
  
  /**
	 * Store the rotation portion of this matrix in a float buffer. The matrix is stored in column
	 * major (openGL) order.
	 * @param buf The buffer to store this matrix in
	 **/
  def store3f(buf:FloatBuffer):Matrix
    buf.put(m00)
    buf.put(m01)
    buf.put(m02)
    buf.put(m10)
    buf.put(m11)
    buf.put(m12)
    buf.put(m20)
    buf.put(m21)
    buf.put(m22)
    return self
  end
  
  /**
	 * Add two matrices together and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.add(left:Matrix4f, right:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    dest.m00 = left.m00 + right.m00
    dest.m01 = left.m01 + right.m01
    dest.m02 = left.m02 + right.m02
    dest.m03 = left.m03 + right.m03
    dest.m10 = left.m10 + right.m10
    dest.m11 = left.m11 + right.m11
    dest.m12 = left.m12 + right.m12
    dest.m13 = left.m13 + right.m13
    dest.m20 = left.m20 + right.m20
    dest.m21 = left.m21 + right.m21
    dest.m22 = left.m22 + right.m22
    dest.m23 = left.m23 + right.m23
    dest.m30 = left.m30 + right.m30
    dest.m31 = left.m31 + right.m31
    dest.m32 = left.m32 + right.m32
    dest.m33 = left.m33 + right.m33
    return dest
  end
  
  /**
	 * Subtract the right matrix from the left and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.sub(left:Matrix4f, right:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    dest.m00 = left.m00 - right.m00
    dest.m01 = left.m01 - right.m01
    dest.m02 = left.m02 - right.m02
    dest.m03 = left.m03 - right.m03
    dest.m10 = left.m10 - right.m10
    dest.m11 = left.m11 - right.m11
    dest.m12 = left.m12 - right.m12
    dest.m13 = left.m13 - right.m13
    dest.m20 = left.m20 - right.m20
    dest.m21 = left.m21 - right.m21
    dest.m22 = left.m22 - right.m22
    dest.m23 = left.m23 - right.m23
    dest.m30 = left.m30 - right.m30
    dest.m31 = left.m31 - right.m31
    dest.m32 = left.m32 - right.m32
    dest.m33 = left.m33 - right.m33
    return dest
  end
  
  /**
	 * Multiply the right matrix by the left and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.mul(left:Matrix4f, right:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    m00 = float(left.m00 * right.m00 + left.m10 * right.m01 + left.m20 * right.m02 + left.m30 * right.m03)
    m01 = float(left.m01 * right.m00 + left.m11 * right.m01 + left.m21 * right.m02 + left.m31 * right.m03)
    m02 = float(left.m02 * right.m00 + left.m12 * right.m01 + left.m22 * right.m02 + left.m32 * right.m03)
    m03 = float(left.m03 * right.m00 + left.m13 * right.m01 + left.m23 * right.m02 + left.m33 * right.m03)
    m10 = float(left.m00 * right.m10 + left.m10 * right.m11 + left.m20 * right.m12 + left.m30 * right.m13)
    m11 = float(left.m01 * right.m10 + left.m11 * right.m11 + left.m21 * right.m12 + left.m31 * right.m13)
    m12 = float(left.m02 * right.m10 + left.m12 * right.m11 + left.m22 * right.m12 + left.m32 * right.m13)
    m13 = float(left.m03 * right.m10 + left.m13 * right.m11 + left.m23 * right.m12 + left.m33 * right.m13)
    m20 = float(left.m00 * right.m20 + left.m10 * right.m21 + left.m20 * right.m22 + left.m30 * right.m23)
    m21 = float(left.m01 * right.m20 + left.m11 * right.m21 + left.m21 * right.m22 + left.m31 * right.m23)
    m22 = float(left.m02 * right.m20 + left.m12 * right.m21 + left.m22 * right.m22 + left.m32 * right.m23)
    m23 = float(left.m03 * right.m20 + left.m13 * right.m21 + left.m23 * right.m22 + left.m33 * right.m23)
    m30 = float(left.m00 * right.m30 + left.m10 * right.m31 + left.m20 * right.m32 + left.m30 * right.m33)
    m31 = float(left.m01 * right.m30 + left.m11 * right.m31 + left.m21 * right.m32 + left.m31 * right.m33)
    m32 = float(left.m02 * right.m30 + left.m12 * right.m31 + left.m22 * right.m32 + left.m32 * right.m33)
    m33 = float(left.m03 * right.m30 + left.m13 * right.m31 + left.m23 * right.m32 + left.m33 * right.m33)
    dest.m00 = m00
    dest.m01 = m01
    dest.m02 = m02
    dest.m03 = m03
    dest.m10 = m10
    dest.m11 = m11
    dest.m12 = m12
    dest.m13 = m13
    dest.m20 = m20
    dest.m21 = m21
    dest.m22 = m22
    dest.m23 = m23
    dest.m30 = m30
    dest.m31 = m31
    dest.m32 = m32
    dest.m33 = m33
    return dest
  end
  
  /**
	 * Transform a Vector by a matrix and return the result in a destination
	 * vector.
	 * @param left The left matrix
	 * @param right The right vector
	 * @param dest The destination vector, or null if a new one is to be created
	 * @return the destination vector
	 **/
  def self.transform(left:Matrix4f, right:Vector4f, dest:Vector4f):Vector4f
    dest = Vector4f.new() if (dest == nil)
    x = float(left.m00 * right.x + left.m10 * right.y + left.m20 * right.z + left.m30 * right.w)
    y = float(left.m01 * right.x + left.m11 * right.y + left.m21 * right.z + left.m31 * right.w)
    z = float(left.m02 * right.x + left.m12 * right.y + left.m22 * right.z + left.m32 * right.w)
    w = float(left.m03 * right.x + left.m13 * right.y + left.m23 * right.z + left.m33 * right.w)
    dest.x = x
    dest.y = y
    dest.z = z
    dest.w = w
    return dest
  end
  
  /**
	 * Transpose this matrix
	 * @return this
	 **/
  def transpose():Matrix
    return transpose(self)
  end
  
  /**
	 * Translate this matrix
	 * @param vec The vector to translate by
	 * @return this
	 **/
  def translate(vec:Vector2f):Matrix4f
    return translate(vec, self)
  end
  
  /**
	 * Translate this matrix
	 * @param vec The vector to translate by
	 * @return this
	 **/
  def translate(vec:Vector3f):Matrix4f
    return translate(vec, self)
  end
  
  /**
	 * Scales this matrix
	 * @param vec The vector to scale by
	 * @return this
	 **/
  def scale(vec:Vector3f):Matrix4f
    return scale(vec, self, self)
  end
  
  /**
	 * Scales the source matrix and put the result in the destination matrix
	 * @param vec The vector to scale by
	 * @param src The source matrix
	 * @param dest The destination matrix, or null if a new matrix is to be created
	 * @return The scaled matrix
	 **/
  def self.scale(vec:Vector3f, src:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    dest.m00 = src.m00 * vec.x
    dest.m01 = src.m01 * vec.x
    dest.m02 = src.m02 * vec.x
    dest.m03 = src.m03 * vec.x
    dest.m10 = src.m10 * vec.y
    dest.m11 = src.m11 * vec.y
    dest.m12 = src.m12 * vec.y
    dest.m13 = src.m13 * vec.y
    dest.m20 = src.m20 * vec.z
    dest.m21 = src.m21 * vec.z
    dest.m22 = src.m22 * vec.z
    dest.m23 = src.m23 * vec.z
    return dest
  end
  
  /**
	 * Rotates the matrix around the given axis the specified angle
	 * @param angle the angle, in radians.
	 * @param axis The vector representing the rotation axis. Must be normalized.
	 * @return this
	 **/
  def rotate(angle:float, axis:Vector3f):Matrix4f
    return rotate(angle, axis, self)
  end
  
  /**
	 * Rotates the matrix around the given axis the specified angle
	 * @param angle the angle, in radians.
	 * @param axis The vector representing the rotation axis. Must be normalized.
	 * @param dest The matrix to put the result, or null if a new matrix is to be created
	 * @return The rotated matrix
	 **/
  def rotate(angle:float, axis:Vector3f, dest:Matrix4f):Matrix4f
    return rotate(angle, axis, self, dest)
  end
  
  /**
	 * Rotates the source matrix around the given axis the specified angle and
	 * put the result in the destination matrix.
	 * @param angle the angle, in radians.
	 * @param axis The vector representing the rotation axis. Must be normalized.
	 * @param src The matrix to rotate
	 * @param dest The matrix to put the result, or null if a new matrix is to be created
	 * @return The rotated matrix
	 **/
  def self.rotate(angle:float, axis:Vector3f, src:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    c = float(Math.cos(angle))
    s = float(Math.sin(angle))
    oneminusc = float(float(1.0) - c)
    xy = float(axis.x*axis.y)
    yz = float(axis.y*axis.z)
    xz = float(axis.x*axis.z)
    xs = float(axis.x*s)
    ys = float(axis.y*s)
    zs = float(axis.z*s)
    f00 = float(axis.x*axis.x*oneminusc+c)
    f01 = float(xy*oneminusc+zs)
    f02 = float(xz*oneminusc-ys)
    # n[3] not used
    f10 = float(xy*oneminusc-zs)
    f11 = float(axis.y*axis.y*oneminusc+c)
    f12 = float(yz*oneminusc+xs)
    # n[7] not used
    f20 = float(xz*oneminusc+ys)
    f21 = float(yz*oneminusc-xs)
    f22 = float(axis.z*axis.z*oneminusc+c)
    t00 = float(src.m00 * f00 + src.m10 * f01 + src.m20 * f02)
    t01 = float(src.m01 * f00 + src.m11 * f01 + src.m21 * f02)
    t02 = float(src.m02 * f00 + src.m12 * f01 + src.m22 * f02)
    t03 = float(src.m03 * f00 + src.m13 * f01 + src.m23 * f02)
    t10 = float(src.m00 * f10 + src.m10 * f11 + src.m20 * f12)
    t11 = float(src.m01 * f10 + src.m11 * f11 + src.m21 * f12)
    t12 = float(src.m02 * f10 + src.m12 * f11 + src.m22 * f12)
    t13 = float(src.m03 * f10 + src.m13 * f11 + src.m23 * f12)
    dest.m20 = src.m00 * f20 + src.m10 * f21 + src.m20 * f22
    dest.m21 = src.m01 * f20 + src.m11 * f21 + src.m21 * f22
    dest.m22 = src.m02 * f20 + src.m12 * f21 + src.m22 * f22
    dest.m23 = src.m03 * f20 + src.m13 * f21 + src.m23 * f22
    dest.m00 = t00
    dest.m01 = t01
    dest.m02 = t02
    dest.m03 = t03
    dest.m10 = t10
    dest.m11 = t11
    dest.m12 = t12
    dest.m13 = t13
    return dest
  end
  
  /**
	 * Translate this matrix and stash the result in another matrix
	 * @param vec The vector to translate by
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the translated matrix
	 **/
  def translate(vec:Vector3f, dest:Matrix4f):Matrix4f
    return translate(vec, self, dest)
  end
  
  /**
	 * Translate the source matrix and stash the result in the destination matrix
	 * @param vec The vector to translate by
	 * @param src The source matrix
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return The translated matrix
	 **/
  def self.translate(vec:Vector3f, src:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    dest.m30 += src.m00 * vec.x + src.m10 * vec.y + src.m20 * vec.z
    dest.m31 += src.m01 * vec.x + src.m11 * vec.y + src.m21 * vec.z
    dest.m32 += src.m02 * vec.x + src.m12 * vec.y + src.m22 * vec.z
    dest.m33 += src.m03 * vec.x + src.m13 * vec.y + src.m23 * vec.z
    return dest
  end
  
  /**
	 * Translate this matrix and stash the result in another matrix
	 * @param vec The vector to translate by
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the translated matrix
	 **/
  def translate(vec:Vector2f, dest:Matrix4f):Matrix4f
    return translate(vec, self, dest)
  end
  
  /**
	 * Translate the source matrix and stash the result in the destination matrix
	 * @param vec The vector to translate by
	 * @param src The source matrix
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return The translated matrix
	 **/
  def self.translate(vec:Vector2f, src:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    dest.m30 += src.m00 * vec.x + src.m10 * vec.y
    dest.m31 += src.m01 * vec.x + src.m11 * vec.y
    dest.m32 += src.m02 * vec.x + src.m12 * vec.y
    dest.m33 += src.m03 * vec.x + src.m13 * vec.y
    return dest
  end
  
  /**
	 * Transpose this matrix and place the result in another matrix
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the transposed matrix
	 **/
  def transpose(dest:Matrix4f):Matrix4f
    return transpose(self, dest)
  end
  
  /**
	 * Transpose the source matrix and place the result in the destination matrix
	 * @param src The source matrix
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the transposed matrix
	 **/
  def self.transpose(src:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    m00 = float(src.m00)
    m01 = float(src.m10)
    m02 = float(src.m20)
    m03 = float(src.m30)
    m10 = float(src.m01)
    m11 = float(src.m11)
    m12 = float(src.m21)
    m13 = float(src.m31)
    m20 = float(src.m02)
    m21 = float(src.m12)
    m22 = float(src.m22)
    m23 = float(src.m32)
    m30 = float(src.m03)
    m31 = float(src.m13)
    m32 = float(src.m23)
    m33 = float(src.m33)
    dest.m00 = m00
    dest.m01 = m01
    dest.m02 = m02
    dest.m03 = m03
    dest.m10 = m10
    dest.m11 = m11
    dest.m12 = m12
    dest.m13 = m13
    dest.m20 = m20
    dest.m21 = m21
    dest.m22 = m22
    dest.m23 = m23
    dest.m30 = m30
    dest.m31 = m31
    dest.m32 = m32
    dest.m33 = m33
    return dest
  end
  
  /**
	 * @return the determinant of the matrix
	 **/
  def determinant():float
    f = float(m00 * ((m11 * m22 * m33 + m12 * m23 * m31 + m13 * m21 * m32) - m13 * m22 * m31 - m11 * m23 * m32 - m12 * m21 * m33))
    f -= m01 * ((m10 * m22 * m33 + m12 * m23 * m30 + m13 * m20 * m32) - m13 * m22 * m30 - m10 * m23 * m32 - m12 * m20 * m33)
    f += m02 * ((m10 * m21 * m33 + m11 * m23 * m30 + m13 * m20 * m31) - m13 * m21 * m30 - m10 * m23 * m31 - m11 * m20 * m33)
    f -= m03 * ((m10 * m21 * m32 + m11 * m22 * m30 + m12 * m20 * m31) - m12 * m21 * m30 - m10 * m22 * m31 - m11 * m20 * m32)
    return f
  end
  
  /**
	 * Calculate the determinant of a 3x3 matrix
	 * @return result
	 **/
  def self.determinant3x3(t00:float, t01:float, t02:float, t10:float, t11:float, t12:float, t20:float, t21:float, t22:float):float
    return t00 * (t11 * t22 - t12 * t21) + t01 * (t12 * t20 - t10 * t22) + t02 * (t10 * t21 - t11 * t20)
  end
  
  /**
	 * Invert this matrix
	 * @return this if successful, null otherwise
	 **/
  def invert():Matrix
    return invert(self, self)
  end
  
  /**
	 * Invert the source matrix and put the result in the destination
	 * @param src The source matrix
	 * @param dest The destination matrix, or null if a new matrix is to be created
	 * @return The inverted matrix if successful, null otherwise
	 **/
  def self.invert(src:Matrix4f, dest:Matrix4f):Matrix4f
    determinant = float(src.determinant())
    if (determinant != 0)
      /*
			 * m00 m01 m02 m03
			 * m10 m11 m12 m13
			 * m20 m21 m22 m23
			 * m30 m31 m32 m33
			 **/
      dest = Matrix4f.new() if (dest == nil)
      determinant_inv = float(float(1)/determinant)
      # first row
      t00 = float(determinant3x3(src.m11, src.m12, src.m13, src.m21, src.m22, src.m23, src.m31, src.m32, src.m33))
      t01 = float(-determinant3x3(src.m10, src.m12, src.m13, src.m20, src.m22, src.m23, src.m30, src.m32, src.m33))
      t02 = float(determinant3x3(src.m10, src.m11, src.m13, src.m20, src.m21, src.m23, src.m30, src.m31, src.m33))
      t03 = float(-determinant3x3(src.m10, src.m11, src.m12, src.m20, src.m21, src.m22, src.m30, src.m31, src.m32))
      # second row
      t10 = float(-determinant3x3(src.m01, src.m02, src.m03, src.m21, src.m22, src.m23, src.m31, src.m32, src.m33))
      t11 = float(determinant3x3(src.m00, src.m02, src.m03, src.m20, src.m22, src.m23, src.m30, src.m32, src.m33))
      t12 = float(-determinant3x3(src.m00, src.m01, src.m03, src.m20, src.m21, src.m23, src.m30, src.m31, src.m33))
      t13 = float(determinant3x3(src.m00, src.m01, src.m02, src.m20, src.m21, src.m22, src.m30, src.m31, src.m32))
      # third row
      t20 = float(determinant3x3(src.m01, src.m02, src.m03, src.m11, src.m12, src.m13, src.m31, src.m32, src.m33))
      t21 = float(-determinant3x3(src.m00, src.m02, src.m03, src.m10, src.m12, src.m13, src.m30, src.m32, src.m33))
      t22 = float(determinant3x3(src.m00, src.m01, src.m03, src.m10, src.m11, src.m13, src.m30, src.m31, src.m33))
      t23 = float(-determinant3x3(src.m00, src.m01, src.m02, src.m10, src.m11, src.m12, src.m30, src.m31, src.m32))
      # fourth row
      t30 = float(-determinant3x3(src.m01, src.m02, src.m03, src.m11, src.m12, src.m13, src.m21, src.m22, src.m23))
      t31 = float(determinant3x3(src.m00, src.m02, src.m03, src.m10, src.m12, src.m13, src.m20, src.m22, src.m23))
      t32 = float(-determinant3x3(src.m00, src.m01, src.m03, src.m10, src.m11, src.m13, src.m20, src.m21, src.m23))
      t33 = float(determinant3x3(src.m00, src.m01, src.m02, src.m10, src.m11, src.m12, src.m20, src.m21, src.m22))
      # transpose and divide by the determinant
      dest.m00 = t00*determinant_inv
      dest.m11 = t11*determinant_inv
      dest.m22 = t22*determinant_inv
      dest.m33 = t33*determinant_inv
      dest.m01 = t10*determinant_inv
      dest.m10 = t01*determinant_inv
      dest.m20 = t02*determinant_inv
      dest.m02 = t20*determinant_inv
      dest.m12 = t21*determinant_inv
      dest.m21 = t12*determinant_inv
      dest.m03 = t30*determinant_inv
      dest.m30 = t03*determinant_inv
      dest.m13 = t31*determinant_inv
      dest.m31 = t13*determinant_inv
      dest.m32 = t23*determinant_inv
      dest.m23 = t32*determinant_inv
      return dest
    else
      return nil
    end
  end
  
  /**
	 * Negate this matrix
	 * @return this
	 **/
  def negate():Matrix
    return negate(self)
  end
  
  /**
	 * Negate this matrix and place the result in a destination matrix.
	 * @param dest The destination matrix, or null if a new matrix is to be created
	 * @return the negated matrix
	 **/
  def negate(dest:Matrix4f):Matrix4f
    return negate(self, dest)
  end
  
  /**
	 * Negate this matrix and place the result in a destination matrix.
	 * @param src The source matrix
	 * @param dest The destination matrix, or null if a new matrix is to be created
	 * @return The negated matrix
	 **/
  def self.negate(src:Matrix4f, dest:Matrix4f):Matrix4f
    dest = Matrix4f.new() if (dest == nil)
    dest.m00 = -src.m00
    dest.m01 = -src.m01
    dest.m02 = -src.m02
    dest.m03 = -src.m03
    dest.m10 = -src.m10
    dest.m11 = -src.m11
    dest.m12 = -src.m12
    dest.m13 = -src.m13
    dest.m20 = -src.m20
    dest.m21 = -src.m21
    dest.m22 = -src.m22
    dest.m23 = -src.m23
    dest.m30 = -src.m30
    dest.m31 = -src.m31
    dest.m32 = -src.m32
    dest.m33 = -src.m33
    return dest
  end
  
end
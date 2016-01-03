
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
 * Holds a 3x3 matrix.
 *
 * @author cix_foo <cix_foo@users.sourceforge.net>
 * @version $Revision$
 * $Id$
 **/
class Matrix3f < Matrix
  #private static final serialVersionUID = long(1L)
  attr_accessor m00:float
  attr_accessor m01:float
  attr_accessor m02:float
  attr_accessor m10:float
  attr_accessor m11:float
  attr_accessor m12:float
  attr_accessor m20:float
  attr_accessor m21:float
  attr_accessor m22:float
  /**
	 * Constructor for Matrix3f. Matrix is initialised to the identity.
	 **/
  def initialize():void
    super()
    setIdentity()
  end
  
  /**
	 * Load from another matrix
	 * @param src The source matrix
	 * @return this
	 **/
  def load(src:Matrix3f):Matrix3f
    return load(src, self)
  end
  
  /**
	 * Copy source matrix to destination matrix
	 * @param src The source matrix
	 * @param dest The destination matrix, or null of a new matrix is to be created
	 * @return The copied matrix
	 **/
  def self.load(src:Matrix3f, dest:Matrix3f):Matrix3f
    dest = Matrix3f.new() if (dest == nil)
    dest.m00 = src.m00
    dest.m10 = src.m10
    dest.m20 = src.m20
    dest.m01 = src.m01
    dest.m11 = src.m11
    dest.m21 = src.m21
    dest.m02 = src.m02
    dest.m12 = src.m12
    dest.m22 = src.m22
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
    m10 = buf.get()
    m11 = buf.get()
    m12 = buf.get()
    m20 = buf.get()
    m21 = buf.get()
    m22 = buf.get()
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
    m01 = buf.get()
    m11 = buf.get()
    m21 = buf.get()
    m02 = buf.get()
    m12 = buf.get()
    m22 = buf.get()
    return self
  end
  
  /**
	 * Store this matrix in a float buffer. The matrix is stored in column
	 * major (openGL) order.
	 * @param buf The buffer to store this matrix in
	 **/
  def store(buf:FloatBuffer):Matrix
    buf.put(@m00)
    buf.put(@m01)
    buf.put(@m02)
    buf.put(@m10)
    buf.put(@m11)
    buf.put(@m12)
    buf.put(@m20)
    buf.put(@m21)
    buf.put(@m22)
    return self
  end
  
  /**
	 * Store this matrix in a float buffer. The matrix is stored in row
	 * major (maths) order.
	 * @param buf The buffer to store this matrix in
	 **/
  def storeTranspose(buf:FloatBuffer):Matrix
    buf.put(@m00)
    buf.put(@m10)
    buf.put(@m20)
    buf.put(@m01)
    buf.put(@m11)
    buf.put(@m21)
    buf.put(@m02)
    buf.put(@m12)
    buf.put(@m22)
    return self
  end
  
  /**
	 * Add two matrices together and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.add(left:Matrix3f, right:Matrix3f, dest:Matrix3f):Matrix3f
    dest = Matrix3f.new() if (dest == nil)
    dest.m00 = left.m00 + right.m00
    dest.m01 = left.m01 + right.m01
    dest.m02 = left.m02 + right.m02
    dest.m10 = left.m10 + right.m10
    dest.m11 = left.m11 + right.m11
    dest.m12 = left.m12 + right.m12
    dest.m20 = left.m20 + right.m20
    dest.m21 = left.m21 + right.m21
    dest.m22 = left.m22 + right.m22
    return dest
  end
  
  /**
	 * Subtract the right matrix from the left and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.sub(left:Matrix3f, right:Matrix3f, dest:Matrix3f):Matrix3f
    dest = Matrix3f.new() if (dest == nil)
    dest.m00 = left.m00 - right.m00
    dest.m01 = left.m01 - right.m01
    dest.m02 = left.m02 - right.m02
    dest.m10 = left.m10 - right.m10
    dest.m11 = left.m11 - right.m11
    dest.m12 = left.m12 - right.m12
    dest.m20 = left.m20 - right.m20
    dest.m21 = left.m21 - right.m21
    dest.m22 = left.m22 - right.m22
    return dest
  end
  
  /**
	 * Multiply the right matrix by the left and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.mul(left:Matrix3f, right:Matrix3f, dest:Matrix3f):Matrix3f
    dest = Matrix3f.new() if (dest == nil)
    m00 = float(left.m00 * right.m00 + left.m10 * right.m01 + left.m20 * right.m02)
    m01 = float(left.m01 * right.m00 + left.m11 * right.m01 + left.m21 * right.m02)
    m02 = float(left.m02 * right.m00 + left.m12 * right.m01 + left.m22 * right.m02)
    m10 = float(left.m00 * right.m10 + left.m10 * right.m11 + left.m20 * right.m12)
    m11 = float(left.m01 * right.m10 + left.m11 * right.m11 + left.m21 * right.m12)
    m12 = float(left.m02 * right.m10 + left.m12 * right.m11 + left.m22 * right.m12)
    m20 = float(left.m00 * right.m20 + left.m10 * right.m21 + left.m20 * right.m22)
    m21 = float(left.m01 * right.m20 + left.m11 * right.m21 + left.m21 * right.m22)
    m22 = float(left.m02 * right.m20 + left.m12 * right.m21 + left.m22 * right.m22)
    dest.m00 = m00
    dest.m01 = m01
    dest.m02 = m02
    dest.m10 = m10
    dest.m11 = m11
    dest.m12 = m12
    dest.m20 = m20
    dest.m21 = m21
    dest.m22 = m22
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
  def self.transform(left:Matrix3f, right:Vector3f, dest:Vector3f):Vector3f
    dest = Vector3f.new() if (dest == nil)
    x = float(left.m00 * right.x + left.m10 * right.y + left.m20 * right.z)
    y = float(left.m01 * right.x + left.m11 * right.y + left.m21 * right.z)
    z = float(left.m02 * right.x + left.m12 * right.y + left.m22 * right.z)
    dest.x = x
    dest.y = y
    dest.z = z
    return dest
  end
  
  /**
	 * Transpose this matrix
	 * @return this
	 **/
  def transpose():Matrix
    return transpose(self, self)
  end
  
  /**
	 * Transpose this matrix and place the result in another matrix
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the transposed matrix
	 **/
  def transpose(dest:Matrix3f):Matrix3f
    return transpose(self, dest)
  end
  
  /**
	 * Transpose the source matrix and place the result into the destination matrix
	 * @param src The source matrix to be transposed
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the transposed matrix
	 **/
  def self.transpose(src:Matrix3f, dest:Matrix3f):Matrix3f
    dest = Matrix3f.new() if (dest == nil)
    m00 = float(src.m00)
    m01 = float(src.m10)
    m02 = float(src.m20)
    m10 = float(src.m01)
    m11 = float(src.m11)
    m12 = float(src.m21)
    m20 = float(src.m02)
    m21 = float(src.m12)
    m22 = float(src.m22)
    dest.m00 = m00
    dest.m01 = m01
    dest.m02 = m02
    dest.m10 = m10
    dest.m11 = m11
    dest.m12 = m12
    dest.m20 = m20
    dest.m21 = m21
    dest.m22 = m22
    return dest
  end
  
  /**
	 * @return the determinant of the matrix
	 **/
  def determinant():float
    f = float(@m00 * (@m11 * @m22 - @m12 * @m21) + @m01 * (@m12 * @m20 - @m10 * @m22) + @m02 * (@m10 * @m21 - @m11 * @m20))
    return f
  end
  
  /**
	 * Returns a string representation of this matrix
	 **/
  def toString():String
    buf = StringBuilder(StringBuilder.new())
    buf.append(@m00).append(':').append(@m10).append(':').append(@m20).append(':').append('\n')
    buf.append(@m01).append(':').append(@m11).append(':').append(@m21).append(':').append('\n')
    buf.append(@m02).append(':').append(@m12).append(':').append(@m22).append(':').append('\n')
    return buf.toString()
  end
  
  /**
	 * Invert this matrix
	 * @return this if successful, null otherwise
	 **/
  def invert():Matrix
    return invert(self, self)
  end
  
  /**
	 * Invert the source matrix and put the result into the destination matrix
	 * @param src The source matrix to be inverted
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return The inverted matrix if successful, null otherwise
	 **/
  def self.invert(src:Matrix3f, dest:Matrix3f):Matrix3f
    determinant = float(src.determinant())
    if (determinant != 0)
      dest = Matrix3f.new() if (dest == nil)
      /* do it the ordinary way
			  *
			  * inv(A) = 1/det(A) * adj(T), where adj(T) = transpose(Conjugate Matrix)
			  *
			  * m00 m01 m02
			  * m10 m11 m12
			  * m20 m21 m22
			  **/
      determinant_inv = float(float(1)/determinant)
      # get the conjugate matrix
      t00 = float(src.m11 * src.m22 - src.m12 * src.m21)
      t01 = float(- src.m10 * src.m22 + src.m12 * src.m20)
      t02 = float(src.m10 * src.m21 - src.m11 * src.m20)
      t10 = float(- src.m01 * src.m22 + src.m02 * src.m21)
      t11 = float(src.m00 * src.m22 - src.m02 * src.m20)
      t12 = float(- src.m00 * src.m21 + src.m01 * src.m20)
      t20 = float(src.m01 * src.m12 - src.m02 * src.m11)
      t21 = float(-src.m00 * src.m12 + src.m02 * src.m10)
      t22 = float(src.m00 * src.m11 - src.m01 * src.m10)
      dest.m00 = t00*determinant_inv
      dest.m11 = t11*determinant_inv
      dest.m22 = t22*determinant_inv
      dest.m01 = t10*determinant_inv
      dest.m10 = t01*determinant_inv
      dest.m20 = t02*determinant_inv
      dest.m02 = t20*determinant_inv
      dest.m12 = t21*determinant_inv
      dest.m21 = t12*determinant_inv
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
  def negate(dest:Matrix3f):Matrix3f
    return negate(self, dest)
  end
  
  /**
	 * Negate the source matrix and place the result in the destination matrix.
	 * @param src The source matrix
	 * @param dest The destination matrix, or null if a new matrix is to be created
	 * @return the negated matrix
	 **/
  def self.negate(src:Matrix3f, dest:Matrix3f):Matrix3f
    dest = Matrix3f.new() if (dest == nil)
    dest.m00 = -src.m00
    dest.m01 = -src.m02
    dest.m02 = -src.m01
    dest.m10 = -src.m10
    dest.m11 = -src.m12
    dest.m12 = -src.m11
    dest.m20 = -src.m20
    dest.m21 = -src.m22
    dest.m22 = -src.m21
    return dest
  end
  
  /**
	 * Set this matrix to be the identity matrix.
	 * @return this
	 **/
  def setIdentity():Matrix
    return setIdentity(self)
  end
  
  /**
	 * Set the matrix to be the identity matrix.
	 * @param m The matrix to be set to the identity
	 * @return m
	 **/
  def self.setIdentity(m:Matrix3f):Matrix3f
    m.m00 = float(1.0)
    m.m01 = float(0.0)
    m.m02 = float(0.0)
    m.m10 = float(0.0)
    m.m11 = float(1.0)
    m.m12 = float(0.0)
    m.m20 = float(0.0)
    m.m21 = float(0.0)
    m.m22 = float(1.0)
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
	 * Set the matrix matrix to 0.
	 * @param m The matrix to be set to 0
	 * @return m
	 **/
  def self.setZero(m:Matrix3f):Matrix3f
    m.m00 = float(0.0)
    m.m01 = float(0.0)
    m.m02 = float(0.0)
    m.m10 = float(0.0)
    m.m11 = float(0.0)
    m.m12 = float(0.0)
    m.m20 = float(0.0)
    m.m21 = float(0.0)
    m.m22 = float(0.0)
    return m
  end
  
end
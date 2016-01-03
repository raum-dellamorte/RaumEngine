
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
 * Holds a 2x2 matrix
 *
 * @author cix_foo <cix_foo@users.sourceforge.net>
 * @version $Revision$
 * $Id$
 **/
class Matrix2f < Matrix
  #private static final serialVersionUID = long(1L)
  attr_accessor m00:float
  attr_accessor m01:float
  attr_accessor m10:float
  attr_accessor m11:float
  /**
	 * Constructor for Matrix2f. The matrix is initialised to the identity.
	 **/
  def initialize():void
    setIdentity()
  end
  
  /**
	 * Constructor
	 **/
  def initialize(src:Matrix2f):void
    load(src)
  end
  
  /**
	 * Load from another matrix
	 * @param src The source matrix
	 * @return this
	 **/
  def load(src:Matrix2f):Matrix2f
    return load(src, self)
  end
  
  /**
	 * Copy the source matrix to the destination matrix.
	 * @param src The source matrix
	 * @param dest The destination matrix, or null if a new one should be created.
	 * @return The copied matrix
	 **/
  def self.load(src:Matrix2f, dest:Matrix2f):Matrix2f
    dest = Matrix2f.new() if (dest == nil)
    dest.m00 = src.m00
    dest.m01 = src.m01
    dest.m10 = src.m10
    dest.m11 = src.m11
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
    m10 = buf.get()
    m11 = buf.get()
    return self
  end
  
  /**
	 * Load from a float buffer. The buffer stores the matrix in row major
	 * (mathematical) order.
	 *
	 * @param buf A float buffer to read from
	 * @return this
	 **/
  def loadTranspose(buf:FloatBuffer):Matrix
    m00 = buf.get()
    m10 = buf.get()
    m01 = buf.get()
    m11 = buf.get()
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
    buf.put(m10)
    buf.put(m11)
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
    buf.put(m01)
    buf.put(m11)
    return self
  end
  
  /**
	 * Add two matrices together and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.add(left:Matrix2f, right:Matrix2f, dest:Matrix2f):Matrix2f
    dest = Matrix2f.new() if (dest == nil)
    dest.m00 = left.m00 + right.m00
    dest.m01 = left.m01 + right.m01
    dest.m10 = left.m10 + right.m10
    dest.m11 = left.m11 + right.m11
    return dest
  end
  
  /**
	 * Subtract the right matrix from the left and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.sub(left:Matrix2f, right:Matrix2f, dest:Matrix2f):Matrix2f
    dest = Matrix2f.new() if (dest == nil)
    dest.m00 = left.m00 - right.m00
    dest.m01 = left.m01 - right.m01
    dest.m10 = left.m10 - right.m10
    dest.m11 = left.m11 - right.m11
    return dest
  end
  
  /**
	 * Multiply the right matrix by the left and place the result in a third matrix.
	 * @param left The left source matrix
	 * @param right The right source matrix
	 * @param dest The destination matrix, or null if a new one is to be created
	 * @return the destination matrix
	 **/
  def self.mul(left:Matrix2f, right:Matrix2f, dest:Matrix2f):Matrix2f
    dest = Matrix2f.new() if (dest == nil)
    m00 = float(left.m00 * right.m00 + left.m10 * right.m01)
    m01 = float(left.m01 * right.m00 + left.m11 * right.m01)
    m10 = float(left.m00 * right.m10 + left.m10 * right.m11)
    m11 = float(left.m01 * right.m10 + left.m11 * right.m11)
    dest.m00 = m00
    dest.m01 = m01
    dest.m10 = m10
    dest.m11 = m11
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
  def self.transform(left:Matrix2f, right:Vector2f, dest:Vector2f):Vector2f
    dest = Vector2f.new() if (dest == nil)
    x = float(left.m00 * right.x + left.m10 * right.y)
    y = float(left.m01 * right.x + left.m11 * right.y)
    dest.x = x
    dest.y = y
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
	 * Transpose this matrix and place the result in another matrix.
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the transposed matrix
	 **/
  def transpose(dest:Matrix2f):Matrix2f
    return transpose(self, dest)
  end
  
  /**
	 * Transpose the source matrix and place the result in the destination matrix.
	 * @param src The source matrix or null if a new matrix is to be created
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return the transposed matrix
	 **/
  def self.transpose(src:Matrix2f, dest:Matrix2f):Matrix2f
    dest = Matrix2f.new() if (dest == nil)
    m01 = float(src.m10)
    m10 = float(src.m01)
    dest.m01 = m01
    dest.m10 = m10
    return dest
  end
  
  /**
	 * Invert this matrix
	 * @return this if successful, null otherwise
	 **/
  def invert():Matrix
    return invert(self, self)
  end
  
  /**
	 * Invert the source matrix and place the result in the destination matrix.
	 * @param src The source matrix to be inverted
	 * @param dest The destination matrix or null if a new matrix is to be created
	 * @return The inverted matrix, or null if source can't be reverted.
	 **/
  def self.invert(src:Matrix2f, dest:Matrix2f):Matrix2f
    /*
		 *inv(A) = 1/det(A) * adj(A);
		 **/
    determinant = float(src.determinant())
    if (determinant != 0)
      dest = Matrix2f.new() if (dest == nil)
      determinant_inv = float(float(1)/determinant)
      t00 = float(src.m11*determinant_inv)
      t01 = float(-src.m01*determinant_inv)
      t11 = float(src.m00*determinant_inv)
      t10 = float(-src.m10*determinant_inv)
      dest.m00 = t00
      dest.m01 = t01
      dest.m10 = t10
      dest.m11 = t11
      return dest
    else
      return nil
    end
  end
  
  /**
	 * Returns a string representation of this matrix
	 **/
  def toString():String
    buf = StringBuilder(StringBuilder.new())
    buf.append(m00).append(':').append(m10).append(':').append('\n')
    buf.append(m01).append(':').append(m11).append(':').append('\n')
    return buf.toString()
  end
  
  /**
	 * Negate this matrix
	 * @return this
	 **/
  def negate():Matrix
    return negate(self)
  end
  
  /**
	 * Negate this matrix and stash the result in another matrix.
	 * @param dest The destination matrix, or null if a new matrix is to be created
	 * @return the negated matrix
	 **/
  def negate(dest:Matrix2f):Matrix2f
    return negate(self, dest)
  end
  
  /**
	 * Negate the source matrix and stash the result in the destination matrix.
	 * @param src The source matrix to be negated
	 * @param dest The destination matrix, or null if a new matrix is to be created
	 * @return the negated matrix
	 **/
  def self.negate(src:Matrix2f, dest:Matrix2f):Matrix2f
    dest = Matrix2f.new() if (dest == nil)
    dest.m00 = -src.m00
    dest.m01 = -src.m01
    dest.m10 = -src.m10
    dest.m11 = -src.m11
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
	 * Set the source matrix to be the identity matrix.
	 * @param src The matrix to set to the identity.
	 * @return The source matrix
	 **/
  def self.setIdentity(src:Matrix2f):Matrix2f
    src.m00 = float(1.0)
    src.m01 = float(0.0)
    src.m10 = float(0.0)
    src.m11 = float(1.0)
    return src
  end
  
  /**
	 * Set this matrix to 0.
	 * @return this
	 **/
  def setZero():Matrix
    return setZero(self)
  end
  
  def self.setZero(src:Matrix2f):Matrix2f
    src.m00 = float(0.0)
    src.m01 = float(0.0)
    src.m10 = float(0.0)
    src.m11 = float(0.0)
    return src
  end
  
  /* (non-Javadoc)
	 * @see org.lwjgl.vector.Matrix#determinant()
	 **/
  def determinant():float
    return m00 * m11 - m01*m10
  end
  
end
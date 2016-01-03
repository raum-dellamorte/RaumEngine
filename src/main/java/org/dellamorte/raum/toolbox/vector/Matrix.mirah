/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.toolbox.vector

import java.nio.FloatBuffer

/**
 *
 * @author Raum
 */
abstract class Matrix
  /**
	 * Set this matrix to be the identity matrix.
	 * @return this
	 */
	abstract def setIdentity():Matrix; end
	/**
	 * Invert this matrix
	 * @return this
	 */
	abstract def invert():Matrix; end
	/**
	 * Load from a float buffer. The buffer stores the matrix in column major
	 * (OpenGL) order.
	 *
	 * @param buf A float buffer to read from
	 * @return this
	 */
	abstract def load(buf:FloatBuffer):Matrix; end
	/**
	 * Load from a float buffer. The buffer stores the matrix in row major
	 * (mathematical) order.
	 *
	 * @param buf A float buffer to read from
	 * @return this
	 */
	abstract def loadTranspose(buf:FloatBuffer):Matrix; end
	/**
	 * Negate this matrix
	 * @return this
	 */
	abstract def negate():Matrix; end
	/**
	 * Store this matrix in a float buffer. The matrix is stored in column
	 * major (openGL) order.
	 * @param buf The buffer to store this matrix in
	 * @return this
	 */
	abstract def store(buf:FloatBuffer):Matrix; end
	/**
	 * Store this matrix in a float buffer. The matrix is stored in row
	 * major (maths) order.
	 * @param buf The buffer to store this matrix in
	 * @return this
	 */
	abstract def storeTranspose(buf:FloatBuffer):Matrix; end
	/**
	 * Transpose this matrix
	 * @return this
	 */
	abstract def transpose():Matrix; end
	/**
	 * Set this matrix to 0.
	 * @return this
	 */
	abstract def setZero():Matrix; end
	/**
	 * @return the determinant of the matrix
	 */
	abstract def determinant():float; end
end


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
abstract class Vector
  /**
   * @return the length of the vector
   */
  def length():float
    return float(Math.sqrt(lengthSquared()))
  end
  /**
   * @return the length squared of the vector
   */
  abstract def lengthSquared():float; end
  /**
   * Load this vector from a FloatBuffer
   * @param buf The buffer to load it from, at the current position
   * @return this
   */
  abstract def load(buf:FloatBuffer):Vector; end

  /**
   * Negate a vector
   * @return this
   */
  abstract def negate():Vector; end


  /**
   * Normalise this vector
   * @return this
   */
  def normalize():Vector
    len = length()
    if (len != float(0.0))
      l = float(float(1.0) / len)
      return Vector(scale(l))
    else
      #throw IllegalStateException.new("Zero length vector")
      puts "Zero length vector"
      return Vector(nil)
    end
  end
  /**
   * Store this vector in a FloatBuffer
   * @param buf The buffer to store it in, at the current position
   * @return this
   */
  abstract def store(buf:FloatBuffer):Vector; end
  /**
   * Scale this vector
   * @param scale The scale factor
   * @return this
   */
  abstract def scale(scale:float):Vector; end
end
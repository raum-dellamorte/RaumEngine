/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.dellamorte.raum.fbuffers

import java.nio.ByteBuffer
import org.dellamorte.raum.engine.DisplayMgr
import org.lwjgl.opengl.GL11
import org.lwjgl.opengl.GL14
import org.lwjgl.opengl.GL30

/**
 *
 * @author Raum
 */
class FrameBuffer 
	def self.REFLECTION_WIDTH():int; 320; end
  def self.REFLECTION_HEIGHT():int; 180; end
  def self.REFRACTION_WIDTH():int; 1280; end
  def self.REFRACTION_HEIGHT():int; 720; end
  
  def initialize():void
    @reflectionFrameBuffer = int(0)
    @reflectionTexture = int(0)
    @reflectionDepthBuffer = int(0)
    @refractionFrameBuffer = int(0)
    @refractionTexture = int(0)
    @refractionDepthTexture = int(0)
    # call when loading the game
    initialiseReflectionFrameBuffer()
    initialiseRefractionFrameBuffer()
  end

  def cleanUp():void
    # call when closing the game
    GL30.glDeleteFramebuffers(@reflectionFrameBuffer)
    GL11.glDeleteTextures(@reflectionTexture)
    GL30.glDeleteRenderbuffers(@reflectionDepthBuffer)
    GL30.glDeleteFramebuffers(@refractionFrameBuffer)
    GL11.glDeleteTextures(@refractionTexture)
    GL11.glDeleteTextures(@refractionDepthTexture)
  end

  def bindReflectionFrameBuffer():void
    # call before rendering to this FBO
    bindFrameBuffer(@reflectionFrameBuffer,REFLECTION_WIDTH(),REFLECTION_HEIGHT())
  end

  def bindRefractionFrameBuffer():void
    # call before rendering to this FBO
    bindFrameBuffer(@refractionFrameBuffer,REFRACTION_WIDTH(),REFRACTION_HEIGHT())
  end

  def unbindCurrentFrameBuffer():void
    # call to switch to default frame buffer
    GL30.glBindFramebuffer(GL30.GL_FRAMEBUFFER, 0)
    GL11.glViewport(0, 0, int(DisplayMgr.getWidth()), int(DisplayMgr.getHeight()))
  end

  def getReflectionTexture():int
    # get the resulting texture
    return @reflectionTexture
  end

  def getRefractionTexture():int
    # get the resulting texture
    return @refractionTexture
  end

  def getRefractionDepthTexture():int
    # get the resulting depth texture
    return @refractionDepthTexture
  end

  def initialiseReflectionFrameBuffer():void
    @reflectionFrameBuffer = createFrameBuffer()
    @reflectionTexture = createTextureAttachment(REFLECTION_WIDTH(),REFLECTION_HEIGHT())
    @reflectionDepthBuffer = createDepthBufferAttachment(REFLECTION_WIDTH(),REFLECTION_HEIGHT())
    unbindCurrentFrameBuffer()
  end

  def initialiseRefractionFrameBuffer():void
    @refractionFrameBuffer = createFrameBuffer()
    @refractionTexture = createTextureAttachment(REFRACTION_WIDTH(),REFRACTION_HEIGHT())
    @refractionDepthTexture = createDepthTextureAttachment(REFRACTION_WIDTH(),REFRACTION_HEIGHT())
    unbindCurrentFrameBuffer()
  end

  def bindFrameBuffer(frameBuffer:int, width:int, height:int):void
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, 0) # To make sure the texture isn't bound
    GL30.glBindFramebuffer(GL30.GL_FRAMEBUFFER, frameBuffer)
    GL11.glViewport(0, 0, width, height)
  end

  def createFrameBuffer():int
    frameBuffer = int(GL30.glGenFramebuffers()) # generate name for frame buffer
    GL30.glBindFramebuffer(GL30.GL_FRAMEBUFFER, frameBuffer) # create the framebuffer
    GL11.glDrawBuffer(GL30.GL_COLOR_ATTACHMENT0) # indicate that we will always render to color attachment 0
    return frameBuffer
  end

  def createTextureAttachment(width:int, height:int):int
    texture = int(GL11.glGenTextures())
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, texture)
    GL11.glTexImage2D(GL11.GL_TEXTURE_2D, 0, GL11.GL_RGB, width, height, 0, GL11.GL_RGB, GL11.GL_UNSIGNED_BYTE, ByteBuffer(nil))
    GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_MAG_FILTER, GL11.GL_LINEAR)
    GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_MIN_FILTER, GL11.GL_LINEAR)
    GL30.glFramebufferTexture2D(GL30.GL_FRAMEBUFFER, GL30.GL_COLOR_ATTACHMENT0, GL11.GL_TEXTURE_2D, texture, 0)
    return texture
  end

  def createDepthTextureAttachment(width:int, height:int):int
    texture = int(GL11.glGenTextures())
    GL11.glBindTexture(GL11.GL_TEXTURE_2D, texture)
    GL11.glTexImage2D(GL11.GL_TEXTURE_2D, 0, GL14.GL_DEPTH_COMPONENT32, width, height, 0, GL11.GL_DEPTH_COMPONENT, GL11.GL_FLOAT, ByteBuffer(nil))
    GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_MAG_FILTER, GL11.GL_LINEAR)
    GL11.glTexParameteri(GL11.GL_TEXTURE_2D, GL11.GL_TEXTURE_MIN_FILTER, GL11.GL_LINEAR)
    GL30.glFramebufferTexture2D(GL30.GL_FRAMEBUFFER, GL30.GL_DEPTH_ATTACHMENT, GL11.GL_TEXTURE_2D, texture, 0)
    return texture
  end

  def createDepthBufferAttachment(width:int, height:int):int
    depthBuffer = int(GL30.glGenRenderbuffers())
    GL30.glBindRenderbuffer(GL30.GL_RENDERBUFFER, depthBuffer)
    GL30.glRenderbufferStorage(GL30.GL_RENDERBUFFER, GL11.GL_DEPTH_COMPONENT, width, height)
    GL30.glFramebufferRenderbuffer(GL30.GL_FRAMEBUFFER, GL30.GL_DEPTH_ATTACHMENT, GL30.GL_RENDERBUFFER, depthBuffer)
    return depthBuffer
  end
end


package org.dellamorte.raum.engine

import org.lwjgl.*
import org.lwjgl.glfw.*
import org.lwjgl.opengl.*
 
import static org.lwjgl.glfw.GLFW.*
import static org.lwjgl.opengl.GL11.*
import java.nio.IntBuffer
import org.dellamorte.raum.input.Keyboard
import org.dellamorte.raum.input.Mouse
import org.dellamorte.raum.input.MousePos
import org.dellamorte.raum.input.MouseScroll
import static org.lwjgl.system.MemoryUtil
/**
 *
 * @author Raum
 */
class DisplayMgr
  def self.WIDTH():int; 800; end
  def self.HEIGHT():int; 600; end
	def self.FPS_CAP():int; 120; end
  def self.NULL():long; org::lwjgl::system::MemoryUtil.NULL; end
  
  def self.init():boolean
		@@delta = float(0.0)
    glfwSetErrorCallback(@@errorCallback = GLFWErrorCallback.createPrint(System.err))
    (puts "Unable to initialize GLFW"; return false) if ( glfwInit() != GLFW.GLFW_TRUE() )
    # throw IllegalStateException.new("Unable to initialize GLFW") 
    
    glfwDefaultWindowHints()
    glfwWindowHint(GLFW.GLFW_VISIBLE, GLFW.GLFW_FALSE)
    glfwWindowHint(GLFW.GLFW_RESIZABLE, GLFW.GLFW_TRUE)
    glfwWindowHint(GLFW.GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW.GLFW_CONTEXT_VERSION_MINOR, 0);
    
    @@window = glfwCreateWindow(WIDTH(), HEIGHT(), "Hello World!", NULL(), NULL())
    (puts "Failed to create the GLFW window"; return false) if (@@window == NULL())
    # throw RuntimeException.new("Failed to create the GLFW window")
    @@w = WIDTH()
    @@h = HEIGHT()

    @@keyboard = Keyboard.new()
    @@mouse = Mouse.new()
    @@mPos = MousePos.new()
    @@mScroll = MouseScroll.new()
    
    glfwSetKeyCallback(@@window, @@keyboard)
    glfwSetMouseButtonCallback(@@window, @@mouse)
    glfwSetCursorPosCallback(@@window, @@mPos)
    glfwSetScrollCallback(@@window, @@mScroll)
    
    vidmode = GLFWVidMode(glfwGetVideoMode(glfwGetPrimaryMonitor()))
    glfwSetWindowPos(@@window, (vidmode.width() - WIDTH()) / 2, (vidmode.height() - HEIGHT()) / 2)
    
    glfwMakeContextCurrent(@@window)
    glfwSwapInterval(1)
    glfwShowWindow(@@window)
    GL.createCapabilities()
    @@lastFrameTime = long(getCurrentTime())
    return true
  end
  
  def self.setBGColor(r:Double, g:Double, b:Double, a:Double):void
    glClearColor(r.floatValue(), g.floatValue(), b.floatValue(), a.floatValue())
  end
  
  def self.prep():void
    glClear(GL11.GL_COLOR_BUFFER_BIT | GL11.GL_DEPTH_BUFFER_BIT)
    glfwPollEvents()
  end
  
  def self.updateDisplay():void
    glfwSwapBuffers(@@window)
    glfwSetWindowShouldClose(@@window, GLFW.GLFW_TRUE) if @@keyboard.isKeyDown(GLFW.GLFW_KEY_ESCAPE)
		timeNow = getCurrentTime()
		@@delta = float(float(timeNow - @@lastFrameTime) / float(1000.0))
		@@lastFrameTime = timeNow
  end
  
  def self.isCloseRequested():boolean
    return (glfwWindowShouldClose(@@window) == GLFW.GLFW_TRUE)
  end
  
  def self.close():void
    glfwDestroyWindow(@@window)
    @@keyboard.release()
    glfwTerminate()
    @@errorCallback.release()
  end
	
	def self.getFrameTimeSeconds():float
		@@delta
	end
	
	def self.getCurrentTime():long
		begin
      return long(glfwGetTime() * long(1000))
    rescue
      puts "Failed to getCurrentTime"
      return long(0)
    end
	end

  def self.updateWH():void
    tmpW = IntBuffer(BufferUtils.createIntBuffer(1))
    tmpH = IntBuffer(BufferUtils.createIntBuffer(1))
    glfwGetWindowSize(@@window, tmpW, tmpH)
    @@w = tmpW.get(0)
    @@h = tmpH.get(0)
  end
  
  def self.getWidth():float
    float(@@w)
  end
  
  def self.getHeight():float
    float(@@h)
  end
  
  def self.mainWindow():long
    @@window
  end
  
  def self.kb():Keyboard
    @@keyboard
  end
  
  def self.mouse():Mouse
    @@mouse
  end
  
  def self.mousePos():MousePos
    @@mPos
  end
  
  def self.mouseScroll():MouseScroll
    @@mScroll
  end
  
end


package org.dellamorte.raum.toolbox.fontMeshCreator

/**
 *
 * @author Raum
 */
class FontTypeToGUITextListMap
	def initialize():void
		clear()
  end
  
  def clear():void
    @keys = FontType[0]
		@vals = GUITextList[0]
  end
	
	def getKeyLoc(key:FontType):int
		out = -1
		@keys.length().times do |i:int|
			next unless (key.equals(@keys[i]))
			out = i
			break
		end
		return out
	end

	def get(key:FontType):GUITextList
		i = getKeyLoc(key)
		return @vals[i] if ((i > -1) and (i < @vals.length()))
		return GUITextList(nil)
	end

	def add(key:FontType, val:GUITextList):void
		return unless (getKeyLoc(key) < 0)
		l = @keys.length()
		nl = l + 1
		tmpk = FontType[nl]
		tmpv = GUITextList[nl]
		@keys.length().times do |v:int|
			tmpk[v] = @keys[v]
			tmpv[v] = @vals[v]
		end
		tmpk[l] = key
		tmpv[l] = val
		@keys = tmpk
		@vals = tmpv
		return
	end

	def remove(key:FontType):void
		r = getKeyLoc(key)
		return if (r < 0)
    l = @keys.length()
		nl = l - 1
		tmpk = FontType[nl]
		tmpv = GUITextList[nl]
		j = 0
    l.times do |v:int|
      next if v == r
      tmpk[j] = @keys[v]
			tmpv[j] = @vals[v]
      j += 1
		end
		@keys = tmpk
		@vals = tmpv
		return
	end

	def put(key:FontType, val:GUITextList):void
		out = getKeyLoc(key)
		if (out < 0)
			add(key, val)
		else
			@vals[out] = val
		end
	end
	
	def size():int
		@keys.length()
	end
	
	def keySet():FontType[]
		@keys
  end
  
  
end


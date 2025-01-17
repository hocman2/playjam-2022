local function state(widget)
	
	function widget:setStateInitial(states, state)
		self.kStates = states
		self.state = state
	end
	
	function widget:setState(targetState)
		if self.state == targetState then
			return
		end
		
		if self._changeState ~= nil then
			self:_changeState(self.state, targetState)
		end
		
		self.state = targetState
	end
end

Widget.register("state", state)
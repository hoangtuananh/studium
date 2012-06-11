class String
	def highlight(question_id)
		if question_id
			result=self
			while result=~/(.*)<hl #{question_id}>(.*?)<\/hl #{question_id}>(.*)/m
				result=$1+"<b>"+$2+"</b>"+$3
			end

			result
		end
	end

end

s="<hl 89>asdsadsadsadsa<hl 90>Dsadsad</hl 90>dsadsa</hl 89>"
puts (s.highlight(89).highlight(90))

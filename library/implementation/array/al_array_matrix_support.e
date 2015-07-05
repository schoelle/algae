note
	description: "Support functions for AL_ARRAY_MATRIX"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_ARRAY_MATRIX_SUPPORT

feature -- Contract support

	is_valid_array_matrix (a_array: ARRAY [ARRAY [DOUBLE]]): BOOLEAN
			-- Can `a_array' be used for AL_ARRAY_MATRIX?
			-- Requirments: all lines same length and all `lower' = 1
		local
			l_row: INTEGER
			l_width: INTEGER
			l_line: ARRAY [DOUBLE]
		do
			Result := True
			Result := a_array.lower = 1
			if a_array.count >= 1 then
				Result := a_array.item (1).lower = 1
				l_width := a_array.item (1).count
				from
					l_row := 2
				until
					not Result or l_row > a_array.count
				loop
					l_line := a_array.item (l_row)
					Result := l_line.count = l_width and l_line.lower = 1
					l_row := l_row + 1
				end
			end
		end

end

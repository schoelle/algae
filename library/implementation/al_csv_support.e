note
	description: "Transform a AL_MATRIX to CSV format"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_CSV_SUPPORT

feature {AL_INTERNAL} -- Implementation

	matrix_as_csv (a_matrix: AL_MATRIX): STRING
			-- `a_matrix' in its CSV representation
		local
			l_col, l_row: INTEGER
		do
			Result := ""
			from
				l_col := 1
			until
				l_col > a_matrix.width
			loop
				Result.append (",")
				if attached a_matrix.column_labels.item (l_col) as l_label then
					Result.append (escape_csv (l_label))
				end
				l_col := l_col + 1
			end
			from
				l_row := 1
			until
				l_row > a_matrix.height
			loop
				Result.append ("%N")
				if attached a_matrix.row_labels.item (l_row) as l_label then
					Result.append (escape_csv (l_label))
				end
				from
					l_col := 1
				until
					l_col > a_matrix.width
				loop
					Result.append (",")
					Result.append (a_matrix.item (l_row, l_col).out)
					l_col := l_col + 1
				end
				l_row := l_row + 1
			end
		end

	escape_csv (a_string: STRING): STRING
			-- Escaped version of `a_string' (if necessary)
		local
			l_copy: STRING
		do
			if a_string.has ('"') then
				l_copy := a_string.twin
				l_copy.replace_substring_all ("%"", "%"%"")
				Result := "%"" + l_copy + "%""
			else
				Result := a_string
			end
		end

end

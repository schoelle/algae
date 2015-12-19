note
	description: "Transform a AL_MATRIX to markdown (GitHub dialect, GFM) format"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_MARKDOWN_SUPPORT

feature {AL_INTERNAL} -- Implementation

	matrix_as_markdown (a_matrix: AL_MATRIX): STRING
			-- `a_matrix' in its markdown representation
		local
			l_column_width: ARRAY[INTEGER]
			l_has_row_names, l_has_column_names: BOOLEAN
			l_row, l_line, l_column: INTEGER
			l_string: STRING
		do
			l_has_row_names := False
			l_has_column_names := False
			create l_column_width.make_filled (0, 0, a_matrix.width)
			across
				a_matrix.row_labels as l_cursor
			loop
				if attached l_cursor.item as l_label then
					l_has_row_names := True
					l_column_width[0] := escape_markdown (l_label).count
				end
			end
			across
				a_matrix.column_labels as l_cursor
			loop
				if attached l_cursor.item as l_label then
					l_has_column_names := True
					l_column_width[l_cursor.index] := escape_markdown (l_label).count
				end
			end
			across
				a_matrix.column_by_column as l_cursor
			loop
				l_column_width[l_cursor.column] := l_column_width[l_cursor.column].max (l_cursor.item.out.count)
			end
			l_line := 1
			Result := ""
			if l_has_column_names then
				if l_has_row_names then
					Result.append ("| ")
					Result.append (create {STRING}.make_filled (' ', l_column_width[0] + 1))
				end
				across
					a_matrix.column_labels as l_cursor
				loop
					Result.append ("| ")
					if attached l_cursor.item as l_label then
						l_string := escape_markdown (l_label)
					else
						l_string := ""
					end
					Result.append_string (l_string)
					Result.append (create {STRING}.make_filled (' ', l_column_width[l_cursor.index] + 1 - l_string.count))
				end
				Result.append_string ("|%N")
				l_line := 2
			end
			from
				l_row := 1
			until
				l_row > a_matrix.height
			loop
				if l_line = 2 then
					if l_has_row_names then
						Result.append ("|")
						Result.append (create {STRING}.make_filled ('-', l_column_width[0] + 2))
					end
					from
						l_column := 1
					until
						l_column > a_matrix.width
					loop
						Result.append ("|")
						Result.append (create {STRING}.make_filled ('-', l_column_width[l_column] + 2))
						l_column := l_column + 1
					end
					Result.append_string ("|%N")
				end
				if l_has_row_names then
					Result.append ("| ")
					if attached a_matrix.row_labels[l_row] as l_label then
						l_string := escape_markdown (l_label)
					else
						l_string := ""
					end
					Result.append_string (l_string)
					Result.append (create {STRING}.make_filled (' ', l_column_width[0] + 1 - l_string.count))
				end
				from
					l_column := 1
				until
					l_column > a_matrix.width
				loop
					Result.append ("| ")
					l_string := a_matrix[l_row, l_column].out
					Result.append_string (l_string)
					Result.append (create {STRING}.make_filled (' ', l_column_width[l_column] + 1 - l_string.count))
					l_column := l_column + 1
				end
				Result.append_string ("|%N")
				l_line := l_line + 1
				l_row := l_row + 1
			end

		end

	characters_requiring_escape: STRING = "\`*_{}[]()#+-.|"
			-- Characters that have to be escaped in Markdown

	escape_markdown (a_string: STRING): STRING
			-- Escaped version of `a_string' (if necessary)
		local
			l_index: INTEGER
		do
			create Result.make (a_string.count)
			from
				l_index := 1
			until
				l_index > a_string.count
			loop
				if characters_requiring_escape.has (a_string[l_index]) then
					Result.append_character ('\')
				end
				Result.append_character (a_string[l_index])
				l_index := l_index + 1
			end
		end

end

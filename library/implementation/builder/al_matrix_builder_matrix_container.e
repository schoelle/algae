note
	description: "Container for AL_MATRIX_BUILDER, containing matrices"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_MATRIX_BUILDER_MATRIX_CONTAINER

inherit
	AL_MATRIX_BUILDER_CONTAINER

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_item: AL_MATRIX)
			-- Create container with `a_item'
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature -- Access

	item: AL_MATRIX
		-- Vector to store

feature -- Measurement

	width_when_horizontal: INTEGER
			-- <Precursor>
		do
			Result := item.width
		end

	width_when_vertical: INTEGER
			-- <Precursor>
		do
			Result := item.width
		end

	height_when_horizontal: INTEGER
			-- <Precursor>
		do
			Result := item.height
		end

	height_when_vertical: INTEGER
			-- <Precursor>
		do
			Result := item.height
		end

feature -- Operations

	write_horizontally_into_matrix (a_matrix: AL_MATRIX a_row, a_column: INTEGER)
			-- <Precursor>
		do
			across
				item.column_by_column as l_cursor
			loop
				a_matrix.put (l_cursor.item, l_cursor.row + a_row - 1, l_cursor.column + a_column - 1)
			end
		end

	write_vertically_into_matrix (a_matrix: AL_MATRIX a_row, a_column: INTEGER)
			-- <Precursor>
		do
			write_horizontally_into_matrix (a_matrix, a_row, a_column)
		end

end

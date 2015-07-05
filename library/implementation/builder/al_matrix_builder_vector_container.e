note
	description: "Container for AL_MATRIX_BUILDER, containing vectors"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_MATRIX_BUILDER_VECTOR_CONTAINER

inherit
	AL_MATRIX_BUILDER_CONTAINER

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_item: AL_VECTOR)
			-- Create container with `a_item'
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature -- Access

	item: AL_VECTOR
		-- Vector to store

feature -- Measurement

	width_when_horizontal: INTEGER
			-- <Precursor>
		do
			Result := item.count
		end

	width_when_vertical: INTEGER
			-- <Precursor>
		do
			Result := 1
		end

	height_when_horizontal: INTEGER
			-- <Precursor>
		do
			Result := 1
		end

	height_when_vertical: INTEGER
			-- <Precursor>
		do
			Result := item.count
		end

feature -- Operations

	write_horizontally_into_matrix (a_matrix: AL_MATRIX a_row, a_column: INTEGER)
			-- <Precursor>
		do
			across
				item as l_cursor
			loop
				a_matrix.put (l_cursor.item, a_row, a_column + l_cursor.index - 1)
			end
		end

	write_vertically_into_matrix (a_matrix: AL_MATRIX a_row, a_column: INTEGER)
			-- <Precursor>
		do
			across
				item as l_cursor
			loop
				a_matrix.put (l_cursor.item, a_row + l_cursor.index - 1, a_column)
			end
		end

end

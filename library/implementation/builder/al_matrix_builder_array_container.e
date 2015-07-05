note
	description: "Container for AL_MATRIX_BUILDER, containing arrays"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_MATRIX_BUILDER_ARRAY_CONTAINER

inherit
	AL_MATRIX_BUILDER_CONTAINER

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_item: ARRAY [DOUBLE])
			-- Create container with `a_item'
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature -- Access

	item: ARRAY [DOUBLE]
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
		local
			l_index, l_matrix_column: INTEGER
		do
			from
				l_index := item.lower
				l_matrix_column := a_column
			until
				l_index > item.upper
			loop
				a_matrix.put (item [l_index], a_row, l_matrix_column)
				l_index := l_index + 1
				l_matrix_column := l_matrix_column + 1
			end
		end

	write_vertically_into_matrix (a_matrix: AL_MATRIX a_row, a_column: INTEGER)
			-- <Precursor>
		local
			l_index, l_matrix_row: INTEGER
		do
			from
				l_index := item.lower
				l_matrix_row := a_row
			until
				l_index > item.upper
			loop
				a_matrix.put (item [l_index], l_matrix_row, a_column)
				l_index := l_index + 1
				l_matrix_row := l_matrix_row + 1
			end
		end

end

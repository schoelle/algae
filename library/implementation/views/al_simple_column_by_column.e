note
	description: "Vector containing all values of the matrix, column by column"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_SIMPLE_COLUMN_BY_COLUMN

inherit
	AL_VECTOR

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_matrix: AL_MATRIX)
			-- All values of `a_matrix', column by column.
		do
			matrix := a_matrix
			create {AL_REAL_MATRIX_LABELS} labels.make (count, matrix)
		end

feature -- Access

	underlying_matrix: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := matrix.underlying_matrix
		end

	item alias "[]" (a_index: INTEGER): DOUBLE assign put
			-- <Precursor>
		local
			l_index, l_row, l_column: INTEGER
		do
			l_index := a_index - 1
			l_column := (l_index // matrix.height) + 1
			l_row := (l_index \\ matrix.height) + 1
			Result := matrix.item (l_row, l_column)
		end

	name: detachable STRING
			-- <Precursor>

	labels: AL_LABELS
			-- <Precursor>

	new_cursor: AL_VECTOR_CURSOR
			-- <Precursor>
		do
			create {AL_SIMPLE_VECTOR_CURSOR} Result.make (Current)
		end

	matrix: AL_MATRIX
		-- <Precursor>

	row_for_index (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			Result := ((a_index - 1) \\ matrix.height) + 1
		end

	column_for_index (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			Result := ((a_index - 1) // matrix.height) + 1
		end

feature -- Measurement

	count: INTEGER
			-- <Precursor>
		do
			Result := matrix.height * matrix.width
		end

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- <Precursor>
		local
			l_index, l_row, l_column: INTEGER
		do
			l_index := a_index - 1
			l_column := (l_index // matrix.height) + 1
			l_row := (l_index \\ matrix.height) + 1
			matrix.put (a_value, l_row, l_column)
		end

	set_name (a_name: detachable STRING)
			-- <Precursor>
		do
			name := a_name
		end

end

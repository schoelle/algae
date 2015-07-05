note
	description: "Vector containing the diagonal of a square matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_SIMPLE_DIAGONAL

inherit
	AL_VECTOR

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_matrix: AL_MATRIX)
			-- Column `a_column' of `a_matrix'.
		require
			must_be_square: a_matrix.is_square
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
		do
			Result := matrix.item (a_index, a_index)
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
			Result := a_index
		end

	column_for_index (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			Result := a_index
		end

feature -- Measurement

	count: INTEGER
			-- <Precursor>
		do
			Result := matrix.height
		end

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- <Precursor>
		do
			matrix.put (a_value, a_index, a_index)
		end

	set_name (a_name: detachable STRING)
			-- <Precursor>
		do
			name := a_name
		end

end

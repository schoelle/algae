note
	description: "Vector containing a row of a matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_SIMPLE_MATRIX_ROW

inherit
	AL_VECTOR

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_matrix: AL_MATRIX; a_row: INTEGER)
			-- Row `a_row' of `a_matrix'.
		do
			initialize_double_handling
			matrix := a_matrix
			row_index := a_row
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
			Result := matrix.item (row_index, a_index)
		end

	name: detachable STRING
			-- <Precursor>
		do
			Result := matrix.row_labels.item (row_index)
		end

	labels: AL_LABELS
			-- <Precursor>
		do
			Result := matrix.column_labels
		end

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
			Result := row_index
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
			Result := matrix.width
		end

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- <Precursor>
		do
			matrix.put (a_value, row_index, a_index)
		end

	set_name (a_name: detachable STRING)
			-- <Precursor>
		do
			matrix.row_labels.put (a_name, row_index)
		end

feature {NONE} -- Implementation

	row_index: INTEGER
			-- Index of the selected row

end

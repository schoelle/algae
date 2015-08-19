note
	description: "Vector containing a column of a matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_SIMPLE_MATRIX_COLUMN

inherit
	AL_VECTOR

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_matrix: AL_MATRIX; a_column: INTEGER)
			-- Column `a_column' of `a_matrix'.
		do
			initialize_double_handling
			matrix := a_matrix
			column_index := a_column
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
			Result := matrix.item (a_index, column_index)
		end

	name: detachable STRING
			-- <Precursor>
		do
			Result := matrix.column_labels.item (column_index)
		end

	labels: AL_LABELS
			-- <Precursor>
		do
			Result := matrix.row_labels
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
			Result := a_index
		end

	column_for_index (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			Result := column_index
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
			matrix.put (a_value, a_index, column_index)
		end

	set_name (a_name: detachable STRING)
			-- <Precursor>
		do
			matrix.column_labels.put (a_name, column_index)
		end

feature {NONE} -- Implementation

	column_index: INTEGER
			-- Index of the selected column

end

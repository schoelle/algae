note
	description: "A row in a AL_DENSE_MATIX"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_DENSE_MATRIX_ROW

inherit
	AL_VECTOR

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_dense_matrix: AL_DENSE_MATRIX; a_row: INTEGER)
			-- Make a row vector on `a_dense_matrix', on row `a_row'.
		do
			initialize_double_handling
			row_index := a_row
			dense_matrix := a_dense_matrix
		end

feature -- Access

	underlying_matrix: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := dense_matrix
		end

	item alias "[]" (a_index: INTEGER): DOUBLE assign put
			-- <Precursor>
		do
			Result := dense_matrix.item (row_index, a_index)
		end

	name: detachable STRING
			-- <Precursor>
		do
			Result := dense_matrix.row_labels.item (row_index)
		end

	labels: AL_LABELS
			-- <Precursor>
		do
			Result := dense_matrix.column_labels
		end

	new_cursor: AL_VECTOR_CURSOR
			-- <Precursor>
		do
			create {AL_DENSE_VECTOR_CURSOR} Result.make (dense_matrix, row_index - 1, dense_matrix.height, dense_matrix.width * dense_matrix.height)
		end

	matrix: AL_MATRIX
			-- <Precursor>
		do
			Result := dense_matrix
		end

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
			Result := dense_matrix.width
		end

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- <Precursor>
		do
			dense_matrix.put (a_value, row_index, a_index)
		end

feature -- Settors

	set_name (a_name: detachable STRING)
			-- <Precursor>
		do
			dense_matrix.row_labels.put (a_name, row_index)
		end

feature {NONE} -- Implementation

	dense_matrix: AL_DENSE_MATRIX
		-- Underlying dense matrix

	row_index: INTEGER
		-- Row on the underlying dense matrix

end

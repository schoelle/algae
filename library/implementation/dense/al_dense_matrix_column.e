note
	description: "A column in a AL_DENSE_MATRIX"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_DENSE_MATRIX_COLUMN

inherit
	AL_VECTOR

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_dense_matrix: AL_DENSE_MATRIX; a_column: INTEGER)
			-- Make a column vector on `a_dense_matrix', on column `a_row'.
		do
			column_index := a_column
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
			Result := dense_matrix.item (a_index, column_index)
		end

	name: detachable STRING
			-- <Precursor>
		do
			Result := dense_matrix.column_labels.item (column_index)
		end

	labels: AL_LABELS
			-- <Precursor>
		do
			Result := dense_matrix.row_labels
		end

	new_cursor: AL_VECTOR_CURSOR
			-- <Precursor>
		do
			create {AL_DENSE_VECTOR_CURSOR} Result.make (dense_matrix, (column_index-1) * dense_matrix.height, 1, column_index * dense_matrix.height)
		end

	matrix: AL_MATRIX
			-- <Precursor>
		do
			Result := dense_matrix
		end

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
			Result := dense_matrix.height
		end

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- <Precursor>
		do
			dense_matrix.put (a_value, a_index, column_index)
		end

feature -- Settors

	set_name (a_name: detachable STRING)
			-- <Precursor>
		do
			dense_matrix.column_labels.put (a_name, column_index)
		end

feature {NONE} -- Implementation

	dense_matrix: AL_DENSE_MATRIX
		-- Underlying dense matrix

	column_index: INTEGER
		-- Column on the underlying dense matrix

end

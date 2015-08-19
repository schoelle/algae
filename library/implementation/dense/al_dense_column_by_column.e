note
	description: "Vector column by column on a dense matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_DENSE_COLUMN_BY_COLUMN

inherit
	AL_VECTOR
	AL_INTERNAL

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_dense_matrix: AL_DENSE_MATRIX)
			-- Make a column by column vector on `a_dense_matrix'
		do
			initialize_double_handling
			dense_matrix := a_dense_matrix
			data := a_dense_matrix.data
			create {AL_REAL_MATRIX_LABELS} labels.make (count, dense_matrix)
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
			Result := data.item (a_index - 1)
		end

	name: detachable STRING
		-- <Precursor>

	labels: AL_LABELS
		-- <Precursor>

	new_cursor: AL_VECTOR_CURSOR
			-- <Precursor>
		do
			create {AL_DENSE_VECTOR_CURSOR} Result.make (dense_matrix, 0, 1, data.count)
		end

	matrix: AL_MATRIX
			-- <Precursor>
		do
			Result := dense_matrix
		end

	row_for_index (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			Result := ((a_index - 1) \\ dense_matrix.height) + 1
		end

	column_for_index (a_index: INTEGER): INTEGER
			-- <Precursor>
		do
			Result := ((a_index - 1) // dense_matrix.height) + 1
		end

feature -- Measurement

	count: INTEGER
			-- <Precursor>
		do
			Result := data.count
		end

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- <Precursor>
		do
			data.put (a_value, a_index - 1)
		end

feature -- Settors

	set_name (a_name: detachable STRING)
			-- <Precursor>
		do
			name := a_name
		end

feature {NONE} -- Implementation

	dense_matrix: AL_DENSE_MATRIX
		-- Underlying dense matrix

	data: SPECIAL[DOUBLE]
		-- Data element of `dense_matrix'

end

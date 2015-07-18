note
	description: "A view on partial matrix, that is a subset of an existing matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_PARTIAL_MATRIX

inherit
	AL_MATRIX
		redefine
			swap_columns,
			swap_rows
		end

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_matrix: AL_MATRIX; a_row_map, a_column_map: AL_MAP)
			-- Create a partial matrix on top of `a_matrix', using columns `a_column_map' and rows `a_row_map'.
		do
			original_matrix := a_matrix
			column_map := a_column_map
			row_map := a_row_map
			width := a_column_map.count
			height := a_row_map.count
		end

feature -- Access

	item alias "[]" (a_row, a_column: INTEGER): DOUBLE assign put
			-- <Precursor>
		do
			Result := original_matrix.item (row_map.item (a_row), column_map.item (a_column))
		end

	row_labels: AL_LABELS
			-- Row labels
		do
			create {AL_PARTIAL_MATRIX_LABELS}Result.make (original_matrix.row_labels, row_map)
		end

	column_labels: AL_LABELS
			-- Column labels
		do
			create {AL_PARTIAL_MATRIX_LABELS}Result.make (original_matrix.column_labels, column_map)
		end

	underlying_matrix: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := original_matrix.underlying_matrix
		end

feature -- Measurement

	width: INTEGER
		-- <Precursor>

	height: INTEGER
		-- <Precursor>

feature -- Operations

	put (a_value: DOUBLE; a_row, a_column: INTEGER)
			-- <Precursor>
		do
			original_matrix.put (a_value, row_map.item (a_row), column_map.item (a_column))
		end

	swap_rows (a_first_row, a_second_row: INTEGER)
			-- <Precursor>
		do
			row_map.swap (a_first_row, a_second_row)
		end

	swap_columns (a_first_column, a_second_column: INTEGER)
			-- <Precursor>
		do
			column_map.swap (a_first_column, a_second_column)
		end

feature {AL_INTERNAL} -- Implementation

	original_matrix: AL_MATRIX
		-- Matrix that is transposed

	row_map: AL_MAP
		-- Mapping of local rows to rows in `original_matrix'

	column_map: AL_MAP
		-- Mapping of local columns to columns in `original_matrix'

end

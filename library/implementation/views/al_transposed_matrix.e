note
	description: "The transposed version of a matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_TRANSPOSED_MATRIX

inherit
	AL_MATRIX
		redefine
			transposed,
			as_real
		end

create
	make

feature {NONE} -- Intialization

	make (a_matrix: AL_MATRIX)
			-- Matrix to transpose
		do
			original_matrix := a_matrix
		end

feature -- Access

	item alias "[]" (a_row, a_column: INTEGER): DOUBLE assign put
			-- <Precursor>
		do
			Result := original_matrix.item (a_column, a_row)
		end

	row_labels: AL_LABELS
			-- Row labels
		do
			Result := original_matrix.column_labels
		end

	column_labels: AL_LABELS
			-- Column labels
		do
			Result := original_matrix.row_labels
		end

	underlying_matrix: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := original_matrix.underlying_matrix
		end

	transposed: AL_MATRIX
			-- <Precursor>
		do
			Result := original_matrix
		end

	as_real: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := original_matrix.transposed.as_real
		end

feature -- Measurement

	width: INTEGER
			-- <Precursor>
		do
			Result := original_matrix.height
		end

	height: INTEGER
			-- <Precursor>
		do
			Result := original_matrix.width
		end

feature -- Operations

	put (a_value: DOUBLE; a_row, a_column: INTEGER)
			-- <Precursor>
		do
			original_matrix.put (a_value, a_column, a_row)
		end

feature {NONE} -- Implementation

	original_matrix: AL_MATRIX
		-- Matrix that is transposed

end

note
	description: "[
		A matrix that uses an ARRAY[ARRAY[DOUBLE]] (outer array holds lines of rows, inner arrays hold row values)
		
		CAUTION:
		While there is a precondition on the constructor that all inner arrays are of
		the same length, the implementation will not constantly check that this is
		still the case. The implementation is completely undefined if you manipulate
		the size and structure of the underlying array.
		
		Also, please be aware that this is a highly inefficient way to storing data. Try to transform the array
		into a proper, dense matrix as fast as possible.
	]"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_ARRAY_MATRIX

inherit
	AL_REAL_MATRIX
	AL_ARRAY_MATRIX_SUPPORT

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_data: ARRAY [ARRAY [DOUBLE]])
			-- Create a matrix with size `a_width' by `a_height', filled with `a_value'.
		require
			valid_array: is_valid_array_matrix (a_data)
		do
			initialize_double_handling
			height := a_data.count
			if height >= 1 then
				width := a_data.item (1).count
			else
				width := 0
			end
			data := a_data
			create {AL_REAL_MATRIX_LABELS}internal_row_labels.make (height, Current)
			create {AL_REAL_MATRIX_LABELS}internal_column_labels.make (width, Current)
		end

feature -- Access

	item alias "[]" (a_row, a_column: INTEGER): DOUBLE assign put
			-- <Precursor>
		do
			Result := data.item (a_row).item (a_column)
		end

	row_labels: AL_LABELS
			-- Row labels
		do
			check attached internal_row_labels as l_labels then
				Result := l_labels
			end
		end

	column_labels: AL_LABELS
			-- Column labels
		do
			check attached internal_column_labels as l_labels then
				Result := l_labels
			end
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
			data.item (a_row).put (a_value, a_column)
		end

feature {AL_INTERNAL} -- Implementation

	data: ARRAY [ARRAY [DOUBLE]]
		-- Actual data representation

	internal_row_labels: detachable AL_REAL_MATRIX_LABELS
		-- Actual row labels

	internal_column_labels: detachable AL_REAL_MATRIX_LABELS
		-- Actual column labels

end

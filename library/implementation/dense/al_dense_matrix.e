note
	description: "Implementation of AL_REAL_MATRIX using a single array, ordered by column"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_DENSE_MATRIX

inherit
	AL_REAL_MATRIX
		redefine
			copy_values_into,
			fill,
			row,
			column,
			diagonal,
			column_by_column
		end

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_height, a_width: INTEGER; a_value: DOUBLE)
			-- Create a matrix with size `a_width' by `a_height', filled with `a_value'.
		require
			positive_height: height >= 0
			positive_width: width >= 0
		do
			height := a_height
			width := a_width
			create data.make_filled (a_value, a_width * a_height)
			create {AL_REAL_MATRIX_LABELS}internal_row_labels.make (a_height, Current)
			create {AL_REAL_MATRIX_LABELS}internal_column_labels.make (a_width, Current)
		end

feature -- Access

	item alias "[]" (a_row, a_column: INTEGER): DOUBLE assign put
			-- <Precursor>
		do
			Result := data.item ((a_column - 1) * height + a_row - 1)
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

	row (a_index: INTEGER): AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_MATRIX_ROW}Result.make (Current, a_index)
		end

	column (a_index: INTEGER): AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_MATRIX_COLUMN}Result.make (Current, a_index)
		end

	diagonal: AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_DIAGONAL}Result.make (Current)
		end

	column_by_column: AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_COLUMN_BY_COLUMN}Result.make (Current)
		end

feature -- Measurement

	width: INTEGER
		-- <Precursor>

	height: INTEGER
		-- <Precursor>

feature -- INTO Operations

	copy_values_into (a_target: AL_MATRIX)
			-- Copy the current matrix into `a_target', only the values.
		do
			if attached {AL_DENSE_MATRIX}a_target as l_dense_matrix then
				l_dense_matrix.data.copy_data (data, 0, 0, height * width)
			else
				Precursor (a_target)
			end
		end

feature -- Operations

	put (a_value: DOUBLE; a_row, a_column: INTEGER)
			-- <Precursor>
		do
			data.put (a_value, (a_column - 1) * height + a_row - 1)
		end

	fill (a_value: DOUBLE)
			-- <Precursor>
		do
			data.fill_with (a_value, 0, (width * height) - 1)
		end

feature {AL_INTERNAL} -- Implementation

	data: SPECIAL [DOUBLE]
		-- Actual data representation

	internal_row_labels: detachable AL_REAL_MATRIX_LABELS
		-- Actual row labels

	internal_column_labels: detachable AL_REAL_MATRIX_LABELS
		-- Actual column labels

end

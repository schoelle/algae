note
	description: "A square, symmetric matrix, column and row labels are the same"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_SYMMETRIC_MATRIX

inherit
	AL_REAL_MATRIX
		redefine
			fill,
			transposed,
			transposed_view,
			set_default_labels,
			are_all_fields_independent
		end

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_size: INTEGER; a_value: DOUBLE)
			-- Create a symmetric matrix with size `a_size' by `a_size', filled with `a_value'.
		require
			positive_size: a_size >= 0
		do
			height := a_size
			width := a_size
			internal_count := (a_size * (a_size + 1)) // 2
			create data.make_filled (a_value, internal_count)
			create {AL_REAL_MATRIX_LABELS}internal_labels.make (a_size, Current)
		end

feature -- Access

	item alias "[]" (a_row, a_column: INTEGER): DOUBLE assign put
			-- <Precursor>
		do
			Result := data.item (position (a_row, a_column))
		end

	row_labels: AL_LABELS
			-- Row labels
		do
			check attached internal_labels as l_labels then
				Result := l_labels
			end
		end

	column_labels: AL_LABELS
			-- Column labels
		do
			check attached internal_labels as l_labels then
				Result := l_labels
			end
		end

	transposed: AL_MATRIX
			-- <Precursor>
		do
			Result := Current
		end

	transposed_view: AL_MATRIX
			-- <Precursor>
		do
			Result := Current
		end

feature -- Status report

	are_all_fields_independent: BOOLEAN
			-- <Precursor>
		do
			Result := False
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
			data.put (a_value, position (a_row, a_column))
		end

	fill (a_value: DOUBLE)
			-- <Precursor>
		do
			data.fill_with (a_value, 0, internal_count - 1)
		end

	set_default_labels
			-- <Precursor>
		do
			row_labels.set_default ("item")
		end

feature {AL_INTERNAL} -- Implementation

	position (a_row, a_column:INTEGER) : INTEGER
			-- Position of `a_row' and `a_column' in `data'
		local
			l_row, l_column, l_skip: INTEGER
		do
			if a_row >= a_column then
				l_row := a_row - 1
				l_column := a_column - 1
			else
				l_row := a_column - 1
				l_column := a_row - 1
			end
			l_skip := (l_column * (l_column + 1)) // 2
			Result := l_column * height + l_row - l_skip
		end

	data: SPECIAL [DOUBLE]
		-- Actual data representation

	internal_count: INTEGER
		-- Total number of fields

	internal_labels: detachable AL_REAL_MATRIX_LABELS
		-- Actual labels

end

note
	description: "A cursor on a AL_DENSE_MATRIX, defined by an offset, step size and a limit"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_DENSE_VECTOR_CURSOR

inherit
	AL_VECTOR_CURSOR
	AL_INTERNAL

create {AL_INTERNAL}
	make

feature {NONE} -- Implementation

	make (a_matrix: AL_DENSE_MATRIX; a_offset, a_step_size, a_limit: INTEGER)
			-- Create a cursor for `a_vector' on `a_matrix', starting at `a_offset', each set `a_step_size' and ending at `a_limit'.
		do
			dense_matrix := a_matrix
			data := a_matrix.data
			position := a_offset
			offset := a_offset
			step_size := a_step_size
			limit := a_limit
		end

feature -- Access

	column: INTEGER
			-- <Precursor>
		do
			Result := (position // dense_matrix.height) + 1
		end

	row: INTEGER
			-- <Precursor>
		do
			Result := (position \\ dense_matrix.height) + 1
		end

	item: DOUBLE
			-- <Precursor>
		do
			Result := data.item (position)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := ((position - offset) // step_size) + 1
		end

	matrix: AL_MATRIX
			-- <Precursor>
		do
			Result := dense_matrix
		end

feature -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := position >= limit
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			position := position + step_size
		end

feature -- Operations

	put (a_value: DOUBLE)
			-- <Precursor>
		do
			data.put (a_value, position)
		end

feature {NONE} -- Implementation

	data: SPECIAL [DOUBLE]
		-- Underlying data

	dense_matrix: AL_DENSE_MATRIX
		-- Underlying dense matrix

	offset: INTEGER
		-- Start offset for `position'

	position: INTEGER
		-- Current position of the cursor into `data'

	step_size: INTEGER
		-- Size to increase `position' for each `forth'

	limit: INTEGER
		-- Consider the cursor to be after if the position is at limit or above

end

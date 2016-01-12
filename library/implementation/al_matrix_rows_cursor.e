note
	description: "Cursor on the sequence of rows from a give matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_MATRIX_ROWS_CURSOR

inherit
	ITERATION_CURSOR[AL_VECTOR]

create
	make

feature -- Initialization

	make (a_matrix: AL_MATRIX)
			-- Create a rows cursor on `a_matrix'.
		do
			matrix := a_matrix
			index := 1
		end

feature -- Access

	item: AL_VECTOR
			-- <Precursor>
		do
			Result := matrix.row (index)
		end

	matrix: AL_MATRIX
		-- Matrix we operate on

	index: INTEGER
		-- Index of the current row

feature -- Status report	

	after: BOOLEAN
			-- <Precursor>
		do
			Result := index > matrix.height
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			index := index + 1
		end

end

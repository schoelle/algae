note
	description: "Sequence of columns from a give matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"
	
class
	AL_MATRIX_COLUMNS

inherit
	ITERABLE[AL_VECTOR]

create
	make

feature -- Initialization

	make (a_matrix: AL_MATRIX)
			-- Create sequence of columns from `a_matrix'.
		do
			matrix := a_matrix
		end

feature -- Access

	new_cursor: AL_MATRIX_COLUMNS_CURSOR
			-- <Precursor>
		do
			create Result.make (matrix)
		end

	matrix: AL_MATRIX
		-- Matrix containing the columns

end

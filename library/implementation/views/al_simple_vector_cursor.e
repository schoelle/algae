note
	description: "Simple cursor on any vector"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_SIMPLE_VECTOR_CURSOR

inherit
	AL_VECTOR_CURSOR

create {AL_INTERNAL}
	make

feature {NONE} -- Implementation

	make (a_vector: AL_VECTOR)
			-- Create a cursor on `a_vector'.
		do
			vector := a_vector
			index := 1
		end

feature -- Access

	column: INTEGER
			-- <Precursor>
		do
			Result := vector.column_for_index (index)
		end

	row: INTEGER
			-- <Precursor>
		do
			Result := vector.row_for_index (index)
		end

	item: DOUBLE
			-- <Precursor>
		do
			Result := vector.item (index)
		end

	index: INTEGER
			-- <Precursor>

	matrix: AL_MATRIX
			-- <Precursor>
		do
			Result := vector.matrix
		end

feature -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := index > vector.count
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			index := index + 1
		end

feature -- Operations

	put (a_value: DOUBLE)
			-- <Precursor>
		do
			vector.put (a_value, index)
		end

feature {NONE} -- Implementation

	vector: AL_VECTOR
		-- Vector this cursor operates on

end

note
	description: "A cursor on a AL_VECTOR"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_VECTOR_CURSOR

inherit
	ITERATION_CURSOR [DOUBLE]

feature -- Access

	item: DOUBLE
			-- <Precursor>
		deferred
		end

	index: INTEGER
			-- Index of the cursor
		deferred
		end

	row: INTEGER
			-- Current row of the cursor
		deferred
		end

	column: INTEGER
			-- Current column of the cursor
		deferred
		end

	matrix: AL_MATRIX
			-- Matrix the cursor is operating on
		deferred
		end

feature -- Operations

	put (a_value: DOUBLE)
			-- Store `a_value' at the cursor position.
		deferred
		ensure
			set: item = a_value
		end

end

note
	description: "Assemble a matrix from a list of inputs"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_MATRIX_BUILDER

inherit
	AL_INTERNAL

feature -- Access

	item: AL_MATRIX
			-- Assembled MATRIX
		deferred
		end

feature -- Measurement

	height: INTEGER
			-- Height of the overall matrix
		deferred
		ensure
			positive: height >= 0
		end

	width: INTEGER
			-- Width of the overall matrix
		deferred
		ensure
			positive: width >= 0
		end

feature -- Operations

	add_matrix (a_matrix: AL_MATRIX)
			-- Append `a_matrix' to the end.
		require
			size_ok: has_correct_dimensions (a_matrix.height, a_matrix.width)
		local
			l_container: AL_MATRIX_BUILDER_MATRIX_CONTAINER
		do
			create l_container.make (a_matrix)
			containers.extend (l_container)
		end

	add_vector (a_vector: AL_VECTOR)
			-- Append `a_vector' to the end.
		require
			size_ok: has_correct_count (a_vector.count)
		local
			l_container: AL_MATRIX_BUILDER_VECTOR_CONTAINER
		do
			create l_container.make (a_vector)
			containers.extend (l_container)
		end

	add_array (a_array: ARRAY [DOUBLE])
			-- Append `a_array' to the end.
		require
			size_ok: has_correct_count (a_array.count)
		local
			l_container: AL_MATRIX_BUILDER_ARRAY_CONTAINER
		do
			create l_container.make (a_array)
			containers.extend (l_container)
		end

feature -- Contract support

	has_correct_count (a_count: INTEGER): BOOLEAN
			-- Is `a_count' ok for a 1-dimensional structure?
		deferred
		end

	has_correct_dimensions (a_height, a_width: INTEGER): BOOLEAN
			-- Is `a_height' and `a_width' acceptable for a 2-dimensional structure?
		deferred
		end

feature {NONE} -- Implementation

	containers: LINKED_LIST [AL_MATRIX_BUILDER_CONTAINER]
		-- List of containers

end

note
	description: "Abstract container for a AL_MATRIX_BUILDER"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_MATRIX_BUILDER_CONTAINER

feature -- Measurement

	width_when_horizontal: INTEGER
			-- Width of content when stored horizonally
		deferred
		end

	width_when_vertical: INTEGER
			-- Width of content when stored vertically
		deferred
		end

	height_when_horizontal: INTEGER
			-- Height of content when stored horizonally
		deferred
		end

	height_when_vertical: INTEGER
			-- Height of content when stored vertically
		deferred
		end

feature -- Operations

	write_horizontally_into_matrix (a_matrix: AL_MATRIX a_row, a_column: INTEGER)
			-- Write content into the `a_matrix' at location `a_row' and `a_column'
		require
			width_ok: a_matrix.width >= a_column + width_when_horizontal - 1
			height_ok: a_matrix.height >= a_row + height_when_horizontal - 1
		deferred
		end

	write_vertically_into_matrix (a_matrix: AL_MATRIX a_row, a_column: INTEGER)
			-- Write content into the `a_matrix' at location `a_row' and `a_column'
		require
			width_ok: a_matrix.width >= a_column + width_when_vertical - 1
			height_ok: a_matrix.height >= a_row + height_when_vertical - 1
		deferred
		end

end

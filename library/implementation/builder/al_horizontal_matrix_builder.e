note
	description: "A builder that assembles matrices horizonally"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_HORIZONTAL_MATRIX_BUILDER

inherit
	AL_MATRIX_BUILDER
	ALGAE_USER

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make
			-- Create an empty builder
		do
			create containers.make
		end

feature -- Access

	item: AL_MATRIX
			-- <Precursor>
		local
			l_column: INTEGER
		do
			Result := al.matrix (height,width)
			l_column := 1
			across
				containers as l_cursor
			loop
				l_cursor.item.write_vertically_into_matrix (Result, 1, l_column)
				l_column := l_column + l_cursor.item.width_when_vertical
			end
		end

feature -- Measurement

	height: INTEGER
			-- <Precursor>
		do
			if containers.is_empty then
				Result := 0
			else
				Result := containers.first.height_when_vertical
			end
		end

	width: INTEGER
			-- <Precursor>
		do
			Result := 0
			across
				containers as l_cursor
			loop
				Result := Result + l_cursor.item.width_when_vertical
			end
		end

feature -- Contract support

	has_correct_count (a_count: INTEGER): BOOLEAN
			-- <Precursor>
		do
			if containers.is_empty then
				Result := True
			else
				Result := a_count = containers.first.height_when_vertical
			end
		end

	has_correct_dimensions (a_height, a_width: INTEGER): BOOLEAN
			-- <Precursor>
		do
			if containers.is_empty then
				Result := True
			else
				Result := a_height = containers.first.height_when_vertical
			end

		end

end

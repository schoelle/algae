note
	description: "Gauss elimination"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_GAUSSIAN_ELIMINATION

inherit
	ALGAE_USER
	AL_DOUBLE_HANDLER

create
	make

feature -- Initialisation

	make (a_matrix: AL_MATRIX)
			-- Initialise the algorithm with `a_matrix' as input and output to same-height diagonal.
		do
			initialize_double_handling_from (a_matrix)
			input := a_matrix
			output := al.unit (a_matrix.height)
		ensure
			input_set: input = a_matrix
			output_created: output.is_unit and output.height = input.height
		end

feature -- Access

	input: AL_MATRIX
		-- Input matrix

	output: AL_MATRIX
		-- Output matrix

feature -- Settings

	set_output (a_matrix: AL_MATRIX)
			-- Set output to `a_matrix'.
		require
			height_ok: a_matrix.height = input.height
		do
			output := a_matrix
		ensure
			output_set: output = a_matrix
		end

feature -- Status report

	last_successful: BOOLEAN
		-- Was the last run of `eliminate' or `solve' successful?

feature -- Processing

	eliminate
			-- Runs the Gauss eleminitation algorithm to build the row echolon.
		local
			l_col, l_row, l_lower_row: INTEGER
		do
			from
				l_col := 1
				l_row := 1
			until
				l_col > input.width
			loop
				try_make_non_zero (l_row, l_col)
				if not is_zero (l_row, l_col) then
					from
						l_lower_row := l_row + 1
					until
						l_lower_row > input.height
					loop
						neutralize_row (l_lower_row, l_col, l_row)
						l_lower_row := l_lower_row + 1
					end
					l_row := l_row + 1
				end
				l_col := l_col + 1
			end
			last_successful := input.is_row_echolon
		end

	solve
			-- Transform the `input' into a unit matrix, by first running `eliminate' and afterwards
			-- removing the upper diagonal. Only works on square matrices.
		require
			square: input.is_square
		local
			l_row, l_lower_row: INTEGER
		do
			if not input.is_row_echolon then
				eliminate
			end
			if last_successful then
				if is_zero (input.height, input.width) then
					last_successful := False
				else
					from
						l_lower_row := input.height
					until
						l_lower_row < 1
					loop
						from
							l_row := 1
						until
							l_row >= l_lower_row
						loop
							neutralize_row (l_row, l_lower_row, l_lower_row)
							l_row := l_row + 1
						end
						scale_to_one (l_lower_row, l_lower_row)
						l_lower_row := l_lower_row - 1
					end
				end
			end
		end


feature {NONE} -- Internal

	is_zero (a_row, a_column: INTEGER): BOOLEAN
			-- Is `a_row',`a_column' zero in the input
		do
			Result := same_double (input[a_row, a_column], 0.0)
		end

	scale_to_one (a_row, a_column: INTEGER)
			-- Scale row `a_row' such that the element at `a_column' is 1.0.
		require
			not_zero: not is_zero (a_row, a_column)
		local
			l_factor: DOUBLE
		do
			l_factor := 1.0 / input[a_row, a_column]
			input.row (a_row).scale (l_factor)
			output.row (a_row).scale (l_factor)
		end

	neutralize_row (a_row, a_column, a_by_row: INTEGER)
			-- Make `a_row', `a_column' to zero by subtracting `a_by_row' the correct number of times.
		require
			not_zero: not is_zero (a_by_row, a_column)
		local
			l_factor: DOUBLE
		do
			l_factor := - (input[a_row, a_column] / input[a_by_row, a_column])
			input.row (a_row).add_scaled_vector (input.row (a_by_row), l_factor)
			output.row (a_row).add_scaled_vector (output.row (a_by_row), l_factor)
		end

	try_make_non_zero (a_row, a_column: INTEGER)
			-- To to make `a_row', `a_column' not zero by swaping `a_row' with a lower indexed row.
		local
			l_new_row: INTEGER
		do
			if is_zero (a_row, a_column) then
				from
					l_new_row := a_row
				until
					l_new_row > input.height or else not is_zero(l_new_row, a_column)
				loop
					l_new_row := l_new_row + 1
				end
				if l_new_row <= input.height then
					input.swap_rows (a_row, l_new_row)
					output.swap_rows (a_row, l_new_row)
				end
			end
		end

end

note
	description: "Implementation of AL_REAL_MATRIX using a single array, ordered by column"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_DENSE_MATRIX

inherit
	AL_REAL_MATRIX
		redefine
			copy_values_into,
			fill,
			row,
			column,
			diagonal,
			column_by_column,
			multiply_into,
			transpose_into,
			as_dense
		end

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_height, a_width: INTEGER; a_value: DOUBLE)
			-- Create a matrix with size `a_width' by `a_height', filled with `a_value'.
		require
			positive_height: height >= 0
			positive_width: width >= 0
		do
			initialize_double_handling
			height := a_height
			width := a_width
			create data.make_filled (a_value, a_width * a_height)
			create {AL_REAL_MATRIX_LABELS}internal_row_labels.make (a_height, Current)
			create {AL_REAL_MATRIX_LABELS}internal_column_labels.make (a_width, Current)
		end

feature -- Access

	item alias "[]" (a_row, a_column: INTEGER): DOUBLE assign put
			-- <Precursor>
		do
			Result := data.item ((a_column - 1) * height + a_row - 1)
		end

	row_labels: AL_LABELS
			-- Row labels
		do
			check attached internal_row_labels as l_labels then
				Result := l_labels
			end
		end

	column_labels: AL_LABELS
			-- Column labels
		do
			check attached internal_column_labels as l_labels then
				Result := l_labels
			end
		end

	row (a_index: INTEGER): AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_MATRIX_ROW}Result.make (Current, a_index)
			Result.initialize_double_handling_from (Current)
		end

	column (a_index: INTEGER): AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_MATRIX_COLUMN}Result.make (Current, a_index)
			Result.initialize_double_handling_from (Current)
		end

	diagonal: AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_DIAGONAL}Result.make (Current)
			Result.initialize_double_handling_from (Current)
		end

	column_by_column: AL_VECTOR
			-- <Precursor>
		do
			create {AL_DENSE_COLUMN_BY_COLUMN}Result.make (Current)
			Result.initialize_double_handling_from (Current)
		end

feature -- Measurement

	width: INTEGER
		-- <Precursor>

	height: INTEGER
		-- <Precursor>

feature -- Conversion

	as_dense: AL_REAL_MATRIX
			-- <Precusor>
		do
			Result := Current
		ensure then
			definition: Result = Current
		end

feature -- INTO Operations

	multiply_into (a_second, a_target: AL_MATRIX)
			-- <Precursor>
		do
			if attached {AL_DENSE_MATRIX} a_second as l_second and
			   attached {AL_DENSE_MATRIX} a_target as l_target then
				fast_multiplication (l_second, l_target)
			else
				Precursor (a_second, a_target)
			end
		end

	copy_values_into (a_target: AL_MATRIX)
			-- <Precursor>
		do
			if attached {AL_DENSE_MATRIX}a_target as l_dense_matrix then
				l_dense_matrix.data.copy_data (data, 0, 0, height * width)
			else
				Precursor (a_target)
			end
		end

	transpose_into (a_target: AL_MATRIX)
			-- <Precursor>
		do
			if attached {AL_DENSE_MATRIX}a_target as l_dense_matrix then
				fast_transpose (l_dense_matrix)
			else
				Precursor (a_target)
			end
		end

feature -- Operations

	put (a_value: DOUBLE; a_row, a_column: INTEGER)
			-- <Precursor>
		do
			data.put (a_value, (a_column - 1) * height + a_row - 1)
		end

	fill (a_value: DOUBLE)
			-- <Precursor>
		do
			data.fill_with (a_value, 0, (width * height) - 1)
		end

feature {AL_INTERNAL} -- Implementation

	data: SPECIAL [DOUBLE]
		-- Actual data representation

	internal_row_labels: detachable AL_REAL_MATRIX_LABELS
		-- Actual row labels

	internal_column_labels: detachable AL_REAL_MATRIX_LABELS
		-- Actual column labels

	fast_transpose (a_target: AL_DENSE_MATRIX)
			-- Fast transpose of `Current' into `a_target'.
		local
			l_block_end_i, l_block_end_j: INTEGER
			l_i, l_j: INTEGER
			l_width, l_height: INTEGER
			l_block_i, l_block_j: INTEGER
			l_source, l_target: SPECIAL[DOUBLE]
		do
			l_source := data
			l_target := a_target.data
			l_width := width
			l_height := height

			from
				l_block_i := 0
			until
				l_block_i >= l_width
			loop
				l_block_end_i := l_width.min (l_block_i + block_size)
				from
					l_block_j := 0
				until
					l_block_j >= l_height
				loop
					l_block_end_j := l_height.min (l_block_j + block_size)
					from
						l_i := l_block_i
					until
						l_i >= l_block_end_i
					loop
						from
							l_j := l_block_j
						until
							l_j >= l_block_end_j
						loop
							l_target[l_j*l_width+l_i] := l_source[l_i*l_height+l_j]
							l_j := l_j + 1
						end
						l_i := l_i + 1
					end
					l_block_j := l_block_j + block_size
				end
				l_block_i := l_block_i + block_size
			end
		end

	fast_multiplication (a_second, a_target: AL_DENSE_MATRIX)
			-- Multiply `Current' by `a_second', storing the results in `a_target', using
			-- internals of AL_DENSE_MATRIX.
		local
			l_block_end_i, l_block_end_j, l_block_end_k: INTEGER
			l_i, l_j, l_k: INTEGER
			l_sum: DOUBLE
			l_width, l_height, l_depth: INTEGER
			l_block_i, l_block_j, l_block_k: INTEGER
			l_first, l_second, l_target: SPECIAL[DOUBLE]
		do
			l_first := data
			l_second := a_second.data
			l_target := a_target.data
			l_width := a_target.width
			l_height := a_target.height
			l_depth := width
			a_target.fill (0.0)

			from
				l_block_i := 0
			until
				l_block_i >= l_width
			loop
				l_block_end_i := l_width.min (l_block_i + block_size)
				from
					l_block_j := 0
				until
					l_block_j >= l_height
				loop
					l_block_end_j := l_height.min (l_block_j + block_size)
					from
						l_block_k := 0
					until
						l_block_k >= l_depth
					loop
						l_block_end_k := l_depth.min (l_block_k + block_size)
						from
							l_i := l_block_i
						until
							l_i >= l_block_end_i
						loop
							from
								l_j := l_block_j
							until
								l_j >= l_block_end_j
							loop
								l_sum := l_target[l_i*l_height+l_j]
								from
									l_k := l_block_k
								until
									l_k >= l_block_end_k
								loop
									l_sum := l_sum + l_first[l_k*l_height+l_j] * l_second[l_i*l_depth+l_k]
									l_k := l_k + 1
								end
								l_target[l_i*l_height+l_j] := l_sum
								l_j := l_j + 1
							end
							l_i := l_i + 1
						end

						l_block_k := l_block_k + block_size
					end
					l_block_j := l_block_j + block_size
				end
				l_block_i := l_block_i + block_size
			end
		end

end

note
	description: "Abstraction of a 2-dimentional matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_MATRIX

inherit
	AL_INTERNAL
	AL_MAP_SUPPORT
		export
			{NONE} all
		end

feature -- Access

	item alias "[]" (a_row, a_column: INTEGER): DOUBLE assign put
			-- Value at `a_row' and `a_column'
		require
			valid_row: is_valid_row (a_row)
			valid_column: is_valid_column (a_column)
		deferred
		end

	item_labeled (a_row, a_column: STRING): DOUBLE
			-- Value at row labeled `a_row' and column labeled `a_column'
		require
			has_row: row_labels.has (a_row)
			has_column: column_labels.has (a_column)
		do
			Result := item (row_labels.index (a_row), column_labels.index (a_column))
		end

	row_labels: AL_LABELS
			-- Row labels
		deferred
		end

	column_labels: AL_LABELS
			-- Column labels
		deferred
		end

	row (a_index: INTEGER): AL_VECTOR
			-- Row with index `a_index'
		require
			valid_row: is_valid_row (a_index)
		do
			create {AL_SIMPLE_MATRIX_ROW} Result.make (Current, a_index)
		end

	row_labeled (a_label: STRING): AL_VECTOR
			-- Row labeled `a_label'
		require
			has_label: row_labels.has (a_label)
		do
			Result := row (row_labels.index (a_label))
		end

	column (a_index: INTEGER): AL_VECTOR
			-- Column with index `a_index'
		require
			valid_column: is_valid_column (a_index)
		do
			create {AL_SIMPLE_MATRIX_COLUMN} Result.make (Current, a_index)
		end

	column_labeled (a_label: STRING): AL_VECTOR
			-- Column labeled `a_label'
		require
			has_label: column_labels.has (a_label)
		do
			Result := column (column_labels.index (a_label))
		end

	diagonal: AL_VECTOR
			-- Diagonal of `Current'
		require
			must_be_square: is_square
		do
			create {AL_SIMPLE_DIAGONAL} Result.make (Current)
		end

	column_by_column: AL_VECTOR
			-- All values of `Current', column by column
		do
			create {AL_SIMPLE_COLUMN_BY_COLUMN} Result.make (Current)
		end

	underlying_matrix: AL_REAL_MATRIX
			-- The underlying real matrix used to store the data
		deferred
		end

	real: AL_REAL_MATRIX
			-- This matrix, as a real matrix, copying if necessary
		do
			Result := duplicated
		end

	duplicated: AL_REAL_MATRIX
			-- Copy of `Current' as a real matrix, always copying the data
		do
			create {AL_DENSE_MATRIX}Result.make (height, width, 0.0)
			copy_values_into (Result)
			row_labels.copy_into (Result.row_labels)
			column_labels.copy_into (Result.column_labels)
		ensure
			same_matrix: is_same (Result)
			different_underlying: Result.underlying_matrix /= underlying_matrix
		end

	times (a_other: AL_MATRIX): AL_MATRIX
			-- Multiply `Current' by `a_other'
		require
			can_multiply: width = a_other.height
		do
			create {AL_DENSE_MATRIX}Result.make (height, a_other.width, 0.0)
			multiply_into (a_other, Result)
			row_labels.copy_into (Result.row_labels)
			a_other.column_labels.copy_into (Result.column_labels)
		end

	aat: AL_MATRIX
			-- Multiply `Current' by its own transpose, not in-place
		do
			Result := transposed.ata
		ensure
			different_underlying: Result.underlying_matrix /= underlying_matrix
		end

	ata: AL_MATRIX
			-- Multiply `Current' by its own transpose, not in-place
		do
			create {AL_DENSE_MATRIX} Result.make (width, width, 0.0)
			ata_into (Result)
			column_labels.copy_into (Result.row_labels)
			column_labels.copy_into (Result.column_labels)
		ensure
			different_underlying: Result.underlying_matrix /= underlying_matrix
		end

	csv: STRING
			-- CSV representation of `Current'
		local
			a_printer: AL_CSV_SUPPORT
		do
			create a_printer
			Result := a_printer.matrix_as_csv (Current)
		end

	transposed_view: AL_MATRIX
			-- Transposed view on `Current'
		do
			create {AL_TRANSPOSED_MATRIX}Result.make (Current)
		ensure
			same_underlying: Result.underlying_matrix = underlying_matrix
		end

	transposed: AL_MATRIX
			-- Transposed version of `Current'
		do
			create {AL_DENSE_MATRIX}Result.make (width, height, 0.0)
			transpose_into (Result)
			row_labels.copy_into (Result.column_labels)
			column_labels.copy_into (Result.row_labels)
		end

	area (a_min_row, a_min_column, a_max_row, a_max_column: INTEGER): AL_MATRIX
			-- Partial area of `Current' between column `a_min_column' and `a_max_column', and rows `a_min_row' and `a_max_row'
		require
			min_row_valid: a_min_row >= 1
			max_row_valid: a_max_row <= height
			min_column_valid: a_min_column >= 1
			max_column_valid: a_max_column <= width
			min_max_row: a_min_row <= a_max_row
			min_max_column: a_min_column <= a_max_column
		local
			l_row_map: ARRAY[INTEGER]
			l_column_map: ARRAY[INTEGER]
			l_index: INTEGER
		do
			create l_row_map.make_filled (0, 1, a_max_row - a_min_row + 1)
			from
				l_index := 1
			until
				l_index > l_row_map.count
			loop
				l_row_map.put (a_min_row + l_index - 1, l_index)
				l_index := l_index + 1
			end
			create l_column_map.make_filled (0, 1, a_max_column - a_min_column + 1)
			from
				l_index := 1
			until
				l_index > l_column_map.count
			loop
				l_column_map.put (a_min_column + l_index - 1, l_index)
				l_index := l_index + 1
			end
			create {AL_PARTIAL_MATRIX}Result.make (Current, l_row_map, l_column_map)
		end

feature -- Measurement

	width: INTEGER
			-- Width of the matrix
		deferred
		ensure
			positive: width >= 0
		end

	height: INTEGER
			-- Height of the matrix
		deferred
		ensure
			positive: height >= 0
		end

feature -- Status

	is_valid_row (a_row: INTEGER): BOOLEAN
			-- Is `a_row' a valid index for a row?
		do
			Result := (1 <= a_row) and (a_row <= height)
		ensure
			definition: Result = ((1 <= a_row) and (a_row <= height))
		end

	is_valid_column (a_column: INTEGER): BOOLEAN
			-- Is `a_column' a valid index for a column?
		do
			Result := (1 <= a_column) and (a_column <= width)
		ensure
			definition: Result = ((1 <= a_column) and (a_column <= width))
		end

	is_square: BOOLEAN
			-- Is this a square matrix?
		do
			Result := width = height
		ensure
			definition: Result = (width = height)
		end

	is_symmetric: BOOLEAN
			-- Is the matrix symmetric?
		local
			l_row, l_column: INTEGER
		do
			Result := is_square
			from
				l_column := 1
			until
				l_column > width or not Result
			loop
				from
					l_row := l_column + 1
				until
					l_row > height or not Result
				loop
					Result := item (l_column, l_row) = item (l_row, l_column)
					l_row := l_row + 1
				end
				l_column := l_column + 1
			end
		end

	is_lower_triangle: BOOLEAN
			-- Is this a lower triangle, and everything above the diagonal is 0.0?
		local
			l_row, l_column: INTEGER
		do
			Result := is_square
			from
				l_column := 2
			until
				l_column > width or not Result
			loop
				from
					l_row := 1
				until
					l_row >= l_column or not Result
				loop
					Result := item (l_row, l_column) = 0
					l_row := l_row + 1
				end
				l_column := l_column + 1
			end
		end

	is_upper_triangle: BOOLEAN
			-- Is this an upper triangle, and everything below the diagonal is 0.0?
		local
			l_row, l_column: INTEGER
		do
			Result := is_square
			from
				l_column := 1
			until
				l_column >= width or not Result
			loop
				from
					l_row := l_column + 1
				until
					l_row > height or not Result
				loop
					Result := item (l_row, l_column) = 0
					l_row := l_row + 1
				end
				l_column := l_column + 1
			end
		end

	is_empty: BOOLEAN
			-- Is this an empty matrix (height or width is 0)?
		do
			Result := (height = 0) or (width = 0)
		ensure
			definition: Result = ((height = 0) or (width = 0))
		end

	is_same (a_other: AL_MATRIX): BOOLEAN
			-- Is `a_other' the same matrix as `Current'?
			-- This includes all values and labels.
		local
			l_col_index, l_row_index: INTEGER
		do
			Result := height = a_other.height and width = a_other.width
			Result := Result and then row_labels.is_same (a_other.row_labels)
			Result := Result and then column_labels.is_same (a_other.column_labels)
			from
				l_col_index := 1
			until
				l_col_index > width or not Result
			loop
				from
					l_row_index := 1
				until
					l_row_index > height or not Result
				loop
					Result := item (l_row_index, l_col_index) = a_other.item (l_row_index, l_col_index)
					l_row_index := l_row_index + 1
				end
				l_col_index := l_col_index + 1
			end
		ensure
			same_row_labels: Result implies row_labels.is_same (a_other.row_labels)
			same_column_labels: Result implies column_labels.is_same (a_other.column_labels)
		end

	are_all_fields_independent: BOOLEAN
			-- Are all fields indenpendent, so that changing one won't change the other?
		do
			Result := underlying_matrix.are_all_fields_independent
		end

feature -- Copy Operations

	copy_values_into (a_target: AL_MATRIX)
			-- Copy the current matrix into `a_target', only the values.
		require
			same_size: a_target.width = width and a_target.height = height
			no_aliasing: a_target.underlying_matrix /= underlying_matrix
			field_independent: a_target.are_all_fields_independent
		local
			l_column_index, l_row_index: INTEGER
		do
			from
				l_column_index := 1
			until
				l_column_index > width
			loop
				from
					l_row_index := 1
				until
					l_row_index > height
				loop
					a_target.put (item (l_row_index, l_column_index), l_row_index, l_column_index)
					l_row_index := l_row_index + 1
				end
				l_column_index := l_column_index + 1
			end
		end

	multiply_into (a_second, a_target: AL_MATRIX)
			-- Multiply `Current' by `a_second', storing the results in `a_target'.
		require
			can_multiply: width = a_second.height
			target_width_ok: a_target.width = a_second.width
			target_height_ok: a_target.height = height
			no_aliasing_with_me: a_target.underlying_matrix /= underlying_matrix
			no_aliasing_with_second: a_target.underlying_matrix /= a_second.underlying_matrix
			field_independent: a_target.are_all_fields_independent
		local
			l_width, l_height, l_depth: INTEGER
			l_block_i, l_block_j, l_block_k: INTEGER
			l_block_end_i, l_block_end_j, l_block_end_k: INTEGER
			l_i, l_j, l_k: INTEGER
			l_sum: DOUBLE
		do
			l_width := a_target.width
			l_height := a_target.height
			l_depth := width
			a_target.fill (0.0)
			from
				l_block_i := 1
			until
				l_block_i > l_width
			loop
				l_block_end_i := l_width.min (l_block_i + block_size - 1)
				from
					l_block_j := 1
				until
					l_block_j > l_height
				loop
					l_block_end_j := l_height.min (l_block_j + block_size - 1)
					from
						l_block_k := 1
					until
						l_block_k > l_depth
					loop
						l_block_end_k := l_depth.min (l_block_k + block_size - 1)
						from
							l_i := l_block_i
						until
							l_i > l_block_end_i
						loop
							from
								l_j := l_block_j
							until
								l_j > l_block_end_j
							loop
								l_sum := a_target.item (l_j, l_i)
								from
									l_k := l_block_k
								until
									l_k > l_block_end_k
								loop
									l_sum := l_sum + item (l_j, l_k) * a_second.item (l_k, l_i)
									l_k := l_k + 1
								end
								a_target.put (l_sum, l_j, l_i)
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

	transpose_into (a_target: AL_MATRIX)
			-- Write a transposed version of `Current' into `a_target'.
		require
			right_size: a_target.width = height and a_target.height = width
			no_aliasing: a_target.underlying_matrix /= underlying_matrix
			field_independent: a_target.are_all_fields_independent
		local
			l_column_index, l_row_index: INTEGER
		do
			from
				l_column_index := 1
			until
				l_column_index > width
			loop
				from
					l_row_index := 1
				until
					l_row_index > height
				loop
					a_target.put (item (l_row_index, l_column_index), l_column_index, l_row_index)
					l_row_index := l_row_index + 1
				end
				l_column_index := l_column_index + 1
			end
		end

	ata_into (a_target: AL_MATRIX)
			-- Compute ATA (transpose by self) and store result into `a_target'
		require
			target_width_ok: a_target.width = width
			target_height_ok: a_target.height = width
			no_aliasing_with_me: a_target.underlying_matrix /= underlying_matrix
			field_independent: a_target.are_all_fields_independent
		do
			transposed.multiply_into (Current, a_target)
		end

feature -- Operations

	put (a_value: DOUBLE; a_row, a_column: INTEGER)
			-- Store `a_value' at `a_row' and `a_column'.
		require
			valid_row: is_valid_row (a_row)
			valid_column: is_valid_column (a_column)
		deferred
		ensure
			value_set: item (a_row, a_column) = a_value
		end

	fill (a_value: DOUBLE)
			-- Fill all elements of the matrix with `a_value'.
		local
			l_row_index, l_column_index: INTEGER
		do
			from
				l_column_index := 1
			until
				l_column_index > width
			loop
				from
					l_row_index := 1
				until
					l_row_index > height
				loop
					put (a_value, l_row_index, l_column_index)
					l_row_index := l_row_index + 1
				end
				l_column_index := l_column_index + 1
			end
		end

feature -- Label operations

	set_default_labels
			-- Set default row and column labels (for all unset labels)
		do
			column_labels.set_default ("column")
			row_labels.set_default ("row")
		end

feature {NONE} -- Internal

	frozen block_size: INTEGER = 32
		-- Block size for faster matrix multiplication

end
note
	description: "[
		Factory class for the ALGEA library
		
		Classes in the ALGEA library should not be instanciated directly, but instead always
		though this class
	]"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_FACTORY

inherit
	AL_INTERNAL
	AL_ARRAY_MATRIX_SUPPORT
	AL_MAP_SUPPORT
	AL_DOUBLE_HANDLER

create {ALGAE_USER}
	make

feature -- Initialisation

	make
			-- Initialise the factory
		do
			initialize_double_handling
		end

feature -- Matrices

	matrix (a_height, a_width: INTEGER): AL_REAL_MATRIX
			-- A new dense matrix of size `a_height' x `a_width', filled with 0.0
		require
			positive_height: a_height >= 0
			positive_width: a_width >= 0
		do
			create {AL_DENSE_MATRIX} Result.make (a_height, a_width, 0.0)
			Result.initialize_double_handling_from (Current)
		end

	matrix_filled (a_height, a_width: INTEGER; a_value: DOUBLE): AL_REAL_MATRIX
			-- A new dense matrix of size `a_height' x `a_width', filled with `a_value'
		require
			positive_height: a_height >= 0
			positive_width: a_width >= 0
		do
			create {AL_DENSE_MATRIX} Result.make (a_height, a_width, a_value)
			Result.initialize_double_handling_from (Current)
		end

	symmetric_matrix (a_size: INTEGER): AL_REAL_MATRIX
			-- A new symmetric matrix of size `a_size', filled with 0.0
		require
			positive_size: a_size >= 0
		do
			create {AL_SYMMETRIC_MATRIX} Result.make (a_size, 0.0)
			Result.initialize_double_handling_from (Current)
		end

	symmetric_matrix_filled (a_size: INTEGER; a_value: DOUBLE): AL_REAL_MATRIX
			-- A new symmetric matrix of size `a_size', filled with `a_value'
		require
			positive_size: a_size >= 0
		do
			create {AL_SYMMETRIC_MATRIX} Result.make (a_size, a_value)
			Result.initialize_double_handling_from (Current)
		end

	vector (a_size: INTEGER): AL_VECTOR
			-- A new vector of `a_size', represented by a vertical matrix of width 1, filled by 0.0
		require
			positive_size: a_size >= 0
		do
			Result := vector_filled (a_size, 0.0)
		end

	vector_filled (a_size: INTEGER; a_value: DOUBLE): AL_VECTOR
			-- A new vector of `a_size', represented by a vertical matrix of width 1, filled by `a_value'
		require
			positive_size: a_size >= 0
		local
			l_matrix: AL_DENSE_MATRIX
		do
			create l_matrix.make (a_size, 1, a_value)
			l_matrix.initialize_double_handling_from (Current)
			Result := l_matrix.column (1)
		end

	array_matrix (a_array: ARRAY [ARRAY [DOUBLE]]): AL_REAL_MATRIX
			-- A new array matrix that sits on top of `a_array'
			-- CAUTION:
			-- This assumes that all inner arrays are of the same length, and the
			-- implementation will not check that this property is maintained. If
			-- you do change the structure or size of the array at any time, the
			-- behavior of this matrix is undefined.
		require
			valid_array: is_valid_array_matrix (a_array)
		do
			create {AL_ARRAY_MATRIX} Result.make (a_array)
			Result.initialize_double_handling_from (Current)
		end

	linear_map (a_count, a_target_count, a_offset: INTEGER): AL_MAP
			-- A new map of `a_count' elements where to target are between 1..a_target_count,
			-- filled with a linear increasing list between `a_offset' and `a_offset' + `a_count' - 1
		require
			count_positive: a_count >= 0
			target_positive: a_target_count >= 0
			offset_positive: a_offset >= 0
			count_and_offset_smaller_target: a_count + a_offset - 1 <= a_target_count
		do
			create {AL_MAP} Result.make (a_count, a_target_count, a_offset)
		end

	map_from_array (a_array: ARRAY [INTEGER]; a_target_count: INTEGER): AL_MAP
			-- A new map of `a_count' elements where to target filled with values in `a_array', of where target
			-- domain is of size `a_target_size'
		require
			target_positive: a_target_count >= 0
			valid_array: is_valid_map (a_array, a_target_count)
		do
			create {AL_MAP} Result.make_from_array (a_array, a_target_count)
		end

feature -- Builders

	new_horizontal_builder: AL_MATRIX_BUILDER
			-- A new horizontal builder
		do
			create {AL_HORIZONTAL_MATRIX_BUILDER} Result.make
		end

	new_vertical_builder: AL_MATRIX_BUILDER
			-- A new vertical builder
		do
			create {AL_VERTICAL_MATRIX_BUILDER} Result.make
		end

end

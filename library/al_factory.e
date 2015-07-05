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

feature -- Matrices

	matrix (a_height, a_width: INTEGER): AL_REAL_MATRIX
			-- A new dense matrix of size `a_height' x `a_width', filled with 0.0
		require
			positive_height: a_height >= 0
			positive_width: a_width >= 0
		do
			create {AL_DENSE_MATRIX} Result.make (a_height, a_width, 0.0)
		end

	matrix_filled (a_height, a_width: INTEGER; a_value: DOUBLE): AL_REAL_MATRIX
			-- A new dense matrix of size `a_height' x `a_width', filled with `a_value'
		require
			positive_height: a_height >= 0
			positive_width: a_width >= 0
		do
			create {AL_DENSE_MATRIX} Result.make (a_height, a_width, a_value)
		end

	symmetric_matrix (a_size: INTEGER): AL_REAL_MATRIX
			-- A new symmetric matrix of size `a_size', filled with 0.0
		require
			positive_size: a_size >= 0
		do
			create {AL_SYMMETRIC_MATRIX} Result.make (a_size, 0.0)
		end

	symmetric_matrix_filled (a_size: INTEGER; a_value: DOUBLE): AL_REAL_MATRIX
			-- A new symmetric matrix of size `a_size', filled with `a_value'
		require
			positive_size: a_size >= 0
		do
			create {AL_SYMMETRIC_MATRIX} Result.make (a_size, a_value)
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

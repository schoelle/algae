note
	description: "Standard constants for running benchmarks"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	BENCHMARK_CONSTANTS

inherit
	ALGAE_USER

feature -- Constants

	default_large_size: INTEGER = 5000
			-- Default size for a large matrix

	default_medium_size: INTEGER = 1000
			-- Default size for a large matrix

	default_small_size: INTEGER = 100
			-- Default size for a large matrix

feature -- Example Matrices

	new_random_matrix (a_height, a_width: INTEGER): AL_REAL_MATRIX
			-- Create a new matrix with random data (0-1)
		local
			l_random: RANDOM
		do
			Result := al.matrix (a_height, a_width)
			create l_random.set_seed (a_height * a_width)
			across
				Result.column_by_column as  l_cursor
			loop
				l_cursor.put (l_random.double_i_th (l_cursor.index))
			end
		end

	new_random_symmetric_matrix (a_size: INTEGER): AL_REAL_MATRIX
			-- Create a new symmetric matrix with random data (0-1)
		local
			l_random: RANDOM
		do
			Result := al.symmetric_matrix (a_size)
			create l_random.set_seed (a_size)
			across
				Result.column_by_column as  l_cursor
			loop
				l_cursor.put (l_random.double_i_th (l_cursor.index))
			end
		end

	new_random_partial_matrix (a_height, a_width: INTEGER): AL_MATRIX
			-- Create a new partial matrix with random data (0-1)
		do
			Result := new_random_matrix (a_height + 2, a_width + 2).area (2, 2, a_height + 1, a_width + 1)
		end

	new_small_matrix: AL_REAL_MATRIX
			-- A small matrix with many rows, but only limited number of columns
		do
			Result := new_random_matrix (default_small_size * 2, default_small_size // 2)
		end

	new_medium_matrix: AL_REAL_MATRIX
			-- A medium matrix with many rows, but only limited number of columns
		do
			Result := new_random_matrix (default_medium_size * 2, default_medium_size // 2)
		end

	new_large_matrix: AL_REAL_MATRIX
			-- A large matrix with many rows, but only limited number of columns
		do
			Result := new_random_matrix (default_large_size * 2, default_large_size // 2)
		end

	new_small_square_matrix: AL_REAL_MATRIX
			-- A small square matrix
		do
			Result := new_random_matrix (default_small_size, default_small_size)
		end

	new_medium_square_matrix: AL_REAL_MATRIX
			-- A medium square matrix
		do
			Result := new_random_matrix (default_medium_size, default_medium_size)
		end

	new_large_square_matrix: AL_REAL_MATRIX
			-- A large square matrix
		do
			Result := new_random_matrix (default_large_size, default_large_size)
		end

	new_small_symmetric_matrix: AL_REAL_MATRIX
			-- A small square matrix
		do
			Result := new_random_symmetric_matrix (default_small_size)
		end

	new_medium_symmetric_matrix: AL_REAL_MATRIX
			-- A medium square matrix
		do
			Result := new_random_symmetric_matrix (default_medium_size)
		end

	new_large_symmetric_matrix: AL_REAL_MATRIX
			-- A large square matrix
		do
			Result := new_random_symmetric_matrix (default_large_size)
		end

	new_small_partial_matrix: AL_MATRIX
			-- A small partial matrix with many rows, but only limited number of columns
		do
			Result := new_random_partial_matrix (default_small_size * 2, default_small_size // 2)
		end

	new_medium_partial_matrix: AL_MATRIX
			-- A medium partial matrix with many rows, but only limited number of columns
		do
			Result := new_random_partial_matrix (default_medium_size * 2, default_medium_size // 2)
		end

	new_large_partial_matrix: AL_MATRIX
			-- A large partial matrix with many rows, but only limited number of columns
		do
			Result := new_random_partial_matrix (default_large_size * 2, default_large_size // 2)
		end

	new_small_partial_square_matrix: AL_MATRIX
			-- A small partial square matrix
		do
			Result := new_random_partial_matrix (default_small_size, default_small_size)
		end

	new_medium_partial_square_matrix: AL_MATRIX
			-- A medium partial square matrix
		do
			Result := new_random_partial_matrix (default_medium_size, default_medium_size)
		end

	new_large_partial_square_matrix: AL_MATRIX
			-- A large partial square matrix
		do
			Result := new_random_partial_matrix (default_large_size, default_large_size)
		end

feature -- Once containers

	multiplier: CELL [INTEGER]
			-- Multiplier configuration
		once
			create Result.put (1)
		end

	domain: CELL [detachable STRING]
			-- Domain to run (Void = all)
		once
			create Result.put (Void)
		end

	test: CELL [detachable STRING]
			-- Test to run (Void = all)
		once
			create Result.put (Void)
		end

end

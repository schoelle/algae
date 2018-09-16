note
	description: "Matrix testing support"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	MATRIX_TEST_SUPPORT

inherit
	ALGAE_USER

feature -- Support

	new_matrix: AL_MATRIX
			-- Create a new 3x2 matrix
		do
			Result := al.matrix (3, 2)
			Result [1,1] := 2.0
			Result [2,1] := 3.0
			Result [3,1] := 4.0
			Result [1,2] := 1.5
			Result [2,2] := 2.5
			Result [3,2] := 3.5
		end

	new_array_matrix: AL_MATRIX
			-- Create a new 3x2 array matrix
		do
			Result := al.array_matrix (<< << 2.0, 1.5 >>,
										  << 3.0, 2.5 >>,
										  << 4.0, 3.5 >> >>)
		end

	new_square_matrix: AL_MATRIX
			-- Create a new 3x3 matrix
		do
			Result := al.matrix (3, 3)
			Result [1,1] := 2.0
			Result [2,1] := 3.0
			Result [3,1] := 4.0
			Result [1,2] := 1.5
			Result [2,2] := 2.5
			Result [3,2] := 3.5
			Result [1,3] := 1.0
			Result [2,3] := 2.0
			Result [3,3] := 3.0
		end

	new_square_array_matrix: AL_MATRIX
			-- Create a new 3x3 array matrix
		do
			Result := al.array_matrix (<< << 2.0, 1.5, 1.0 >>,
										  << 3.0, 2.5, 2.0 >>,
										  << 4.0, 3.5, 3.0 >> >>)
		end

	new_symmetric_matrix: AL_MATRIX
			-- Create a new 3x3 matrix
		do
			Result := al.symmetric_matrix (3)
			Result [1,1] := 2.0
			Result [2,1] := 3.0
			Result [3,1] := 4.0
			Result [2,2] := 5.0
			Result [2,3] := 6.0
			Result [3,3] := 7.0
		end

	new_vector: AL_VECTOR
			-- Create a 1-dimentional matrix an a vector on it
		local
			m: AL_MATRIX
		do
			m := al.matrix (2, 2)
			Result := m.column_by_column
			Result [1] := 3.0
			Result [2] := 9.0
			Result [3] := 2.0
			Result [4] := 8.0
		end

end

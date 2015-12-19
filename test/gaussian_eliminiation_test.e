note
	description: "Test AL_GAUSSIAN_ELIMINATION"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"
	testing: "type/manual"

class
	GAUSSIAN_ELIMINIATION_TEST

inherit
	EQA_TEST_SET
	MATRIX_TEST_SUPPORT
		undefine
			default_create
		end

feature -- Testing

	test_elimination
			-- Test elimination
		local
			l_in: AL_MATRIX
			l_out: AL_MATRIX
			l_algo: AL_GAUSSIAN_ELIMINATION
		do
			l_in := al.array_matrix (<< << 1.0, 3.0, 1.0 >>, << 1.0, 1.0, -1.0 >>, << 3.0, 11.0, 5.0 >> >>)
			l_out := al.array_matrix (<< << 9.0 >>, << 1.0 >>, << 35.0 >> >>)
			create l_algo.make (l_in.to_real)
			l_algo.set_output (l_out.to_real)
			l_algo.eliminate
			assert ("lower_row_zero", l_algo.input.row (3).min = 0.0 and l_algo.input.row (3).max = 0.0)
			assert ("zero_second_row", l_algo.input[2, 1] = 0.0)
		end

	test_solve_equation
			-- Test solving equations using gaussian elimination
		local
			l_in: AL_MATRIX
			l_out: AL_MATRIX
			l_algo: AL_GAUSSIAN_ELIMINATION
		do
			l_in := al.array_matrix (<< << 2.0, 4.0, 3.0 >>, << 1.0, 1.0, 5.0 >>, << 8.0, 0.0, 1.0 >> >>)
			l_out := al.array_matrix (<< << 10.0 >>, << 13.0 >>, << 34.0 >> >>)
			create l_algo.make (l_in.to_dense)
			l_algo.set_output (l_out.to_dense)
			l_algo.solve
			l_algo.output.column_by_column.round_all
			assert ("success", l_algo.last_successful)
			assert ("value1", l_algo.output[1,1] = 4.0)
			assert ("value2", l_algo.output[2,1] = -1.0)
			assert ("value3", l_algo.output[3,1] = 2.0)
		end

	test_inversion
			-- Test inversion using gaussian elimination
		local
			l_in: AL_MATRIX
			l_algo: AL_GAUSSIAN_ELIMINATION
		do
			l_in := al.array_matrix (<< << 2.0, -1.0, 0.0 >>, << -1.0, 2.0, -1.0 >>, << 0.0, -1.0, 2.0 >> >>).as_dense
			create l_algo.make (l_in.to_dense)
			l_algo.solve
			l_algo.output.column_by_column.round_all

			assert ("success", l_algo.last_successful)
			assert ("input_is_unit", l_algo.input.is_unit)
			assert ("output1", l_algo.output[1,1] = 0.75)
			assert ("output2", l_algo.output[1,2] = 0.5)
			assert ("output3", l_algo.output[1,3] = 0.25)
			assert ("output4", l_algo.output[2,1] = 0.5)
			assert ("output5", l_algo.output[2,2] = 1.0)
			assert ("output6", l_algo.output[2,3] = 0.5)
			assert ("output7", l_algo.output[3,1] = 0.25)
			assert ("output8", l_algo.output[3,2] = 0.5)
			assert ("output9", l_algo.output[3,3] = 0.75)
			assert ("is_inverse", l_in.times (l_algo.output).is_unit)
		end

end

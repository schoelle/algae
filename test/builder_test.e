note
	description: "Tests for AL_MATRIX_BUILDER subclasses"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"
	testing: "type/manual"

class
	BUILDER_TEST

inherit
	EQA_TEST_SET
	MATRIX_TEST_SUPPORT
		undefine
			default_create
		end

feature -- Horizontal Builder

	test_build_horizontal
			-- Test horizontal building of a matrix
		local
			b: AL_MATRIX_BUILDER
			m, n: AL_MATRIX
			v: AL_VECTOR
		do
			m := al.matrix (2, 2)
			m.column_by_column.set_all (<< -1, -2, -3, -4 >>)
			v := m.row (1)
			b := al.new_horizontal_builder
			b.add_array (<< 1, 2 >>)
			b.add_matrix (m)
			b.add_vector (v)
			b.add_array (<< 4, 5 >>)
			n := b.item
			assert ("width_ok", n.width = 5)
			assert ("height_ok", n.height = 2)
			assert ("value_ok1", n [1, 1] = 1)
			assert ("value_ok2", n [2, 1] = 2)
			assert ("value_ok3", n [1, 2] = -1)
			assert ("value_ok4", n [2, 2] = -2)
			assert ("value_ok5", n [1, 3] = -3)
			assert ("value_ok6", n [2, 3] = -4)
			assert ("value_ok7", n [1, 4] = -1)
			assert ("value_ok8", n [2, 4] = -3)
			assert ("value_ok9", n [1, 5] = 4)
			assert ("value_ok10", n [2, 5] = 5)
		end

	test_build_vertical
			-- Test vertical building of a matrix
		local
			b: AL_MATRIX_BUILDER
			m, n: AL_MATRIX
			v: AL_VECTOR
		do
			m := al.matrix (2, 2)
			m.column_by_column.set_all (<< -1, -2, -3, -4 >>)
			v := m.column (1)
			b := al.new_vertical_builder
			b.add_array (<< 1, 2 >>)
			b.add_matrix (m)
			b.add_vector (v)
			b.add_array (<< 4, 5 >>)
			n := b.item
			assert ("width_ok", n.width = 2)
			assert ("height_ok", n.height = 5)
			assert ("value_ok1", n [1, 1] = 1)
			assert ("value_ok2", n [2, 1] = -1)
			assert ("value_ok3", n [3, 1] = -2)
			assert ("value_ok4", n [4, 1] = -1)
			assert ("value_ok5", n [5, 1] = 4)
			assert ("value_ok6", n [1, 2] = 2)
			assert ("value_ok7", n [2, 2] = -3)
			assert ("value_ok8", n [3, 2] = -4)
			assert ("value_ok9", n [4, 2] = -2)
			assert ("value_ok10", n [5, 2] = 5)
		end


end

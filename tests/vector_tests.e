note
	description: "Eiffel tests that can be executed by testing tool."
	author: "EiffelStudio test wizard"
	license: "Eiffel Forum License, Version 2"
	testing: "type/manual"

class
	VECTOR_TESTS

inherit
	EQA_TEST_SET
	MATRIX_TEST_SUPPORT
		undefine
			default_create
		end

feature -- Test routines

	test_underlying_matrix
			-- Test underlying matrix of vector
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_matrix
			v := m.column (1)
			assert ("underlying", v.underlying_matrix = m.underlying_matrix)
		end

	test_item
			-- Test item
		local
			v: AL_VECTOR
		do
			v := new_vector
			assert ("item_ok1", v [1] = 3.0)
			assert ("item_ok2", v [2] = 9.0)
			assert ("item_ok3", v [3] = 2.0)
			assert ("item_ok4", v [4] = 8.0)
		end

	test_name
			-- Test name
		local
			v: AL_VECTOR
		do
			v := new_vector
			assert ("name_ok1", v.name = Void)
			v.set_name ("A")
			assert ("name_ok2", v.name ~ "A")
		end

	test_labels
			-- Test labels
		local
			m: AL_MATRIX
			v: AL_VECTOR
			l: AL_LABELS
		do
			m := new_matrix
			v := m.row (2)
			l := v.labels
			m.set_default_labels
			assert ("count_ok", l.count = 2)
			assert ("item_ok1", l [1] ~ "column1")
			assert ("item_ok2", l [2] ~ "column2")
		end

	test_cursor
			-- Test the cursor of a vector
		local
			v: AL_VECTOR
			c: AL_VECTOR_CURSOR
		do
			v := new_vector
			c := v.new_cursor
			assert ("item_ok1", c.item = 3.0)
			assert ("index_ok1", c.index = 1)
			assert ("row_ok1", c.row = 1)
			assert ("column_ok1", c.column = 1)
			c.forth
			assert ("item_ok2", c.item = 9.0)
			assert ("index_ok2", c.index = 2)
			assert ("row_ok2", c.row = 2)
			assert ("column_ok2", c.column = 1)
			c.forth
			assert ("item_ok3", c.item = 2.0)
			assert ("index_ok3", c.index = 3)
			assert ("row_ok3", c.row = 1)
			assert ("column_ok3", c.column = 2)
			c.forth
			assert ("item_ok4", c.item = 8.0)
			assert ("index_ok4", c.index = 4)
			assert ("row_ok4", c.row = 2)
			assert ("column_ok4", c.column = 2)
			c.forth
			assert ("after", c.after)
		end

	test_row_and_column_for_index
			-- Test lookup of row
		local
			v: AL_VECTOR
		do
			v := new_vector
			assert ("row_ok1", v.row_for_index (1) = 1)
			assert ("column_ok1", v.column_for_index (1) = 1)
			assert ("row_ok2", v.row_for_index (2) = 2)
			assert ("column_ok2", v.column_for_index (2) = 1)
			assert ("row_ok3", v.row_for_index (3) = 1)
			assert ("column_ok3", v.column_for_index (3) = 2)
			assert ("row_ok4", v.row_for_index (4) = 2)
			assert ("column_ok4", v.column_for_index (4) = 2)
		end

	test_matrix
			-- Test matrix of vector
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_matrix
			v := m.column (1)
			assert ("matrix", v.matrix = m)
		end

	test_to_array
			-- Test transformation to array
		local
			v: AL_VECTOR
			a: ARRAY [DOUBLE]
		do
			v := new_vector
			a := v.to_array
			assert ("right_lower", a.lower = 1)
			assert ("right_upper", a.upper = 4)
			assert ("value_ok1", a [1] = 3.0)
			assert ("value_ok2", a [2] = 9.0)
			assert ("value_ok3", a [3] = 2.0)
			assert ("value_ok4", a [4] = 8.0)
		end

	test_count
			-- Test count of matrix
		local
			v: AL_VECTOR
		do
			v := new_vector
			assert ("count_ok", v.count = 4)
		end

	test_statistics
			-- Test the different statistics functions
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			v := new_vector
			assert ("min_ok1", v.min = 2.0)
			assert ("max_ok1", v.max = 9.0)
			assert ("min_index_ok1", v.min_index = 3)
			assert ("max_index_ok1", v.max_index = 2)
			assert ("mean_ok1", v.mean = 5.5)
			assert ("sum_ok1", v.sum = 22.0)
			assert ("median_ok1", v.median = 5.5)
			m := al.array_matrix (<< << 2.0, 9.0, 4.0, 5.0, 9.0, 1.0 >> >>)
			v := m.row (1)
			assert ("min_ok2", v.min = 1.0)
			assert ("max_ok2", v.max = 9.0)
			assert ("min_index_ok1", v.min_index = 6)
			assert ("max_index_ok1", v.max_index = 2)
			assert ("mean_ok2", v.mean = 5.0)
			assert ("sum_ok2", v.sum = 30.0)
			assert ("median_ok2", v.median = 4.5)
			m := al.array_matrix (<< << 7.0 >> >>)
			v := m.row (1)
			assert ("min_ok3", v.min = 7.0)
			assert ("max_ok3", v.max = 7.0)
			assert ("min_index_ok1", v.min_index = 1)
			assert ("max_index_ok1", v.max_index = 1)
			assert ("mean_ok3", v.mean = 7.0)
			assert ("sum_ok3", v.sum = 7.0)
			assert ("median_ok3", v.median = 7.0)
		end

	test_mode
			-- Test the mode function
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := al.array_matrix (<< << 2.0, 9.0, 2.0, 5.0, 9.0, 1.0 >> >>)
			v := m.row (1)
			assert ("mode_ok1", v.mode = 2.0)
			m := al.array_matrix (<< << 3.0 >> >>)
			v := m.row (1)
			assert ("mode_ok2", v.mode = 3.0)
			m := al.array_matrix (<< << 9.0, 9.0, 8.0, 8.0, 9.0, 8.0, 9.0 >> >>)
			v := m.row (1)
			assert ("mode_ok3", v.mode = 9.0)
		end

	test_times
			-- Test the different statistics functions
		local
			v, w: AL_VECTOR
		do
			v := new_vector
			w := al.matrix (4, 1).column (1)
			w [1] := 2.0
			w [2] := 3.0
			w [3] := -1.0
			w [4] := -2.0
			assert ("times_ok", v.times (w) = 15.0)
		end

	test_set_all
			-- Test setting a vector to an array
		local
			v: AL_VECTOR
		do
			v := new_vector
			v.set_all_array ( << 1.0, 2.0, 3.0, 4.0 >> )
			assert ("item_ok1", v [1] = 1.0)
			assert ("item_ok2", v [2] = 2.0)
			assert ("item_ok3", v [3] = 3.0)
			assert ("item_ok4", v [4] = 4.0)
		end

	test_fill
			-- Test filling a vector
		local
			v: AL_VECTOR
		do
			v := new_vector
			v.fill (11.0)
			assert ("item_ok1", v [1] = 11.0)
			assert ("item_ok2", v [2] = 11.0)
			assert ("item_ok3", v [3] = 11.0)
			assert ("item_ok4", v [4] = 11.0)
		end

	test_fill_sequence
			-- Test filling a vector with a sequence
		local
			v: AL_VECTOR
		do
			v := new_vector
			v.fill_sequence (11.0, 0.5)
			assert ("item_ok1", v [1] = 11.0)
			assert ("item_ok2", v [2] = 11.5)
			assert ("item_ok3", v [3] = 12.0)
			assert ("item_ok4", v [4] = 12.5)
		end

	test_scale
			-- Test scaling a vector
		local
			v: AL_VECTOR
		do
			v := new_vector
			v.scale (-2.0)
			assert ("item_ok1", v [1] = -6)
			assert ("item_ok2", v [2] = -18)
			assert ("item_ok3", v [3] = -4)
			assert ("item_ok4", v [4] = -16)
		end

	test_multiply
			-- Test vector multiplication
		local
			v, w: AL_VECTOR
		do
			v := new_vector
			w := al.matrix (4, 1).column (1)
			w [1] := 2.0
			w [2] := 3.0
			w [3] := -1.0
			w [4] := -2.0
			v.multiply (w)
			assert ("item_ok1", v [1] = 6.0)
			assert ("item_ok2", v [2] = 27.0)
			assert ("item_ok3", v [3] = -2.0)
			assert ("item_ok4", v [4] = -16.0)
		end

	test_add
			-- Test adding a constant
		local
			v: AL_VECTOR
		do
			v := new_vector
			v.add (-2.0)
			assert ("item_ok1", v [1] = 1.0)
			assert ("item_ok2", v [2] = 7.0)
			assert ("item_ok3", v [3] = 0.0)
			assert ("item_ok4", v [4] = 6.0)
		end

	test_add_vector
			-- Test adding a vector
		local
			v, w: AL_VECTOR
		do
			v := new_vector
			w := al.matrix (4, 1).column (1)
			w [1] := 2.0
			w [2] := 3.0
			w [3] := -1.0
			w [4] := -2.0
			v.add_vector (w)
			assert ("item_ok1", v [1] = 5.0)
			assert ("item_ok2", v [2] = 12.0)
			assert ("item_ok3", v [3] = 1.0)
			assert ("item_ok4", v [4] = 6.0)
		end

	test_add_scaled_vector
			-- Test adding a scaled vector
		local
			v, w: AL_VECTOR
		do
			v := new_vector
			w := al.vector (4)
			w [1] := 2.0
			w [2] := 3.0
			w [3] := -1.0
			w [4] := -2.0
			v.add_scaled_vector (w, 3.0)
			assert ("item_ok1", v [1] = 9.0)
			assert ("item_ok2", v [2] = 18.0)
			assert ("item_ok3", v [3] = -1.0)
			assert ("item_ok4", v [4] = 2.0)
		end

	test_new_vector
			-- Test creating a stand-alone vector
		local
			v: AL_VECTOR
		do
			v := al.vector (10)
			v.fill (1.0)
			assert ("fill_ok", v.sum = 10.0)
		end

	test_new_filled_vector
			-- Test creating a stand-alone vector
		local
			v: AL_VECTOR
		do
			v := al.vector_filled (6, 2.0)
			assert ("fill_ok", v.sum = 12.0)
		end

	test_is_same
			-- Test comparison
		local
			v, w: AL_VECTOR
		do
			v := new_vector
			w := new_vector
			assert ("same1", v.is_same (w))
			w.set_name ("foo")
			assert ("not_same1", not v.is_same (w))
			v.set_name ("foo")
			assert ("same2", v.is_same (w))
			w.labels.put ("bla", 1)
			assert ("not_same2", not v.is_same (w))
			v.labels.put ("bla", 1)
			assert ("same3", v.is_same (w))
			v.put (33.0, 3)
			assert ("not_same3", not v.is_same (w))
			w.put (33.0, 3)
			assert ("same4", v.is_same (w))
		end

end



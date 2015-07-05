note
	description: "Test surrounding AL_LABELS"
	author: "EiffelStudio test wizard"
	license: "Eiffel Forum License, Version 2"
	testing: "type/manual"

class
	LABELS_TESTS

inherit
	EQA_TEST_SET
	MATRIX_TEST_SUPPORT
		undefine
			default_create
		end

feature -- Test routines

	test_item
			-- Test item access
		local
			m: AL_MATRIX
			l: AL_LABELS
		do
			m := new_matrix
			l := m.row_labels
			m.set_default_labels
			assert ("item_ok1", l [1] ~ "row1")
			assert ("item_ok2", l.item (2) ~ "row2")
			assert ("item_ok3", l [3] ~ "row3")
		end

	test_cursor
			-- Test cursor operations
		local
			m: AL_MATRIX
			l: AL_LABELS
			c: AL_LABEL_CURSOR
		do
			m := new_matrix
			m.set_default_labels
			l := m.row_labels
			c := l.new_cursor
			assert ("item_ok1", c.item ~ "row1")
			assert ("index_ok1", c.index = 1)
			c.forth
			assert ("item_ok1", c.item ~ "row2")
			assert ("index_ok1", c.index = 2)
			c.forth
			assert ("item_ok1", c.item ~ "row3")
			assert ("index_ok1", c.index = 3)
			c.forth
			assert ("after", c.after)
		end

	test_underlying_matrix
			-- Test underlying matrix
		local
			m: AL_MATRIX
			l: AL_LABELS
		do
			m := new_matrix
			l := m.row_labels
			assert ("underlying_ok", m.underlying_matrix = l.underlying_matrix)
		end

	test_is_valid_index
			-- Test checking if something is a valid index
		local
			m: AL_MATRIX
			l: AL_LABELS
		do
			m := new_matrix
			l := m.row_labels
			assert ("too_small", not l.is_valid_index (0))
			assert ("small", l.is_valid_index (1))
			assert ("large", l.is_valid_index (3))
			assert ("too_large", not l.is_valid_index (4))
		end

	test_is_valid_label
			-- Test if something is a valid label
		local
			m, n: AL_MATRIX
			l: AL_LABELS
		do
			m := new_matrix
			n := m.area (2, 1, 3, 2)
			m.set_default_labels
			l := n.row_labels
			assert ("valid_ok1", l.is_valid_label ("unknown"))
			assert ("valid_ok2", l.is_valid_label ("row2"))
			assert ("not_valid", not l.is_valid_label ("row1"))
		end

	test_has
			-- Test has operation
		local
			l: AL_LABELS
		do
			l := new_matrix.row_labels
			l.put ("A", 2)
			l.put ("B", 3)
			assert ("has1", l.has ("A"))
			assert ("has2", l.has ("B"))
			assert ("not_has", not l.has ("C"))
		end

	test_all_labels_valid
			-- Test if all labels are valid
		local
			m, n: AL_MATRIX
			l, l2: AL_LABELS
		do
			m := new_matrix
			m.row_labels.set_default ("a")
			m.column_labels.set_default ("b")
			n := m.area (2, 1, 3, 2)
			l := n.row_labels
			l2 := n.column_labels
			assert ("valid", l.are_all_labels_valid (l2))
			m.column_labels.wipe_out
			m.column_labels.set_default ("a")
			assert ("not_valid", not l.are_all_labels_valid (l2))
		end

	test_index
			-- Test lookup by name
		local
			l: AL_LABELS
		do
			l := new_matrix.row_labels
			l [1] := "A"
			l [2] := "B"
			l [3] := "C"
			assert ("lookup1", l.index ("A") = 1)
			assert ("lookup2", l.index ("B") = 2)
			assert ("lookup3", l.index ("C") = 3)
		end

	test_to_array
			-- Test conversion to array
		local
			l: AL_LABELS
			a: ARRAY [detachable STRING]
		do
			l := new_matrix.row_labels
			l.set_default ("test")
			a := l.to_array
			assert ("count_ok", a.count = 3)
			assert ("item_ok1", a [1] ~ "test1")
			assert ("item_ok2", a [2] ~ "test2")
			assert ("item_ok3", a [3] ~ "test3")
		end

	test_copy_into
			-- Test copying into
		local
			m: AL_MATRIX
			l, l2: AL_LABELS
		do
			m := new_square_matrix
			l := m.row_labels
			l2 := m.column_labels
			l [1] := "A"
			l [2] := "B"
			l [3] := "C"
			l.copy_into (l2)
			assert ("item_ok1", l2 [1] ~ "A")
			assert ("item_ok2", l2 [2] ~ "B")
			assert ("item_ok3", l2 [3] ~ "C")
		end

	test_set_all
			-- Test setting all labels
		local
			m: AL_MATRIX
			l: AL_LABELS
		do
			m := new_matrix
			l := m.row_labels
			l.set_all (<< "a", "b", "c" >>)
			assert ("item_ok1", l [1] ~ "a")
			assert ("item_ok2", l [2] ~ "b")
			assert ("item_ok3", l [3] ~ "c")
		end

	test_wipe_out
			-- Test wipe out of all labels
		local
			l: AL_LABELS
		do
			l := new_matrix.row_labels
			l [1] := "A"
			l [2] := "B"
			l [3] := "C"
			l.wipe_out
			assert ("item_ok1", l [1] = Void)
			assert ("item_ok2", l [2] = Void)
			assert ("item_ok3", l [3] = Void)
		end

	test_set_default
			-- Test set default
		local
			l: AL_LABELS
		do
			l := new_matrix.row_labels
			l [2] := "B"
			l.set_default ("X")
			assert ("item_ok1", l [1] ~ "X1")
			assert ("item_ok2", l [2] ~ "B")
			assert ("item_ok3", l [3] ~ "X3")
		end

end



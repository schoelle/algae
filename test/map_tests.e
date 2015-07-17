note
	description: "Tests of the AL_MAP class"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"
	testing: "type/manual"

class
	MAP_TESTS

inherit
	EQA_TEST_SET
	MATRIX_TEST_SUPPORT
		undefine
			default_create
		end

feature -- Test creation

	test_make_linear
			-- Test creating from linear
		local
			m: AL_MAP
		do
			m := al.linear_map (5, 15, 5)
			assert ("count_ok", m.count = 5)
			assert ("target_count_ok", m.target_count = 15)
			assert ("ok1", m.item (1) = 5)
			assert ("ok2", m.item (2) = 6)
			assert ("ok3", m.item (3) = 7)
			assert ("ok4", m.item (4) = 8)
			assert ("ok5", m.item (5) = 9)
		end

	test_make_from_array
			-- Test creating from array
		local
			m: AL_MAP
		do
			m := al.map_from_array (<< 7,3,2,6 >>, 10)
			assert ("count_ok", m.count = 4)
			assert ("target_count_ok", m.target_count = 10)
			assert ("ok1", m.item (1) = 7)
			assert ("ok2", m.item (2) = 3)
			assert ("ok3", m.item (3) = 2)
			assert ("ok4", m.item (4) = 6)
		end

feature -- Access

	test_index_of
			-- Index of access
		local
			m: AL_MAP
		do
			m := al.map_from_array (<< 7,3,2,6 >>, 7)
			assert ("count_ok", m.count = 4)
			assert ("target_count_ok", m.target_count = 7)
			assert ("reverse1", m.index_of (1) = 0)
			assert ("reverse2", m.index_of (2) = 3)
			assert ("reverse3", m.index_of (3) = 2)
			assert ("reverse4", m.index_of (4) = 0)
			assert ("reverse5", m.index_of (5) = 0)
			assert ("reverse6", m.index_of (6) = 4)
			assert ("reverse7", m.index_of (7) = 1)
		end


feature -- Test status report

	test_is_complete
			-- Test `is_complete'
		local
			m: AL_MAP
		do
			m := al.map_from_array (<< 1,3,2,4 >>, 4)
			assert ("complete1", m.is_complete)
			m := al.map_from_array (<< 1,3,2,4 >>, 5)
			assert ("complete1", not m.is_complete)
		end

	test_has_target
			-- Test target testing
		local
			m: AL_MAP
		do
			m := al.map_from_array (<< 7,3,2,6 >>, 7)
			assert ("count_ok", m.count = 4)
			assert ("target_count_ok", m.target_count = 7)
			assert ("reverse1", not m.has_target (1))
			assert ("reverse2", m.has_target (2))
			assert ("reverse3", m.has_target (3))
			assert ("reverse4", not m.has_target (4))
			assert ("reverse5", not m.has_target (5))
			assert ("reverse6", m.has_target (6))
			assert ("reverse7", m.has_target (7))
		end

feature -- Test operations

	test_swap
			-- Test swapping elements
		local
			m: AL_MAP
		do
			m := al.linear_map (5, 15, 5)
			m.swap (1, 3)
			m.swap (2, 5)
			m.swap (5, 1)
			assert ("count_ok", m.count = 5)
			assert ("target_count_ok", m.target_count = 15)
			assert ("ok1", m.item (1) = 6)
			assert ("ok2", m.item (2) = 9)
			assert ("ok3", m.item (3) = 5)
			assert ("ok4", m.item (4) = 8)
			assert ("ok5", m.item (5) = 7)
		end

	test_put
			-- Test setting elements
		local
			m: AL_MAP
		do
			m := al.linear_map (5, 15, 5)
			m.put (15, 1)
			m.put (1, 5)
			m.put (7, 3)
			assert ("count_ok", m.count = 5)
			assert ("target_count_ok", m.target_count = 15)
			assert ("ok1", m.item (1) = 15)
			assert ("ok2", m.item (2) = 6)
			assert ("ok3", m.item (3) = 7)
			assert ("ok4", m.item (4) = 8)
			assert ("ok5", m.item (5) = 1)
		end

	test_reverse
			-- Test reverse a map
		local
			m: AL_MAP
		do
			m := al.linear_map (5, 15, 5)
			m.reverse
			assert ("count_ok", m.count = 5)
			assert ("target_count_ok", m.target_count = 15)
			assert ("ok1", m.item (1) = 9)
			assert ("ok2", m.item (2) = 8)
			assert ("ok3", m.item (3) = 7)
			assert ("ok4", m.item (4) = 6)
			assert ("ok5", m.item (5) = 5)
		end

	test_set_to_array
			-- Test setting to array
		local
			m: AL_MAP
		do
			m := al.linear_map (5, 15, 5)
			m.set_to_array (<< 1, 3, 15, 7, 2 >>)
			assert ("count_ok", m.count = 5)
			assert ("target_count_ok", m.target_count = 15)
			assert ("ok1", m.item (1) = 1)
			assert ("ok2", m.item (2) = 3)
			assert ("ok3", m.item (3) = 15)
			assert ("ok4", m.item (4) = 7)
			assert ("ok5", m.item (5) = 2)
		end

end

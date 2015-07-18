note
	description: "A mapping from the columns or rows of one matrix to another"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"


class
	AL_MAP

inherit
	AL_MAP_SUPPORT
		redefine
			out
		end

create {AL_INTERNAL}
	make,
	make_from_array

feature {NONE} -- Initialization

	make (a_count, a_target_count, a_offset: INTEGER)
			-- Initialize mapping of `a_count' elements to target `a_target_count',
			-- initializing it as a linear mapping starting at `a_offset'.
		require
			count_positive: a_count >= 0
			target_positive: a_target_count >= 0
			offset_positive: a_offset >= 0
			count_and_offset_smaller_target: a_count + a_offset - 1 <= a_target_count
		local
			l_index: INTEGER
		do
			target_count := a_target_count
			count := a_count
			create mapping.make_filled (0, a_count)
			create reverse_mapping.make_filled (0, a_target_count)
			from
				l_index := 0
			until
				l_index >= a_count
			loop
				mapping.put (l_index + a_offset, l_index)
				reverse_mapping.put (l_index + 1, l_index + a_offset - 1)
				l_index := l_index + 1
			end
		end

	make_from_array (a_array: ARRAY[INTEGER]; a_target_count: INTEGER)
			-- Initialize mapping using `a_array' for a target of count `a_target_count'.
		require
			target_positive: a_target_count >= 0
			valid_map: is_valid_map (a_array, a_target_count)
		do
			target_count := a_target_count
			count := a_array.count
			create mapping.make_filled (0, count)
			create reverse_mapping.make_filled (0, a_target_count)
			mapping.copy_data (a_array.area, 0, 0, count)
			recompute_reverse
		end

feature -- Access

	target_count: INTEGER
		-- Number of elements on the target

	count: INTEGER
		-- Size of the mapping

	item (a_index: INTEGER): INTEGER
			-- Item at index `a_index'
		require
			valid_index: is_valid_index (a_index)
		do
			Result := mapping [a_index - 1]
		end

	index_of (a_target: INTEGER): INTEGER
			-- Index of `a_target', or 0 if the target is not mapped
		require
			valid_target: is_valid_target (a_target)
		do
			Result := reverse_mapping [a_target - 1]
		end

feature -- Output

	out: STRING
			-- <Precursor>
		local
			l_index: INTEGER
		do
			Result := "["
			from
				l_index := 0
			until
				l_index >= count
			loop
				Result.append_integer (mapping[l_index])
				if l_index < count - 1 then
					Result.append (",")
				end
				l_index := l_index + 1
			end
			Result.append ("|")
			from
				l_index := 0
			until
				l_index >= target_count
			loop
				Result.append_integer (reverse_mapping[l_index])
				if l_index < target_count - 1 then
					Result.append (",")
				end
				l_index := l_index + 1
			end
			Result.append ("]")
		end

feature -- Status report

	is_complete: BOOLEAN
			-- Is this a complete map?
		do
			Result := count = target_count
		end

	has_target (a_target: INTEGER): BOOLEAN
			-- Does the mapping map to `a_target'?
		require
			valid_target: is_valid_target (a_target)
		do
			Result := reverse_mapping [a_target - 1] /= 0
		end

feature -- Operations

	swap (a_first, a_second: INTEGER)
			-- Swap `a_first' and `a_second'.
		require
			first_ok: is_valid_index (a_first)
			second_ok: is_valid_index (a_second)
		do
			internal_swap (a_first - 1, a_second - 1)
		end

	reverse
			-- Reverse the full map
		local
			l_index, l_half, l_end: INTEGER
		do
			from
				l_half := (count // 2)
				l_index := 0
				l_end := count - 1
			until
				l_index >= l_half
			loop
				internal_swap (l_index, l_end - l_index)
				l_index := l_index + 1
			end
		end

	put (a_target: INTEGER; a_index: INTEGER)
			-- Put `a_target' at `a_index'.
		require
			valid_index: is_valid_index (a_index)
			valid_target: is_valid_target (a_target)
			not_yet_or_same: not has_target (a_target) or else item (a_index) = a_target
		local
			l_current: INTEGER
		do
			l_current := item (a_index)
			if l_current = 0 then
				mapping [a_index - 1] := a_target
				reverse_mapping [a_target - 1] := a_index
			elseif l_current /= a_target then
				reverse_mapping [l_current - 1] := 0
				mapping [a_index - 1] := a_target
				reverse_mapping [a_target - 1] := a_index
			end
		end

	set_to_array (a_array: ARRAY [INTEGER])
			-- Set the mapping to `a_array'.
		require
			valid_mapping: is_valid_map (a_array, target_count)
		do
			mapping.copy_data (a_array.area, 0, 0, count)
			recompute_reverse
		end


feature -- Contract support

	is_valid_index (a_index: INTEGER): BOOLEAN
			-- Is `a_index' a valid index?
		do
			Result := a_index >= 1 and a_index <= count
		end

	is_valid_target (a_index: INTEGER): BOOLEAN
			-- Is `a_index' a valid index on the target?
		do
			Result := a_index >= 1 and a_index <= target_count
		end

feature {NONE} -- Implementation

	mapping: SPECIAL[INTEGER]
		-- Mapping to target

	reverse_mapping: SPECIAL[INTEGER]
		-- Mapping from target

	recompute_reverse
			-- Recompute the reverse mapping.
		local
			l_index: INTEGER
			l_target: INTEGER
		do
			reverse_mapping.fill_with (0, 0, target_count-1)
			from
				l_index := 0
			until
				l_index >= count
			loop
				l_target := mapping [l_index]
				reverse_mapping [l_target - 1] := l_index + 1
				l_index := l_index + 1
			end
		end

	internal_swap (a_first, a_second: INTEGER)
			-- Swap `a_first' and `a_second' (indexes start at 0).
		local
			l_first_target, l_second_target: INTEGER
		do
			if a_first /= a_second then
				l_first_target := mapping[a_first]
				l_second_target := mapping[a_second]
				mapping[a_first] := l_second_target
				mapping[a_second] := l_first_target
				reverse_mapping[l_first_target - 1] := a_second + 1
				reverse_mapping[l_second_target - 1] := a_first + 1
			end
		end

end

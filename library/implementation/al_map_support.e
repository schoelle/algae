note
	description: "Support feature for dealing with maps"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_MAP_SUPPORT

feature -- Contract Support

	is_valid_map (a_map: ARRAY[INTEGER]; a_count: INTEGER): BOOLEAN
			-- Is `a_map' a valid map, considering it maps into an index between 1 and `a_count' ?
		require
			positive_count: a_count > 0
		local
			l_reverse_map: ARRAY[BOOLEAN]
			l_index, l_map_index: INTEGER
		do
			if a_count >= a_map.count and a_map.lower = 1 then
				Result := True
				create l_reverse_map.make_filled (True, 1, a_count)
				from
					l_index := 1
				until
					l_index > a_map.count or not Result
				loop
					l_map_index := a_map.item (l_index)
					Result := l_reverse_map.item (l_map_index)
					l_reverse_map.put (False, l_map_index)
					l_index := l_index + 1
				end
			end
		end

end

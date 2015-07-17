note
	description: "A partial selection of labels from a MATRIX"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_PARTIAL_MATRIX_LABELS

inherit
	AL_LABELS
	AL_MAP_SUPPORT

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_labels: AL_LABELS; a_map: AL_MAP)
			-- Initialize as subsets of `a_labels', defined by `a_map'.
		require
			valid_map: a_map.target_count = a_labels.count
		do
			original_labels := a_labels
			map := a_map
		end

feature -- Access

	item alias "[]" (a_index: INTEGER): detachable STRING assign put
			-- <Precursor>
		do
			Result := original_labels.item (map.item (a_index))
		end

	underlying_matrix: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := original_labels.underlying_matrix
		end

feature -- Status report

	is_valid_label (a_label: detachable STRING): BOOLEAN
			-- <Precursor>
		do
			if attached a_label as l_label then
				Result := not original_labels.has (l_label) or else has (l_label)
			else
				Result := True
			end
		end

	has (a_label: STRING): BOOLEAN
			-- <Precursor>
		do
			Result := original_labels.has (a_label) and then map.index_of (original_labels.index (a_label)) > 0
		end

feature -- Measurement

	count: INTEGER
			-- <Precursor>
		do
			Result := map.count
		end

	index (a_label: STRING): INTEGER
			-- <Precursor>
		do
			Result := map.index_of (original_labels.index (a_label))
		end

feature -- Settors

	put (a_label: detachable STRING; a_index: INTEGER)
			-- <Precursor>
		do
			original_labels.put (a_label, map.item (a_index))
		end

feature {NONE} -- Implementation

	original_labels: AL_LABELS
		-- Labels we are a partial set of

	map: AL_MAP
		-- Mapping of values to `labels'

end

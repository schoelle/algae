note
	description: "A matrix that actually stores stuff, and is not just a view on top of some other matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_REAL_MATRIX

inherit
	AL_MATRIX
		redefine
			as_real,
			are_all_fields_independent
		end

feature -- Access

	underlying_matrix: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := Current
		ensure then
			definition: Result = Current
		end

feature -- Conversion

	as_real: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := Current
		ensure then
			definition: Result = Current
		end

feature -- Status report

	are_all_fields_independent: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

end

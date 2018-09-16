note
	description: "A class that handles double, mainly to provide tools to work around the float-point rouding problems"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_DOUBLE_HANDLER

feature -- Initialisation

	initialize_double_handling
			-- Initialises double handling.
		do
			-- This value is good for float points between -10.0 and 10.0
			epsilon := 0.0000000000000001
		end

	initialize_double_handling_from (a_handler: AL_DOUBLE_HANDLER)
			-- Initialises double handling, taking `a_handler' as reference.
		do
			epsilon := a_handler.epsilon
		end

feature -- Access

	epsilon: DOUBLE
		-- Two values are considered equal if the difference is smaller than epsilon

feature -- Status resport

	is_double_handling_initialised: BOOLEAN
			-- Has double handling been initialised?
		do
			Result := epsilon > 0
		end

feature -- Settings

	set_epsilon (a_value: DOUBLE)
			-- Set `epsilon' to `a_value'.
		require
			valid_value: a_value > 0
		do
			epsilon := a_value
		ensure
			set: epsilon = a_value
		end

feature -- Comparison

	same_double (a_first, a_second: DOUBLE): BOOLEAN
			-- Are `a_first' and `a_second' considered equivalent?
		require
			initialized: is_double_handling_initialised
		do
			if a_first > a_second then
				Result := (a_first - a_second) < epsilon
			else
				Result := (a_second - a_first) < epsilon
			end
		end

feature -- Adjustments

	round_double (a_double: DOUBLE): DOUBLE
			-- Rounded `a_double' according to precision
		require
			initialized: is_double_handling_initialised
		local
			l_value: DOUBLE
		do
			l_value := a_double / epsilon
			l_value := l_value.rounded_real_64
			Result := l_value * epsilon
		end

end

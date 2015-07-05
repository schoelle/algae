note
	description: "User of the ALGAE library"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	ALGAE_USER

feature -- Access

	al: AL_FACTORY
			-- Access to the ALGEA factory class
		once
			create Result
		end

end

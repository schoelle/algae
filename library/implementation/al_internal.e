note
	description: "[
		Access class to internal implementations of the ALGAE library
		
		DO NOT INHERIT FROM THIS CLASS! IF YOU ARE JUST A CLIENT OF ALGAE, YOU ARE PROBABLY DOING
		SOMETHING WRONG!
		
		I mean, really, the whole purpose of OO is to have nice and easy to use layers of abstraction.
		If you think you are inheriting from AL_INTERNAL, because you want to do something the type checker
		does not allow you to do, please think if there is another way to solve your problem.
		
		There are absolutely no guarantees from my side that at any time in the future, the interface you
		are facing will remain the same.
		
		Should you ever really need this access, you are implementing an extension to this library. Please
		then consider sending me a patch, and your code (or something that lets you do the same) might be
		in a new version of this library.
	]"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_INTERNAL

end

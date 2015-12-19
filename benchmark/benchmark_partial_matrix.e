note
	description: "Benchmark a partial matrix"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	BENCHMARK_PARTIAL_MATRIX

inherit
	BENCHMARK_USER
	BENCHMARK_CONSTANTS

feature -- Execution

	run
			-- Run the benchmark.
		do
			benchmark_aat
			benchmark_ata
			benchmark_fill
			benchmark_times
			benchmark_transposed
			benchmark_duplicated
			benchmark_csv
		end

feature -- Benchmark

	benchmark_aat
			-- Benchmark aat computation
		local
			m, n: AL_MATRIX
		do
			m := new_medium_partial_matrix
			m.fill (2.0)
			across
				benchmark("partial", "aat", 1) as x
			loop
				n := m.aat.as_real
			end
		end

	benchmark_ata
			-- Benchmark ata computation
		local
			m, n: AL_MATRIX
		do
			m := new_medium_partial_matrix
			across
				benchmark("partial", "ata", 1) as x
			loop
				n := m.ata.as_real
			end
		end

	benchmark_fill
			-- Benchmark `fill' operation.
		local
			m: AL_MATRIX
			d: DOUBLE
		do
			d := 1.0
			m := new_large_partial_matrix
			across
				benchmark ("partial","fill", 100) as x
			loop
				m.fill (d)
				d := d + 1.0
			end
		end

	benchmark_times
			-- Benchmark `times' operation.
		local
			m, n, o: AL_MATRIX
		do
			m := new_medium_partial_square_matrix
			n := new_medium_partial_square_matrix
			across
				benchmark ("partial","times", 1) as x
			loop
				o := n.times (m)
			end
		end

	benchmark_transposed
			-- Benchmark `transposed' operation.
		local
			m, o: AL_MATRIX
		do
			m := new_large_partial_matrix
			across
				benchmark ("partial","transposed", 10) as x
			loop
				o := m.transposed
			end
		end

	benchmark_duplicated
			-- Benchmark `duplicated' operation.
		local
			m, o: AL_MATRIX
		do
			m := new_large_partial_matrix
			across
				benchmark ("partial","duplicated", 10) as x
			loop
				o := m.to_real
			end
		end

	benchmark_csv
			-- Benchmark `csv' operation.
		local
			m: AL_MATRIX
			s: STRING
		do
			m := new_small_partial_matrix
			across
				benchmark ("partial","csv", 10) as x
			loop
				s := m.csv
			end
		end

end

note
	description: "Benchmarks for AL_DENSE_MATRIX"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	BENCHMARK_DENSE_MATRIX

inherit
	BENCHMARK_USER
	BENCHMARK_CONSTANTS

feature -- Execution

	run
			-- Run the benchmark.
		do
			benchmark_aat
			benchmark_ata
			benchmark_creation
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
			m := new_medium_matrix
			m.fill (2.0)
			across
				benchmark("dense", "aat", 1) as x
			loop
				n := m.aat.real
			end
		end

	benchmark_ata
			-- Benchmark ata computation
		local
			m, n: AL_MATRIX
		do
			m := new_medium_matrix
			across
				benchmark("dense", "ata", 1) as x
			loop
				n := m.ata.real
			end
		end

	benchmark_creation
			-- Benchmark the creation and initialization.
		local
			m: AL_MATRIX
		do
			across
				benchmark ("dense","creation", 100) as x
			loop
				m := al.matrix (default_large_size, default_large_size)
			end
		end

	benchmark_fill
			-- Benchmark `fill' operation.
		local
			m: AL_MATRIX
			d: DOUBLE
		do
			d := 1.0
			m := al.matrix (default_large_size, default_large_size)
			across
				benchmark ("dense","fill", 100) as x
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
			m := new_medium_square_matrix
			n := new_medium_square_matrix
			across
				benchmark ("dense","times", 1) as x
			loop
				o := n.times (m)
			end
		end

	benchmark_transposed
			-- Benchmark `transposed' operation.
		local
			m, o: AL_MATRIX
		do
			m := new_large_matrix
			across
				benchmark ("dense","transposed", 10) as x
			loop
				o := m.transposed
			end
		end

	benchmark_duplicated
			-- Benchmark `duplicated' operation.
		local
			m, o: AL_MATRIX
		do
			m := new_large_matrix
			across
				benchmark ("dense","duplicated", 100) as x
			loop
				o := m.duplicated
			end
		end

	benchmark_csv
			-- Benchmark `csv' operation.
		local
			m: AL_MATRIX
			s: STRING
		do
			m := new_small_matrix
			across
				benchmark ("dense","csv", 10) as x
			loop
				s := m.csv
			end
		end

end

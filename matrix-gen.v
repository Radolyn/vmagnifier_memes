import rand
import strconv
import os

fn main() {
	if os.args.len < 2 {
		println('specify amount (e.g. matrix-gen.exe 5)')
		return
	}
	n := strconv.atoi(os.args[1])
	if n <= 0 {
		println('invalid amount')
		return
	}
	if !os.exists('matrices') {
		os.mkdir('matrices')
	}
	for _ in 0 .. n {
		mut f := os.create('matrices/' + rand.i64().str()) or {
			continue
		}
		mut s := ''
		for _ in 0 .. 25 {
			s += rand.f64_in_range(-3, 3).str() + ' '
		}
		f.write(s[0..s.len - 2])
		f.close()
	}
}

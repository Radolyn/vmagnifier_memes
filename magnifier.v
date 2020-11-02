import os
import strconv
import rand
import magnification
import syscalls
import json
import time

const (
	config_file     = 'memes.conf'
	matrices_folder = 'matrices'
)

struct Config {
	block_input bool
	time        int
}

fn main() {
	if !os.exists(config_file) {
		s := Config{}
		cfg_str := json.encode(s)
		os.write_file(config_file, cfg_str)
	}
	cfg_str2 := os.read_file(config_file) or {
		println('failed to read config file')
		return
	}
	config := json.decode(Config, cfg_str2) or {
		println('failed to decode config file')
		return
	}
	if !os.exists(matrices_folder) {
		eprintln('generate matrixes using matrix-gen.exe at first')
		return
	}
	files := os.ls(matrices_folder) or {
		eprintln("failed to list \'$matrices_folder\' folder")
		return
	}
	if files.len == 0 {
		eprintln('generate matrices using matrix-gen.exe at first')
		return
	}
	res := magnification.initialize()
	if !res {
		eprintln('failed to initialize magnifier API')
		return
	}
	if config.block_input {
		syscalls.block_input(true)
	}
	mut effect := magnification.get_fullscreen_color_effect()
	time_end := time.now().add_seconds(config.time)
	for {
		if time.now().ge(time_end) {
			break
		}
		data2 := os.read_file(matrices_folder + os.path_separator + files[rand.int_in_range(0, files.len)]) or {
			eprintln('failed to read file')
			continue
		}
		array2 := data2.replace('\r\n', ' ').split(' ')
		mut f32_array := array2.map(strconv.atof_quick(it))
		effect.transform[0][0] = f32_array[0]
		effect.transform[0][1] = f32_array[1]
		effect.transform[0][2] = f32_array[2]
		effect.transform[0][3] = f32_array[3]
		effect.transform[0][4] = f32_array[4]
		effect.transform[1][0] = f32_array[5]
		effect.transform[1][1] = f32_array[6]
		effect.transform[1][2] = f32_array[7]
		effect.transform[1][3] = f32_array[8]
		effect.transform[1][4] = f32_array[9]
		effect.transform[2][0] = f32_array[10]
		effect.transform[2][1] = f32_array[11]
		effect.transform[2][2] = f32_array[12]
		effect.transform[2][3] = f32_array[13]
		effect.transform[2][4] = f32_array[14]
		effect.transform[3][0] = f32_array[15]
		effect.transform[3][1] = f32_array[16]
		effect.transform[3][2] = f32_array[17]
		effect.transform[3][3] = f32_array[18]
		effect.transform[3][4] = f32_array[19]
		effect.transform[4][0] = f32_array[20]
		effect.transform[4][1] = f32_array[21]
		effect.transform[4][2] = f32_array[22]
		effect.transform[4][3] = f32_array[23]
		effect.transform[4][4] = f32_array[24]
		magnification.set_fullscreen_color_effect(&effect)
	}
	magnification.uninitialize()
	syscalls.block_input(false)
}

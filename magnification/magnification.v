module magnification

#flag -lmagnification
#include <magnification.h>
[typedef]
pub struct C.MAGCOLOREFFECT {
pub mut:
	transform [5][5]f64
}

fn C.MagInitialize() bool

fn C.MagUninitialize() bool

fn C.MagSetFullscreenColorEffect(MAGCOLOREFFECT) bool

fn C.MagGetFullscreenColorEffect(MAGCOLOREFFECT) bool

pub fn initialize() bool {
	return C.MagInitialize()
}

pub fn uninitialize() bool {
	return C.MagUninitialize()
}

pub fn get_fullscreen_color_effect() C.MAGCOLOREFFECT {
	mut effect := C.MAGCOLOREFFECT{}
	C.MagGetFullscreenColorEffect(&effect)
	return effect
}

pub fn set_fullscreen_color_effect(effect C.MAGCOLOREFFECT) bool {
	return C.MagSetFullscreenColorEffect(&effect)
}

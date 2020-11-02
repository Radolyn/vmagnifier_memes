module syscalls

#include <winuser.h>
fn C.BlockInput(block bool) bool

pub fn block_input(block bool) bool {
	return C.BlockInput(block)
}

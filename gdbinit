source /home/oni/pwndbg/gdbinit.py
source /home/oni/Pwngdb/pwngdb.py
source /home/oni/Pwngdb/angelheap/gdbinit.py

define hook-run
python
import angelheap
angelheap.init_angelheap()
end
end

set history save off
set disassembly-flavor intel
set debuginfod enabled on
set show-tips off

add-auto-load-safe-path /home/oni/.rustup/toolchains
dir /home/oni/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/etc
add-auto-load-safe-path /home/oni/linux

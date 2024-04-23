source /opt/gef/gef.py

set disassembly-flavor intel
set debuginfod enabled on
add-auto-load-safe-path /home/revenant/.rustup/toolchains
dir /home/revenant/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/etc

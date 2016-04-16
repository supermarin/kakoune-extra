##
## percent.kak by lenormf
## Compute and store the relative position of the cursor in percent
##

## position of the cursor in the buffer, in percent
decl str modeline-pos-percent

hook global WinCreate .* %{
    hook window NormalIdle .* %{ %sh{
        if [ -f "${kak_bufname}" ]; then
            echo "set window modeline-pos-percent '$(($kak_cursor_line * 100 / $(wc -l < $kak_bufname)))'"
        else
            echo "
                eval -save-regs 'm' %{
                    exec -draft '%<a-s>:reg m %reg{#}<ret>'
                    set window modeline-pos-percent %sh{echo \$((\$kak_cursor_line * 100 / \$kak_reg_m))}
                }
            "
        fi
    } }
}

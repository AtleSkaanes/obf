package obf

import "core:fmt"
import "core:os"

main :: proc() {
    buf := get_buf()
    defer delete(buf)

    toks := parse(buf)
    defer delete(toks)

    run_bf(toks)
}

get_buf :: proc() -> []u8 {
    if len(os.args) <= 1 {
        fmt.println("PROVE BRAINFUCK FILE AS FIRST ARGUMENT")
        os.exit(1)
    }
    filename := os.args[1]
    f, open_err := os.open(filename)
    if open_err != nil {
        fmt.println("FAILED TO OPEN FILE: '", filename, "'")
        os.exit(1)
    }
    defer os.close(f)

    buf, ok := os.read_entire_file(filename)
    if !ok {
        fmt.println("FAILED TO READ FILE: '", filename, "'")
        os.exit(1)
    }

    return buf

}

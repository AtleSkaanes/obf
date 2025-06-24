package obf

import "core:fmt"

run_bf :: proc(tokens: []Token) {
    data := make([dynamic]u8, 255, 255);
    ptr: uint = 0

    instruction_ptr: int = 0
    for instruction_ptr < len(tokens) {
        tok := tokens[instruction_ptr]
        switch tok.tok {
        case TokenType.EOF: {}
        case TokenType.MOV_LEFT:
            ptr = dec_ptr(ptr, tok.count)
        case TokenType.MOV_RIGHT:
            ptr = inc_ptr(ptr, tok.count)
            for ptr >= len(data) {
                append(&data, 0)
            }
        case TokenType.ADD:
            data[ptr] = inc_value(data[ptr], tok.count)
        case TokenType.SUB:
            data[ptr] = dec_value(data[ptr], tok.count)
        case TokenType.LOOP_START:
            if data[ptr] == 0 {
                instruction_ptr = tok.data - 1
            }
        case TokenType.LOOP_END:
            instruction_ptr = tok.data - 2 
        case TokenType.PRINT:
            for _ in 0..<tok.count {
                fmt.printf("%c", data[ptr])
            }
        case TokenType.DEBUG:
            for _ in 0..<tok.count {
                fmt.printf("0x%X", data[ptr])
            }
        }

        instruction_ptr += 1
    }

    fmt.println("")
}

inc_value :: proc(val: u8, by: uint) -> u8 {
    return cast(u8)(((cast(uint)val + by) + 256) % 256);
}

dec_value :: proc(val: u8, by: uint) -> u8 {
    return cast(u8)(((cast(uint)val - by) + 256) % 256);
}

inc_ptr :: proc(ptr: uint, by: uint) -> uint {
    return ptr + by
}

dec_ptr :: proc(ptr: uint, by: uint) -> uint {
    if ptr < by {
        return 0
    } else {
        return ptr - by
    }
}

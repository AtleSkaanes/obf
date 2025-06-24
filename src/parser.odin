package obf

import "core:fmt"
import "core:os"

parse :: proc(buf: []u8) -> []Token {
    // Dynamic array with len 0, and capacity of len(buf)
    toks := make([dynamic]Token, 0, len(buf))

    loop_starts := make([dynamic]int, 0, 10)
    defer delete(loop_starts)

    curr_tok: Token = Token {
        tok = TokenType.EOF,
        count = 0,
    };


    for ch in buf {
        tok, ok := token_from_ch(ch).?
        // Ignore invalid charachters
        if !ok do continue

        if tok == TokenType.LOOP_START {
            append(&toks, curr_tok)
            append(&loop_starts, len(toks))
            curr_tok = Token {
                tok = tok,
                count = 1,
                data = 0
            }
            continue
        }

        if tok == TokenType.LOOP_END {
            if len(loop_starts) == 0 {
                fmt.println("Found a closing bracket ']', without a start bracket '['")
                os.exit(1)
            }
            start_idx := pop(&loop_starts)
            append(&toks, curr_tok)
            toks[start_idx].data = len(toks)

            curr_tok = Token {
                tok = tok,
                count = 1,
                data = start_idx,
            }
            continue

        }
        
        if curr_tok.tok == tok {
            curr_tok.count += 1;
        } else {
            append(&toks, curr_tok)
            curr_tok = Token {
                tok = tok,
                count = 1,
                data = 0
            }
        }
    }

    append(&toks, curr_tok)

    // Remove the initial EOF
    _ = pop_front(&toks)

    return toks[:];
}

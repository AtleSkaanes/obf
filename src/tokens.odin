package obf

Token :: struct {
    tok: TokenType,
    count: uint,
    data: int,
};

TokenType :: enum {
    EOF,
    // <
    MOV_LEFT,
    // >
    MOV_RIGHT,
    // +
    ADD,
    // -
    SUB,
    // [
    LOOP_START,
    // ]
    LOOP_END,
    // .
    PRINT,
    // #
    DEBUG
};

token_from_ch :: proc(ch: u8) -> Maybe(TokenType) {
    switch ch {
    case '<':
        return TokenType.MOV_LEFT
    case '>':
        return TokenType.MOV_RIGHT
    case '+':
        return TokenType.ADD
    case '-':
        return TokenType.SUB
    case '[':
        return TokenType.LOOP_START
    case ']':
        return TokenType.LOOP_END
    case '.':
        return TokenType.PRINT
    case '#':
        return TokenType.DEBUG
    }
    return nil
}

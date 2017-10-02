#include <string.h>

enum token_type {
    IDENTIFIER = 0,
    INTEGER,
    DECIMAL,
    STRING,
    KEYWORD,
    SYMBOL,
    EOF_TOKEN
};

typedef struct token {
    enum token_type type;
    char *value;
} Token;

static inline Token CREATE_TOKEN(enum token_type type, char *value) {
    return (Token) {type, strdup(value)};
}

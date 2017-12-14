#ifndef MAIN_H
#define MAIN_H 1


#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

enum token_type {
    IDENTIFICADOR = 0,
    NUMERO,
    STRING,
    KEYWORD,
    SYMBOL,
    EOF_TOKEN,
    UNKNOWN
};

typedef struct token {
    enum token_type type;
    char *value;
} Token;

static inline Token CREATE_TOKEN(enum token_type type, char *value) {
    char *q = strdup(value);
    char *p = q;
    for ( ; *p; ++p) *p = tolower(*p);
    return (Token) {type, q};
}

static inline void *smart_malloc(size_t size) {
    void *ptr = malloc(size);
    if (ptr == NULL) {
        printf("Memory allocation error."); exit(-1);
    }
    return ptr;
}

#endif


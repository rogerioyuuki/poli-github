#ifndef MAIN_H
#define MAIN_H 1

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>


enum token_type {
    STACK_IDENTIFIER = 0,
    NUMBER,
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

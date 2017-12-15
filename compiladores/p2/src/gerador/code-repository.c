#include <stdio.h>
#include "../lib/utarray.h"

UT_array *code = NULL;

void initCode() {
  utarray_new(code, &ut_str_icd);
}

void printCode() {
  char **p = NULL;

  while ((p=(char**)utarray_next(code, p))) {
    printf("%s\n",*p);
  }

}

void saveCodeToFile(char *outputPath) {
  FILE *fp = fopen(outputPath, "w");
  char **p = NULL;

  while ((p=(char**)utarray_next(code, p))) {
    fprintf(fp, "\n%s",*p);
  }

  fclose(fp);
}

void addCode(const char *line) {
  utarray_push_back(code, &line);
}

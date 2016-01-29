#include "str.h"

char *str_duplicate(const char *str)
{
    char *new_str = GC_malloc((strlen(str) + 1) * sizeof(char));
    strcpy(new_str, str);

    return new_str;
}

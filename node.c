#include "node.h"

const char *node_types[] = {
    "NT_LIST",
    "NT_ELEMENT",
    "NT_ELEMENT_SEQUENCE"
};

const char *node_type_str(enum node_type type)
{
    return node_types[type];
}

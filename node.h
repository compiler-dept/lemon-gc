#ifndef NODE_H
#define NODE_H

enum node_type {
    NT_LIST,
    NT_ELEMENT,
    NT_ELEMENT_SEQUENCE
};

struct node {
    enum node_type type;
    char *content;
    int childc;
    struct node **childv;
};

const char *node_type_str(enum node_type type);

#endif

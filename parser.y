%include
{
    #include <stdlib.h>
    #include <assert.h>
    #include <stdio.h>
    #include <gc/gc.h>
    #include "node.h"
    #include "str.h"
}

%token_type { const char * }

%token_destructor { (void)ast; }

%syntax_error { fprintf(stderr, "Syntax error!\n"); }

%default_type { struct node * }

%extra_argument { struct node **ast }

translation_unit ::= list(L).
{
    *ast = L;
}
translation_unit ::= error.

list(NODE) ::= LBRACKET element_sequence(ES) RBRACKET.
{
    NODE = ES;
    NODE->type = NT_LIST;
}
list(NODE) ::= LBRACKET RBRACKET.
{
    NODE = GC_malloc(sizeof(struct node));
    NODE->type = NT_LIST;
    NODE->content = NULL;
    NODE->childc = 0;
    NODE->childv = NULL;
}

element_sequence(NODE) ::= element_sequence(ES) COMMA element(E).
{
    NODE = ES;
    NODE->childc += 1;
    NODE->childv = GC_realloc(NODE->childv, NODE->childc * sizeof(struct node *));
    NODE->childv[NODE->childc - 1] = E;
}
element_sequence(NODE) ::= element(E).
{
    NODE = GC_malloc(sizeof(struct node));
    NODE->type = NT_ELEMENT_SEQUENCE;
    NODE->content = NULL;
    NODE->childc = 1;
    NODE->childv = GC_malloc(sizeof(struct node *));
    NODE->childv[0] = E;
}

element(NODE) ::= IDENTIFIER(I).
{
    NODE = GC_malloc(sizeof(struct node));
    NODE->type = NT_ELEMENT;
    NODE->content = str_duplicate(I);
    NODE->childc = 0;
    NODE->childv = NULL;
}

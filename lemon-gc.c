#include <stdlib.h>
#include <stdio.h>
#include <gc/gc.h>
#include "node.h"
#include "str.h"
#include "parser.h"

void *ParseAlloc(void *(*allocProc)(size_t));
void Parse(void *, int, const char *, struct node **);
void ParseFree(void *, void (*freeProc)(void *));

int main(void)
{
    /* initialize garbage collector */
    GC_init();

    /* ast */
    struct node *ast = NULL;

    /* create ast by calling parser */
    void *parser = ParseAlloc(GC_malloc);

    Parse(parser, LBRACKET, str_duplicate("["), &ast);
    Parse(parser, IDENTIFIER, str_duplicate("a"), &ast);
    Parse(parser, COMMA, str_duplicate(","), &ast);
    Parse(parser, IDENTIFIER, str_duplicate("b"), &ast);
    Parse(parser, COMMA, str_duplicate(","), &ast);
    Parse(parser, IDENTIFIER, str_duplicate("c"), &ast);
    Parse(parser, RBRACKET, str_duplicate("]"), &ast);
    Parse(parser, 0, NULL, &ast);

    ParseFree(parser, GC_free);

    /* output ast */
    printf(
        "[%s, %s, %s]\n",
        ast->childv[0]->content,
        ast->childv[1]->content,
        ast->childv[2]->content
    );

    return EXIT_SUCCESS;
}

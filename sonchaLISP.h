#pragma once
struct _atom;
struct _element;
struct _list;

typedef struct _atom{
	int type; // 0 is an integer, 1 is a keyword (function or variable name)
	int value; // integer value if the symbol is an integer.
	char* opName; //Only used when the symbol is an operation.
} atom;

typedef struct _element{
	int type; //If it is 0, it is an atom. If it is 1, it's an element
	struct _atom *atomVal; //Only used when type==0 and the element is an atom.
	struct _list *listVal; //Only used when type==1 and the element is a list.
} element;
	
typedef struct _list{
	int size;
	struct _element** elements;
} list;

void printAtom(atom x);
void printElem(element x);
void printList(list listX);

#pragma once
#include<stdlib.h>
struct _atom;
struct _element;
struct _list;

//TODO: Fix type of atom and element to enum

typedef struct _atom{
	int type; // 0 is an integer, 1 is a function, 2 is a variable name (to be replaced with function arguments)
	int value; // integer value if the symbol is an integer. type == 0
	char* opName; // Only used when the symbol is an operation. type == 1
	char* varName; // Only used when the symbol is a variable. type == 2
} atom;

typedef struct _element{
	int type; //If it is 0, it is an atom. If it is 1, it's a list
	struct _atom *atomVal; //Only used when type==0 and the element is an atom.
	struct _list *listVal; //Only used when type==1 and the element is a list.
} element;
	
typedef struct _list{
	int size;
	int quoteMode; // when quoteMode==0, evaluate list as S-expression. When quoteMode==1, leave it be.
	struct _element** elements;
} list;

void printAtom(atom x);
void printElem(element x);
void printList(list listX);
void freeList(list *listToBeFreed);
void freeElement(element *elementToBeFreed);

element makeElementFromInt(int value){
	element newElement;
	atom* newAtom;
	newAtom = malloc(sizeof(atom));
	newAtom->type = 0;
	newAtom->value = value;
	newElement.type = 0;
	newElement.atomVal = newAtom;
	return newElement;
}

/*
list *copyList(list prevList){
	list* result = malloc(sizeof(list));
	result->size = prevList->size;
	result->quoteMode = prevList->quoteMode;
	for(int i=0;i<result->size;i++){
		result->elements[i] = copyElement(prevList->elements[i]);
	}
	return result;
}

element *copyElement(element prevElement){
	element* result = malloc(sizeof(element));
	result->type = prevElement->type;
	switch(result->type){
		case 0:
			result->atomVal = copyAtom(prevElement->atomVal);
			break;
		case 1:
			result->listVal = copyList(prevElement->listVal);
			break;
	}
}

atom *copyAtom(element prevAtom){
	atom* result = malloc(sizeof(atom));
	atom->type = prevAtom->type;
	switch(atom->type){
		case 0:
			atom->value = prevAtom->value;
			break;
		case 1:
			atom->opName = malloc(sizeof(char)*(strlen(prevAtom->opName)+1));
			strcpy(atom->opName, prevAtom->opName);
			atom->opName[strlen(prevAtom->opName)] = 0;
			break;
		case 2:
			atom->varName = malloc(sizeof(char)*(strlen(prevAtom->varName)+1));
			strcpy(atom->varName, prevAtom->varName);
			atom->varName[strlen(prevAtom->varName)] = 0;
			break;
	}
}
*/

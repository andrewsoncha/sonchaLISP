#pragma once
#include<stdlib.h>
struct _atom;
struct _element;
struct _list;

typedef struct _atom{
	int type; // 0 is an integer, 1 is a keyword (operation or variable name)
	int value; // integer value if the symbol is an integer. type == 0
	char* keyword; // Only used when the symbol is a keyword (operation or variable name). type == 1
} atom;

typedef struct _element{
	int type; //type==0, element is an atom. type==1, element is a list
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
element evalSExpression(list exp, int *signal);
element evalCondExpression(list exp, int *signal);
list *copyList(list prevList);
element *copyElement(element prevElement);
atom *copyAtom(atom prevAtom);

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

list *copyList(list prevList){
	list* result = malloc(sizeof(list));
	result->size = prevList.size;
	result->quoteMode = prevList.quoteMode;
	for(int i=0;i<result->size;i++){
		result->elements[i] = copyElement(*(prevList.elements[i]));
	}
	return result;
}

element *copyElement(element prevElement){
	element* result = malloc(sizeof(element));
	result->type = prevElement.type;
	switch(result->type){
		case 0:
			result->atomVal = copyAtom(*(prevElement.atomVal));
			break;
		case 1:
			result->listVal = copyList(*(prevElement.listVal));
			break;
	}
	return result;
}

atom *copyAtom(atom prevAtom){
	atom* result = malloc(sizeof(atom));
	result->type = prevAtom.type;
	switch(result->type){
		case 0:
			result->value = prevAtom.value;
			break;
		case 1:
			result->keyword = malloc(sizeof(char)*(strlen(prevAtom.keyword)+1));
			strcpy(result->keyword, prevAtom.keyword);
			result->keyword[strlen(prevAtom.keyword)] = 0;
			break;
	}
	return result;
}

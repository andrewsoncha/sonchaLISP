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
element evalExpression(list exp, int *signal);
element evalCondExpression(list exp, int *signal);
list *copyList(list prevList);
element *copyElement(element prevElement);
atom *copyAtom(atom prevAtom);

void freeAtom(atom *atomToBeFreed){
	// Does not check atom type because if there is data that is not used that is still allocated that should still be freed to prevent data leaks
	if(atomToBeFreed->keyword!=NULL){
		free(atomToBeFreed->keyword);
	}
	free(atomToBeFreed);
}

void freeElement(element *elementToBeFreed){
	switch(elementToBeFreed->type){
		case 0:
			freeAtom(elementToBeFreed->atomVal);
			break;
		case 1:
			if(elementToBeFreed->listVal != NULL){
				freeList(elementToBeFreed->listVal);
			}
			break;
	}
	free(elementToBeFreed);
}

void freeList(list *listToBeFreed){
	/*
	printf("freeList: ");
	printList(*listToBeFreed);
	printf("\n");
	*/
	for(int i=0;i<listToBeFreed->size;i++){
		freeElement(listToBeFreed->elements[i]);
	}
	free(listToBeFreed);
}

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
	result->elements = malloc(sizeof(element)*result->size);
	//printf("copyList prevList.size: %d\n", prevList.size);
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

void printAtom(atom x){
//	printf("atom type: %d\n",x.type);
	if(x.type == 0){ // If atom x is an integer 
//		printf("x is an integer!\n");
		printf("%d<I>", x.value);
	}
	else{ //If atom x is a keyword (variable or function) 
	      printf("%s<K>", x.keyword);
	}
}

void printElem(element x){
//	printf("element type:%d\n",x.type);
	if(x.type==0){ // If the element is an atom
		printAtom(*(x.atomVal));
	}
	else{ // If the element is a list
		printList(*(x.listVal));
	}
}

void printList(list listX){
	if(listX.quoteMode==1){
		printf("\'");
	}
	printf("(");
	for(int i=0;i<listX.size;i++){
		printElem(*(listX.elements[i]));
		if(i<(listX.size-1)){
			printf(" ");
		}
	}
	printf(")<L>");
}

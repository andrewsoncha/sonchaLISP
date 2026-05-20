#pragma once
#include"sonchaLISP.h"
#include<stdlib.h>
#include<string.h>
#define MX_FUNCTION_N 500

typedef struct _function{
	int type; // 0 when it's a standard library function, 1 when it's a user defined function
	char* name;
	char* description;
	list argList;
	list evalValue;
	element (*functionPointer)(element*, int, int*); //Only used for Standard Library Functions
} function;

function allFunctions[MX_FUNCTION_N]; //TODO: change this allFunctions static array into a linked list or a Map
int allFunctionN;

function findFunctionByName(char* name){
	for(int i=0;i<allFunctionN;i++){
		if(strcmp(allFunctions[i].name, name)==0){
			return allFunctions[i];
		}
	}
	//If function name is not found
	function nullFunction;
	nullFunction.type = -1;
	return nullFunction;
}

/*
list replaceArgs(list functionList, list evalArgs){
	if(functionList->size != 3){
		printf("replaceArgs: functionList does not have 3 elements (functionList->size: %d)! At least 3 is needed (Name, argument list, expression to evaluate)\n", functionList->size);
		return NULL;
	}
	
	element nameElement = *(functionList->elements[0]);
	element paramElement = *(functionList->elements[1]);
	element functionElement = *(functionList->elements[2]);

	if(nameElement.type != 0){ 
		printf("replaceArgs: the first element of the function list (function name) is not an element!\n");
		return NULL;
	}
	else if(nameElement.atomVal->type != 1){
		printf("replaceArgs: the first element of the function list (function name) is not a string!\n");
		return NULL;
	}
	atom nameAtom = *(nameElement->atomVal);
	char* functionName = nameAtom.keyword;

	if(paramElement.type != 1){
		printf("replaceArgs: the second element of the function list (parameters) is not a list!\n");
		return NULL;
	}
	list paramList = *(paramElement->listVal);
	for(int i=0;i<paramList.size;i++){
		if(paramList.elements[i]->type != 0){
			printf("replaceArgs: the %dth element of the parameters list (second element of the function list) is not a list!\n", i);
			return NULL;
		}
		if(paramList.elements[i]->atomVal->type != 1){
			printf("replaceArgs: the %dth element of the parameters list (second element of the function list) is not a keyword!\n", i);
			return NULL;
		}
	}

	if(paramList.sizeN != evalArgs.sizeN){
		printf("replaceArgs: The function parameters list size (%d) is not the same as the argument list size (%d)\n", paramList.sizeN, evalArgs.sizeN);
		return NULL;
	}

	if(functionElement.type != 1){
		printf("replaceArgs: the third element of the function list (function body) is not a list!\n");
		return NULL;
	}

	list originalFunctionList = *(functionElement.listVal);
	list copiedFunctionList = copyList(originalFunctionList);

	for(int i=0;i<copiedFunctionList.size;i++){
		element elementI = *(copiedFunctionList.element[i]);
		if(elementI.type==1){ // If the elementI is a list, skip this element.
			replaceArgs(elementI.listVal, evalArgs); //TODO: Fix this. THis doesn't actually use the returned value (list). Either change the function so it takes a pointer and edits the passed list itself or use the return value.
			continue;
		}
		atom atomI = elementI.atomVal;
		if(atomI.type==0){ // If the atomI is an integer, skip this element.
			continue;
		}
		char* elementKeyword = atomI.keyword;

		for(int j=0;j<evalArgs.sizeN;j++){
			if(strcmp(elementKeyword, paramElement.element[j]->atomVal->keyword)==0){
				int newKeywordLen = strlen(evalArgs.element[j]->atomVal->keyword);
				realloc(elementKeyword, newKeywordLen+1);
				strcpy(elementKeyword, evalArgs.element[j]->atomVal->keyword);
				elementKeyword[newKeywordLen] = 0;
			}
		}
	}
	return copiedFunctionList;
}
*/

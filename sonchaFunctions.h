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

	list paramList = functionList->elements;

	int argN = evalArgs->size;
	//TODO: Continue from here
}
*/

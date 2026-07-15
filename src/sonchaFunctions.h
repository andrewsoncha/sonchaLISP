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
	list functionList;
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

list replaceArgs(list argList, list functionList, element* evalArgs, int evalArgN){
	/*
	printf("\n");
	printf("replaceArgs argList: ");
	printList(argList);
	printf("\n");

	printf("replaceArgs functionList: ");
	printList(functionList);
	printf("\n");
	*/

	for(int i=0;i<argList.size;i++){
		if(argList.elements[i]->type != 0){
			printf("replaceArgs: the %dth element of the parameters list (second element of the function list) is not a list!\n", i);
			list emptyList;
			emptyList.size = 0;
			emptyList.quoteMode = 1;
			return emptyList;
		}
		if(argList.elements[i]->atomVal->type != 1){
			printf("replaceArgs: the %dth element of the parameters list (second element of the function list) is not a keyword!\n", i);
			list emptyList;
			emptyList.size = 0;
			emptyList.quoteMode = 1;
			return emptyList;
		}
	}

	if(argList.size != evalArgN){
		printf("replaceArgs: The function parameters list size (%d) is not the same as the argument list size (%d)\n",argList.size, evalArgN);
		list emptyList;
		emptyList.size = 0;
		emptyList.quoteMode = 1;
		return emptyList;
	}

	list copiedFunctionList;
	copiedFunctionList.size = functionList.size;
	copiedFunctionList.quoteMode = 0;
	copiedFunctionList.elements = malloc(sizeof(element*)*copiedFunctionList.size);
	for(int i=0;i<copiedFunctionList.size;i++){
		copiedFunctionList.elements[i] = copyElement(*(functionList.elements[i]));
	}

	for(int i=0;i<copiedFunctionList.size;i++){
		element elementI = *(copiedFunctionList.elements[i]);
		if(elementI.type==1){ // If the elementI is a list.
			list oldFuncList = *(elementI.listVal);
			*(elementI.listVal) = replaceArgs(argList, oldFuncList, evalArgs, evalArgN); 
			for(int j=0;j<oldFuncList.size;j++){
				freeElement(oldFuncList.elements[j]);
			}
			continue;
		}
		atom atomI = *(elementI.atomVal);
		if(atomI.type==0){ // If the atomI is an integer, skip this element.
			continue;
		}
		char* elementKeyword = atomI.keyword;

		for(int j=0;j<argList.size;j++){
			if(strcmp(elementKeyword, argList.elements[j]->atomVal->keyword)==0){
				copiedFunctionList.elements[i] = copyElement(evalArgs[j]);
				break;
			}
		}
	}

	/*
	for(int i=0;i<copiedFunctionList.size;i++){
		freeElement(copiedFunctionList.elements[i]);
	}
	*/
	return copiedFunctionList;
}

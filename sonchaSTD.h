#pragma once
#include<string.h>
#include"sonchaLISP.h"
#include"sonchaFunctions.h"

void defineStdFunction(element (*functionPointer)(element*, int, int*), char* funcName, char* funcDescription){
	function newFunc;
	newFunc.type = 0;
	newFunc.name = malloc(sizeof(char)*(strlen(funcName)+1));
	newFunc.description = malloc(sizeof(char)*(strlen(funcDescription)+1));
	strcpy(newFunc.name, funcName);
	strcpy(newFunc.description, funcDescription);
	newFunc.functionPointer = functionPointer;
	allFunctions[allFunctionN++] = newFunc;
}

element add(element *argList, int argN, int* signal){
	int result=0;
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Atom types are accepted.
			*signal = -1;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}
		atom argAtomVal = *(argList[i].atomVal);
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}
		int argIntVal = argAtomVal.value;
		result += argIntVal;
	}
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element sub(element *argList, int argN, int* signal){
	int result=0;
	if(argN<2){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Integer types are accepted.
			*signal = -1;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}
		atom argAtomVal = *(argList[i].atomVal);
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}
		int argIntVal = argAtomVal.value;

		if(i==0){
			result += argIntVal;
		}
		else{
			result -= argIntVal; 
		}
	}
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element mult(element *argList, int argN, int* signal){
	int result=1;
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Integer types are accepted.
			*signal = -1;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}
		atom argAtomVal = *(argList[i].atomVal);
		int argIntVal = argAtomVal.value;
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}

		result *= argIntVal;
	}
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element divide(element *argList, int argN, int* signal){
	int result=1;
	if(argN<2){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Integer types are accepted.
			*signal = -1;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}
  		atom argAtomVal = *(argList[i].atomVal);
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			element resultElement = makeElementFromInt(-1);
			return resultElement;
		}
		int argIntVal = argAtomVal.value;

		if(i==0){
			result *= argIntVal;
		}
		else{
			result /= argIntVal;
		}
	}
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element eq(element *argList, int argN, int* signal){
	int result;
	if(argN<2){
		*signal = -3;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	if(argList[0].type != 0||argList[1].type != 0){ //Only arguments of Integer types are accepted.
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	if(argAtomVal0.type != 0||argAtomVal1.type != 0){ //Only arguments of Integer types are accepted.
		*signal = -2;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;

	result = (argIntVal0==argIntVal1)?1:0;
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element cond(element *argList, int argN, int* signal){
	int result;
	if(argN<3){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	if(argList[0].type != 0|| argList[1].type != 0 ||argList[2].type != 0 ){ //Only arguments of Integer types are accepted.
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	atom argAtomVal2 = *(argList[2].atomVal);
	if(argAtomVal0.type != 0|| argAtomVal1.type != 0||argAtomVal2.type != 0 ){ //Only arguments of Integer types are accepted.
		*signal = -2;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;
	int argIntVal2 = argAtomVal2.value;
	result = (argIntVal0==1)?argIntVal1:argIntVal2;
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element less(element *argList, int argN, int* signal){
	int result;
	if(argN<2){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	if(argList[0].type != 0 || argList[1].type != 0){ //Only arguments of Integer types are accepted.
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	if(argAtomVal0.type != 0 || argAtomVal1.type != 0){ //Only arguments of Integer types are accepted.
		*signal = -2;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;

	result = (argIntVal0<argIntVal1)?1:0;
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element greater(element *argList, int argN, int* signal){
	int result;
	if(argN<2){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	if(argList[0].type != 0 || argList[1].type != 0){ //Only arguments of Integer types are accepted.
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	if(argAtomVal0.type != 0 || argAtomVal1.type != 0){ //Only arguments of Integer types are accepted.
		*signal = -2;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;

	result = (argIntVal0>argIntVal1)?1:0;
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element len(element *argList, int argN, int* signal){
	int result;
	if(argN != 1){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}

	element arg = argList[0];
	printf("arg: ");
	printElem(arg);
	printf("\n");
	if(arg.type !=  1){ // If the passed argument is not a list
		*signal = -2;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	
	list *listVal = arg.listVal;
	result = listVal->size;
	*signal = 0;

	element resultElement = makeElementFromInt(result);
	return resultElement;
}

element first(element *argList, int argN, int* signal){
	element resultElement;
	if(argN != 1){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}

	element arg = argList[0];
	if(arg.type !=  1){ // If the passed argument is not a list
		*signal = -2;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	
	list *listVal = arg.listVal;
	
	if(listVal->size==0){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	else{
		resultElement = *(listVal->elements[0]);
		printf("first Element: ");
		printElem(resultElement);
		printf("\n");
	}

	*signal = 0;

	return resultElement;
}

element rest(element *argList, int argN, int* signal){
	element resultElement;
	if(argN != 1){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}

	element arg = argList[0];
	if(arg.type !=  1){ // If the passed argument is not a list
		*signal = -2;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	
	list *listVal = arg.listVal;
	
	if(listVal->size==0){
		*signal = -1;
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	else{ // Delete the first element of the list
	        list *restList = malloc(sizeof(list));
		printf("listVal->size: %d\n", listVal->size);
		restList->size = listVal->size-1;
		restList->elements = malloc(sizeof(element*)*restList->size);
		for(int i=0;i<restList->size;i++){
			printf("i: %d\n", i);
			restList->elements[i] = listVal->elements[i+1];
		}
		printf("rest element: ");
		printList(*restList);
		printf("\n");
		*signal = 0;

		element resultElement;
		resultElement.type = 1;
		resultElement.listVal = restList;
		return resultElement;
	}
}

element def(element *argList, int argN, int* signal){
	if(argN != 3){
		*signal = -1;
		printf("Error while defining function! There must be only three arguments but %d were given!\n", argN);
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}

	element nameArg;
	element paramArg;
	element functionListArg;

	nameArg = argList[0];
	if(nameArg.type != 0){ // If the first element of the def operation (function arguments) is not an atom
		*signal = -2;
		printf("Error while defining function! First argument of the def operation (function name) not an atom!\n");
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	if(nameArg.atomVal->type != 1){ // If the first element of the def operation (function arguments) is not a keyword
		*signal = -3;
		printf("Error while defining function! First argument of the def operation (function name) not a keyword!\n");
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	atom nameAtom;
	char* functionName;
	nameAtom = *(nameArg.atomVal);
	int functionNameLen = strlen(nameAtom.keyword);
	functionName = malloc(sizeof(char)*(functionNameLen+1));
	strcpy(functionName, nameAtom.keyword);
	functionName[functionNameLen] = 0;

	paramArg = argList[1];
	if(paramArg.type != 1){ // If the second element of the def operation (function arguments) is not an atom
		*signal = -4;
		printf("Error while defining function! Second argument of the def operation (function arguments) not a list!\n");
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	list funcArgList = *(paramArg.listVal);
	printf("funcArgList: ");
	printList(funcArgList);
	printf("\n\n");

	functionListArg = argList[2];
	if(functionListArg.type != 1){ // If the third element of the def operation (function eval list) is not an atom
		*signal = -5;
		printf("Error while defining function! Third argument of the def operation (function eval list) not a list!\n");
		element resultElement = makeElementFromInt(-1);
		return resultElement;
	}
	list functionList = *(functionListArg.listVal);
	printf("functionList: ");
	printList(functionList);
	printf("\n\n");

	list* temp;
	// Save New Function
	function newFunction;
	newFunction.type = 1;
	newFunction.name = functionName;
	temp = copyList(funcArgList);
	newFunction.argList = *temp;
	free(temp); // Only free(temp) and not freeList(temp) cause we have to access the elements in temp that are copied to newFunction.argList or newFunction.functionList
	temp = copyList(functionList);
	newFunction.functionList = *temp;
	free(temp);
	allFunctions[allFunctionN++] = newFunction;

	element resultElement = makeElementFromInt(0);
	return resultElement;
}

void init(){
	defineStdFunction(add, "add", "Add multiple arguments");
	defineStdFunction(sub, "sub","Subtract the 2nd argument and after from the 1st argument");
	defineStdFunction(mult, "mult", "Multiply the arguments");
	defineStdFunction(divide, "div", "Divide the 1st argument by each consecutive arguments");
	defineStdFunction(eq, "eq", "Return 1 if argument 1 and argument 2 is the same value. Return 0 if not.");
	defineStdFunction(cond, "cond", "Return the 2nd argument if argument 1 and argument 2 is the same value. Return 0 if not.");
	defineStdFunction(less, "less", "Return 1 if argument 1 is less than argument 2");
	defineStdFunction(greater, "greater", "Return 1 if argument 1 is greater than argument 2");
	defineStdFunction(len, "len", "Return the length of argument 1 (list)");
	defineStdFunction(first, "first", "Return the first element of a list");
	defineStdFunction(rest, "rest", "Excluding the first element of a list, return the rest of the list");
	defineStdFunction(def, "def", "Define a new user-defined function");
}

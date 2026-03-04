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
	int (*functionPointer)(element*, int, int*); //Only used for Standard Library Functions
} function;

function allFunctions[MX_FUNCTION_N]; //TODO: change this allFunctions static array into a linked list
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

void defineStdFunction(int (*functionPointer)(element*, int, int*), char* funcName, char* funcDescription){
	function newFunc;
	newFunc.type = 0;
	newFunc.name = malloc(sizeof(char)*(strlen(funcName)+1));
	newFunc.description = malloc(sizeof(char)*(strlen(funcDescription)+1));
	strcpy(newFunc.name, funcName);
	strcpy(newFunc.description, funcDescription);
	newFunc.functionPointer = functionPointer;
	allFunctions[allFunctionN++] = newFunc;
}

int add(element *argList, int argN, int* signal){
	int result=0;
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Atom types are accepted.
			*signal = -1;
			return -1;
		}
		atom argAtomVal = *(argList[i].atomVal);
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			return -1;
		}
		int argIntVal = argAtomVal.value;
		result += argIntVal;
	}
	*signal = 0;
	return result;
}

int sub(element *argList, int argN, int* signal){
	int result=0;
	if(argN<2){
		*signal = -1;
		return -1;
	}
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Integer types are accepted.
			*signal = -1;
			return -1;
		}
		atom argAtomVal = *(argList[i].atomVal);
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			return -1;
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
	return result;
}

int mult(element *argList, int argN, int* signal){
	int result=1;
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Integer types are accepted.
			*signal = -1;
			return -1;
		}
		atom argAtomVal = *(argList[i].atomVal);
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			return -1;
		}
		int argIntVal = argAtomVal.value;

		result *= argIntVal;
	}
	*signal = 0;
	return result;
}

int divide(element *argList, int argN, int* signal){
	int result=1;
	if(argN<2){
		*signal = -1;
		return -1;
	}
	for(int i=0;i<argN;i++){
		if(argList[i].type != 0){ //Only arguments of Integer types are accepted.
			*signal = -1;
			return -1;
		}
  		atom argAtomVal = *(argList[i].atomVal);
		if(argAtomVal.type != 0){ //Only arguments of Integer types are accepted.
			*signal = -2;
			return -1;
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
	return result;
}

int eq(element *argList, int argN, int* signal){
	int result;
	if(argN<2){
		*signal = -3;
		return -1;
	}
	if(argList[0].type != 0||argList[1].type != 0){ //Only arguments of Integer types are accepted.
		*signal = -1;
		return -1;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	if(argAtomVal0.type != 0||argAtomVal1.type != 0){ //Only arguments of Integer types are accepted.
		*signal = -2;
		return -1;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;

	result = (argIntVal0==argIntVal1)?1:0;
	*signal = 0;
	return result;
}

int cond(element *argList, int argN, int* signal){
	int result;
	if(argN<3){
		*signal = -1;
		return -1;
	}
	if(argList[0].type != 0|| argList[1].type != 0 ||argList[2].type != 0 ){ //Only arguments of Integer types are accepted.
		*signal = -1;
		return -1;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	atom argAtomVal2 = *(argList[2].atomVal);
	if(argAtomVal0.type != 0|| argAtomVal1.type != 0||argAtomVal2.type != 0 ){ //Only arguments of Integer types are accepted.
		*signal = -2;
		return -1;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;
	int argIntVal2 = argAtomVal2.value;
	result = (argIntVal0==1)?argIntVal1:argIntVal2;
	*signal = 0;
	return result;
}

int less(element *argList, int argN, int* signal){
	int result;
	if(argN<2){
		*signal = -1;
		return -1;
	}
	if(argList[0].type != 0 || argList[1].type != 0){ //Only arguments of Integer types are accepted.
		*signal = -1;
		return -1;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	if(argAtomVal0.type != 0 || argAtomVal1.type != 0){ //Only arguments of Integer types are accepted.
		*signal = -2;
		return -1;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;

	result = (argIntVal0<argIntVal1)?1:0;
	*signal = 0;
	return result;
}

int greater(element *argList, int argN, int* signal){
	int result;
	if(argN<2){
		*signal = -1;
		return -1;
	}
	if(argList[0].type != 0 || argList[1].type != 0){ //Only arguments of Integer types are accepted.
		*signal = -1;
		return -1;
	}
	atom argAtomVal0 = *(argList[0].atomVal);
	atom argAtomVal1 = *(argList[1].atomVal);
	if(argAtomVal0.type != 0 || argAtomVal1.type != 0){ //Only arguments of Integer types are accepted.
		*signal = -2;
		return -1;
	}
	int argIntVal0 = argAtomVal0.value;
	int argIntVal1 = argAtomVal1.value;

	result = (argIntVal0>argIntVal1)?1:0;
	*signal = 0;
	return result;
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
}

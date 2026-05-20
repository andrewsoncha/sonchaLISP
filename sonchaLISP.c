#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sonchaLISP.h"
#include "sonchaSTD.h"
#define MX_EXP 5000

atom* newNumAtom(char* intArr){
	int val = atoi(intArr);
	atom* newNumAtom = malloc(sizeof(atom));
	newNumAtom->type = 0;
	newNumAtom->value = val;
	newNumAtom->keyword = NULL;
	return newNumAtom;
}

atom* newKeywordAtom(char* keywordArr){
	int keywordLen = strlen(keywordArr);
	atom* newOpAtom = malloc(sizeof(atom));
	newOpAtom->type = 1;
	newOpAtom->keyword = malloc(sizeof(char)*(keywordLen+1));
	strcpy(newOpAtom->keyword, keywordArr);
	newOpAtom->value = -1;
	return newOpAtom;
}

element* newAtomElement(atom* newAtom){
	element* newElement = malloc(sizeof(element));
	newElement->type = 0;
	newElement->atomVal = newAtom;
	newElement->listVal = NULL;
	return newElement;
}

element* newListElement(list* newList){
	element* newElement = malloc(sizeof(element));
	newElement->type = 1;
	newElement->atomVal = NULL;
	newElement->listVal = newList;
	return newElement;
}

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
	printf("freeList: ");
	printList(*listToBeFreed);
	printf("\n");
	for(int i=0;i<listToBeFreed->size;i++){
		freeElement(listToBeFreed->elements[i]);
	}
	free(listToBeFreed);
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

list* parse(char* expStr){
	int len = strnlen(expStr, MX_EXP);
	char* expStrCopy;
	int quoteMode = 0;
	expStrCopy = malloc(sizeof(char)*(len+1));
	strcpy(expStrCopy, expStr);

	if(expStrCopy[0]!='(' && !(expStrCopy[0]=='\'' && expStrCopy[1]=='(')){
		printf("Parse Error! Expression does not begin with an opening parenthesis \"(\" or \"\'(\"\n");
		return NULL;
	}

	if(expStrCopy[len-1]=='\n'){
		len--;
	}

	printf("lastCharacter: %c %d \n", expStrCopy[len-1], expStrCopy[len-1]);
	if(expStrCopy[len-1]==')'){
		len--;
	}
	else{
		printf("Parse Error! Expression does not end with a closing parenthesis \')\'\n");
		return NULL;
	}

	if(expStrCopy[0] == '('){
		quoteMode = 0; // Evaluate list as an S-expression
		expStrCopy = expStrCopy+1; //Done to remove of the first '(' that starts the list
		expStrCopy[len-1] = 0; //Done to remove the last ')' that ends the list 
	}
	else if(expStrCopy[0]=='\''&&expStrCopy[1]=='('){
		quoteMode = 1; // Evaluate list as a quoted list
		expStrCopy = expStrCopy+2; //Done to remove of the first "'(" that starts the list
		expStrCopy[len-2] = 0; //Done to remove the last ')' that ends the list 
	}

	printf("expStrCopy: %s\n",expStrCopy);


	element* elementArr[MX_EXP]; //TODO: Change this into a more memory efficient way. Probably a linked list?
	int elementN=0;

	int parenthesisDepth = 0;
	char *parenthesisStr = calloc(sizeof(char), len+1);
	char *strtokContext;
	char *token = strtok_r(expStrCopy, " ", &strtokContext);

	while(token!=NULL){
		int tokenLen = strlen(token);
		printf("parenthesisDepth: %d    token: %s\n", parenthesisDepth, token);
		if(token[0]=='('|| (token[0]=='\''&&token[1]=='(')){
			parenthesisDepth++;
			strcat(parenthesisStr, token);
			strcat(parenthesisStr, " ");
			if(token[tokenLen-1]==')'){ //If it isn't a list with only a single element
				parenthesisDepth--;
				if(parenthesisDepth == 0){

					list *subList = parse(parenthesisStr);
					printf("expStrCopy: %s\n", expStrCopy);
					if(subList == NULL){ // Error while parsing subList
						return NULL;
					}
					elementArr[elementN++] = newListElement(subList);
					parenthesisStr[0] = 0; // Empty out parenthesisStr after parsing subExpression
				}
			}
		}
		else if(token[tokenLen-1]==')'){
			printf("token includes a closing parenthesis\n");
			for(int i=tokenLen-1;i>=0;i--){
				if(token[i]==')'){
					parenthesisDepth--;
				}
			}
			strcat(parenthesisStr, token);
			if(parenthesisDepth == 0){
				printf("Nested List, sending %s!\n",parenthesisStr);
				list *subList = parse(parenthesisStr);
				printf("expStrCopy: %s\n", expStrCopy);
				if(subList == NULL){ // Error while parsing subList
					return NULL;
				}
				elementArr[elementN++] = newListElement(subList);
				parenthesisStr[0] = 0; // Empty out parenthesisStr after parsing subExpression
			}
			else{
				strcat(parenthesisStr, " ");
			}
		}		
		else{
			if(parenthesisDepth>0){
				strcat(parenthesisStr, token);
				strcat(parenthesisStr, " ");
			}
			else{
				atom* newAtom;
				if( (token[0] >= '0' && token[0] <= '9') || token[0]=='-'){ //If token is a number
					//check if every letter of the token is a number
					for(int i=0;i<tokenLen;i++){
						if((token[i] < '0' || token[i] > '9')&&token[i]=='-'){
							printf("Parsing Error! Integer Tokens cannot have non-number characters!\n");
							return NULL;
						}
					}
					newAtom = newNumAtom(token);
				}
				else if( (token[0] >= 'a' && token[0] <= 'z') || (token[0] >= 'A' && token[0] <= 'z') || token[0]=='_') { //If token is a function or a variable
					//check if every letter of the token is accepted
					for(int i=0;i<tokenLen;i++){
						if(!((token[i] >= 'a' && token[i] <= 'z') || (token[i] >= 'A' && token[i] <= 'z') || token[i]=='_')) { 
							printf("Parsing Error! Functions or Variable Names can only have alphabet([a-zA-Z]) or underscore('_')!\n");
							return NULL;
						}
					}
					newAtom = newKeywordAtom(token);
				}
				else{
					printf("Parsing Error! Unrecognized Character!\n");
					return NULL;
				}
				elementArr[elementN++] = newAtomElement(newAtom);
			}
		}
		token = strtok_r(NULL, " ", &strtokContext);
	}
	if(token==NULL){
		printf("token is NULL!\n");
	}
	else{
		printf("token is \"%s\"\n", token);
	}
	if(parenthesisDepth>0){
		printf("Parsing Error! Unclosed Parenthesis!\n");
		return NULL;
	}

	free(parenthesisStr);

	list* resultList;
	resultList = malloc(sizeof(list));
	resultList->quoteMode = quoteMode;
	resultList->size = elementN;
	resultList->elements = malloc(sizeof(element*)*elementN);
	for(int i=0;i<elementN;i++){
		resultList->elements[i] = elementArr[i];
	}
	return resultList;
}

element evalSExpression(list exp, int *signal){
	printf("Evaluating List :");
	printList(exp);
	printf("\n");
	if(exp.size == 0){
		return makeElementFromInt(0);
	}

	if(exp.quoteMode == 1){ // If quoteMode==1, don't evaluate the list
		element result;
		result.type = 1;
		result.listVal = malloc(sizeof(exp));
		*(result.listVal) = exp;
		return result;
	}

	element operator = *(exp.elements[0]);
	printf("operator: ");
	printElem(operator);
	printf("\n");
	printf("operator type: %d\n", operator.type);
	printf("operator.atomVal->type: %d\n", operator.atomVal->type);
	if(operator.type!=0){ //If the first operator of the s-expression is not an atom
		printf("Eval Error! The first element of the S-Expression is not a function/operator!\n");
		*signal = -1;
		return makeElementFromInt(-1);
	}
	if(operator.atomVal->type!=1){ //If the first operator of the s-expression is not a keyword
		printf("Eval Error! The first element of the S-Expression is not a function/operator!\n");
		*signal = -1;
		return makeElementFromInt(-1);
	}

	if(strcmp(operator.atomVal->keyword, "cond")==0){ // When evaluating a conditional expression
		return evalCondExpression(exp, signal);
	}

	function evalFunction = findFunctionByName(operator.atomVal->keyword);
	if(evalFunction.type == -1){
		printf("Eval Error! The first element of the S-Expression is not recognized! Keyword: %s\n",operator.atomVal->keyword);
		*signal = -2;
		return makeElementFromInt(-1);
	}

	int argN = exp.size-1;
	element* argArr = malloc(sizeof(element)*(argN));
	for(int i=0;i<argN;i++){
		element elementVal = *(exp.elements[i+1]);
		if(elementVal.type==0){ // If element is an atom
			argArr[i] = elementVal;
		}
		else{ //If element is a list
		      	element subExpVal = evalSExpression(*(elementVal.listVal), signal);
			printf("\n");
			if(*signal!=0){ //If there was an error while evaluating sub S-Expressions
				return makeElementFromInt(-1);
			}
			printElem(subExpVal);
			argArr[i] = subExpVal;
		}
	}
	element finalValue;
	int evalSignal = 0;
	element (*funcPointer)(element*, int, int*);
	funcPointer = evalFunction.functionPointer;
	finalValue = funcPointer(argArr, argN, &evalSignal);
	printf("eval value: ");
	printElem(finalValue);
	printf("\n");
	if(evalSignal != 0){
		printf("Eval Error! Error while running function %s!\n", evalFunction.name);
		*signal = evalSignal;
		return makeElementFromInt(-1);
	}
	/*
	 * for(int i=0;i<argN;i++){
		if(argArr[i].type==0){ // If the ith argument is an atom
			freeAtom(argArr[i].atomVal);
		}
		else if(argArr[i].type==1){ // If the ith argument is a list
			freeList(argArr[i].listVal);
		}
	}
	*/
	free(argArr);
	return finalValue;
}

element evalCondExpression(list exp, int *signal){
	printf("Evaluating List :");
	printList(exp);
	printf("\n");
	if(exp.size == 0){
		return makeElementFromInt(0);
	}

	if(exp.quoteMode == 1){ // If quoteMode==1, don't evaluate the list
		element result;
		result.type = 1;
		result.listVal = malloc(sizeof(exp));
		*(result.listVal) = exp;
		return result;
	}

	element operator = *(exp.elements[0]);

	int argN = exp.size;

	if(argN != 4){
		printf("evalCondExpression: Eval Error! There needs to be four arguments (including \'cond\' keyword) for conditional expression but %d was/were given!\n", argN);
		*signal = -2;
		return makeElementFromInt(-1);
	}

	element condElem = *(exp.elements[1]);
	element trueExp = *(exp.elements[2]);
	element falseExp = *(exp.elements[3]);

	element condEvalResult;

	if(condElem.type == 0){ // condElem is an atom
		condEvalResult = condElem;
	}
	else{ // condElem is a list
		if(condElem.listVal == NULL){
			printf("evalCondExpression: Eval Error! Conditional argument (second argument) listVal is NULL!\n"); 
			*signal = -2;
			return makeElementFromInt(-1);
		}
		condEvalResult = evalSExpression(*(condElem.listVal), signal);
	}

	if(condEvalResult.type != 0){
		printf("evalCondExpression: Eval Error! Conditional Argument eval result is not an atom!\n");
		printf("eval result: ");
		printElem(condEvalResult);
		*signal = -3;
		return makeElementFromInt(-1);
	}

	atom condEvalAtomVal;
	condEvalAtomVal = *(condEvalResult.atomVal);
	if(condEvalAtomVal.type != 0){
		printf("evalCondExpression: Eval Error! Conditional Argument result is not an integer!\n");
		printf("eval result: ");
		printAtom(condEvalAtomVal);
		*signal = -4;
		return makeElementFromInt(-1);
	}

	element returnVal;
	if(condEvalAtomVal.value == 1){ // If the conditional expression evaluates to true
		if(trueExp.type == 0){ // When the true expression is an atom
			returnVal = trueExp;
		}
		else{ // When the true expression is a list to be evaluated
		        if(trueExp.listVal == NULL){
				printf("evalCondExpression: Eval Error! True Expression (third expression) NULL!\n");
				*signal = -5;
				return makeElementFromInt(-1);
			}
			returnVal = evalSExpression(*(trueExp.listVal), signal);
		}
	}
	else{ // If the conditional expression evaluates to false
		if(falseExp.type == 0){ // When the false expression is an atom
			returnVal = falseExp;
		}
		else{ // When the false expression is a list to be evaluated
			if(falseExp.listVal == NULL){
				printf("evalCondExpression: Eval Error! False Expression (fourth expression) NULL!\n");
				*signal = -6;
				return makeElementFromInt(-1);
			}
			returnVal = evalSExpression(*(falseExp.listVal), signal);
		}
	}

	return returnVal;
}


int main(int argc, char* argv[]){
	list* userList;
	char* userInput;
	size_t userInputMX = MX_EXP;
	size_t userInputLen;
	int signal=0;

	init();
	while(signal!=-1){
		userInput = malloc(sizeof(char) * userInputMX);
		printf(">> ");
		userInputLen = getline(&userInput, &userInputMX, stdin);

		printf("parsing test expression: %s\n", userInput);
		userList = parse(userInput);
		printf("Running Print List!\n");
		printList(*userList);
		printf("\n");

		element evalResult = evalSExpression(*userList, &signal);
		printf("final value: ");
		printElem(evalResult);
		printf("\n");
		printf("signal: %d\n", signal);

		freeList(userList);
	}
	return 0;
}

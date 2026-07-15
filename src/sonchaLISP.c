#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sonchaLISP.h"
#include "sonchaSTD.h"
#define LINE_MX 5000
#define MX_EXP 500000
#define MX_ELEMS 5000

typedef enum _ioModeEnum{
	IO_CLI_MODE,
	IO_FILE_MODE
} ioModeEnum;

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


// TODO: Refactor Parser to go by each character and use stack (instead of going token by token)
list* parse(char* expStr, int expLen){
	int len = expLen;
	char* expStrCopy;
	int quoteMode = 0;
	if(len == 0){
		return NULL;
	}
	// printf("expStr strlen: %d      expLen: %d\n", strlen(expStr), expLen);
	expStrCopy = malloc(sizeof(char)*(len+1));
	strcpy(expStrCopy, expStr);
	// printf("expStrCopy: %s\n", expStrCopy);

	if(expStrCopy[0]!='(' && !(expStrCopy[0]=='\'' && expStrCopy[1]=='(')){
		printf("Parse Error! Expression does not begin with an opening parenthesis \"(\" or \"\'(\"\n");
		return NULL;
	}

	if(expStrCopy[len-1]=='\n'||expStrCopy[len-1]==' '){
		len--;
	}

	//printf("lastCharacter: %c %d \n", expStrCopy[len-1], expStrCopy[len-1]);
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

	//printf("expStrCopy: %s\n",expStrCopy);

	element* elementArr[MX_ELEMS]; //TODO: Change this into a more memory efficient way. Probably a linked list?
	int elementN=0;

	int parenthesisDepth = 0;
	char* parenthesisStr = calloc(expLen+1, sizeof(char));
	int parenthesisStrLen = 0;
	char* strtokContext;
	char* token = strtok_r(expStrCopy, " \n\t", &strtokContext);

	while(token!=NULL){
		int tokenLen = strlen(token);
		//printf("parenthesisDepth: %d    token: %s\n", parenthesisDepth, token);
		if(token[0]=='('|| (token[0]=='\''&&token[1]=='(')){
			parenthesisDepth++;
			strcat(parenthesisStr, token);
			strcat(parenthesisStr, " ");
			parenthesisStrLen += strlen(token)+1;
			// printf("parenthesisStr: %s parenthesisStrLen: %d\n", parenthesisStr, parenthesisStrLen);
			if(token[tokenLen-1]==')'){ //If it isn't a list with only a single element
				parenthesisDepth--;
				if(parenthesisDepth == 0){
					// printf("Nested list, sending %s!\n", parenthesisStr);
					/*
					printf("does this also cause an error?\n");
					printf("parse(%s) %p\n", parenthesisStr, parenthesisStr);
					*/
					list *subList = parse(parenthesisStr, parenthesisStrLen);
					// printf("expStrCopy: %s\n", expStrCopy);
					if(subList == NULL){ // Error while parsing subList
						return NULL;
					}
					elementArr[elementN++] = newListElement(subList);
					parenthesisStr[0] = 0; // Empty out parenthesisStr after parsing subExpression
					parenthesisStrLen = 0;
					// printf("parenthesisStr: %s parenthesisStrLen: %d\n", parenthesisStr, parenthesisStrLen);
				}
			}
		}
		else if(token[tokenLen-1]==')'){
			// printf("token includes a closing parenthesis\n");
			for(int i=tokenLen-1;i>=0;i--){
				if(token[i]==')'){
					parenthesisDepth--;
				}
			}
			strcat(parenthesisStr, token);
			parenthesisStrLen += strlen(token);
			// printf("token: %s\n", token);
			// printf("parenthesisStr: %s parenthesisStrLen: %d\n", parenthesisStr, parenthesisStrLen);
			if(parenthesisDepth == 0){
				// printf("Nested List, sending %s %d!\n",parenthesisStr, parenthesisStrLen);
				/*
				printf("does this also cause an error?\n");
				printf("parse(%s) %p\n", parenthesisStr, parenthesisStr);
				*/
				list *subList = parse(parenthesisStr, parenthesisStrLen);
				// printf("expStrCopy: %s\n", expStrCopy);
				if(subList == NULL){ // Error while parsing subList
					return NULL;
				}
				elementArr[elementN++] = newListElement(subList);
				parenthesisStr[0] = 0; // Empty out parenthesisStr after parsing subExpression
				parenthesisStrLen = 0;
				// printf("parenthesisStr: %s parenthesisStrLen: %d\n", parenthesisStr, parenthesisStrLen);
			}
			else{
				strcat(parenthesisStr, " ");
				parenthesisStrLen++;
				// printf("parenthesisStr: %s parenthesisStrLen: %d\n", parenthesisStr, parenthesisStrLen);
			}
		}		
		else{
			if(parenthesisDepth>0){
				strcat(parenthesisStr, token);
				strcat(parenthesisStr, " ");
				parenthesisStrLen += strlen(token)+1;
				// printf("parenthesisStr: %s parenthesisStrLen: %d\n", parenthesisStr, parenthesisStrLen);
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
		token = strtok_r(NULL, " \n\t", &strtokContext);
	}
	if(token==NULL){
		// printf("token is NULL!\n");
	}
	else{
		// printf("token is \"%s\"\n", token);
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

element evalExpression(list exp, int *signal){
	// printf("Evaluating List :");
	// printList(exp);
	// printf("\n");
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
	/*
	printf("operator: ");
	printElem(operator);
	printf("\n");
	printf("operator type: %d\n", operator.type);
	printf("operator.atomVal->type: %d\n", operator.atomVal->type);
	*/
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
			element subExpVal = evalExpression(*(elementVal.listVal), signal);
			// printf("\n");
			if(*signal!=0){ //If there was an error while evaluating sub S-Expressions
				return makeElementFromInt(-1);
			}
			// printElem(subExpVal);
			argArr[i] = subExpVal;
		}
	}

	element finalValue;
	int evalSignal = 0;
	if(evalFunction.type == 0){ // The operation is an STD function
		element (*funcPointer)(element*, int, int*);
		funcPointer = evalFunction.functionPointer;
		finalValue = funcPointer(argArr, argN, &evalSignal);
		
		/*
		printf("eval value: ");
		printElem(finalValue);
		printf("\n");
		*/
		
		if(evalSignal != 0){
			printf("Eval Error! Error while running function %s!\n", evalFunction.name);
			*signal = evalSignal;
			return makeElementFromInt(-1);
		}
	}
	else{ // The operation is a user defined function
		list evalFunctionList;
		list argList;
		list replacedFunctionList;

		evalFunctionList = evalFunction.functionList;
		argList = evalFunction.argList;

		/*
		printf("\n");
		printf("replaceArgs argList: ");
		printList(argList);
		printf("\n");
		*/

		replacedFunctionList = replaceArgs(argList, evalFunctionList, argArr, argN);
		finalValue = evalExpression(replacedFunctionList, &evalSignal);
		if(evalSignal != 0){
			printf("Eval Error! Error while running function %s!\n", evalFunction.name);
			*signal = evalSignal;
			return makeElementFromInt(-1);
		}
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
	/*printf("Evaluating List :");
	printList(exp);
	printf("\n");
	*/
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
		condEvalResult = evalExpression(*(condElem.listVal), signal);
	}

	if(condEvalResult.type != 0){
		printf("evalCondExpression: Eval Error! Conditional Argument eval result is not an atom!\n");
		/*
		printf("eval result: ");
		printElem(condEvalResult);
		*/
		*signal = -3;
		return makeElementFromInt(-1);
	}

	atom condEvalAtomVal;
	condEvalAtomVal = *(condEvalResult.atomVal);
	if(condEvalAtomVal.type != 0){
		printf("evalCondExpression: Eval Error! Conditional Argument result is not an integer!\n");
		/*
		printf("eval result: ");
		printAtom(condEvalAtomVal);
		*/
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
			returnVal = evalExpression(*(trueExp.listVal), signal);
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
			returnVal = evalExpression(*(falseExp.listVal), signal);
		}
	}

	return returnVal;
}


int main(int argc, char* argv[]){
	list* userList;
	char *inputBuffer = malloc(MX_EXP);
	char *lineBuffer = malloc(LINE_MX);
	//char *lineBuffer;
	size_t lineMX = MX_EXP;
	size_t lineLen;
	size_t userInputLen=0;
	int signal=0;
	int openParenthesisN = 0;
	FILE* inputFP;
	ioModeEnum ioMode;

	if(argc == 1){ // When given no arguments (== cli mode)
		inputFP = stdin;
		ioMode = IO_CLI_MODE;
	}
	else{ // When code file is given
		printf("argc: %d  argv[0]: %s   argv[1]: %s\n", argc, argv[0], argv[1]);
	      	inputFP = fopen(argv[1], "r");
		if(inputFP == NULL){
			printf("Error opening file %s! Exiting!\n", argv[1]);
			return -1;
		}
		ioMode = IO_FILE_MODE;
	}

	init();
	while(signal!=-1){
		//memset(lineBuffer, 0, LINE_MX);
		if(ioMode == IO_CLI_MODE){
			if(openParenthesisN == 0){
				printf(">> ");
			}
			else{
				printf("...	");
			}
		}
		lineLen = getline(&lineBuffer, &lineMX, inputFP);
		if(lineLen==-1){
			break;
		}
		// printf("lineLen: %ld lineBuffer: %s\n", lineLen, lineBuffer);

		for(int i=0;i<lineLen;i++){
			if(lineBuffer[i] == '('){
				openParenthesisN++;
			}
			if(lineBuffer[i] == ')'){
				openParenthesisN--;
			}
		}

		strlcat(inputBuffer, lineBuffer, MX_EXP);
		userInputLen += lineLen;

		if(openParenthesisN == 0){ // When end of multi-line expression
			// printf("parsing test expression: %s\n", inputBuffer);
			userList = parse(inputBuffer, userInputLen);
			if(ioMode == IO_CLI_MODE){
				printf("Evaluating Expression!\n");
				printList(*userList);
				printf("\n");
			}

			element evalResult = evalExpression(*userList, &signal);
			if(ioMode == IO_CLI_MODE){
				printf("final value: ");
				printElem(evalResult);
				printf("\n");
			}
			// printf("signal: %d\n", signal);

			freeList(userList);

			memset(inputBuffer, 0, MX_EXP);
			userInputLen = 0;
		}
		else if(openParenthesisN < 0) { // If there are more closing parenthesis than opening ones
			printf("There are more \')\' than there are \'(\'! \n");
			printf("Resetting input buffer!\n");
			// memset(lineBuffer, 0, LINE_MX);
			memset(inputBuffer, 0, MX_EXP);
		}
	}
	return 0;
}

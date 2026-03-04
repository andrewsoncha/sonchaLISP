#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sonchaLISP.h"
#define MX_EXP 5000

atom* newNumAtom(char* intArr){
	int val = atoi(intArr);
	atom* newNumAtom = malloc(sizeof(atom));
	newNumAtom->type = 0;
	newNumAtom->value = val;
	newNumAtom->opName = NULL;
	return newNumAtom;
}

atom* newOpAtom(char* opArr){
	int opNameLen = strlen(opArr);
	atom* newOpAtom = malloc(sizeof(atom));
	newOpAtom->type = 1;
	newOpAtom->opName = malloc(sizeof(char)*(opNameLen+1));
	strcpy(newOpAtom->opName, opArr);
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

list* parse(char* exp){
	int len = strnlen(exp, MX_EXP);
	char* expCopy;
	expCopy = malloc(sizeof(char)*(len+1));
	strcpy(expCopy, exp);

	if(expCopy[0]!='('){
		printf("Parse Error! Expression does not begin with an opening parenthesis \'(\'\n");
		return NULL;
	}
	if(expCopy[len-1]!=')'){
		printf("Parse Error! Expression does not end with a closing parenthesis \')\'\n");
		return NULL;
	}


	expCopy[len-1] = 0; //Done to remove the last ')' that ends the list 

	expCopy = expCopy+1; //Done to remove of the first '(' that starts the list


	list* resultList;
	resultList = malloc(sizeof(list));
	element* elementArr[500]; //TODO: Change this into a more memory efficient way. Probably a linked list?
	int elementN=0;

	int parenthesisDepth = 0;
	char *parenthesisStr = calloc(sizeof(char), len+1);
	char *token = strtok(expCopy, " ");
	while(token!=NULL){
		int tokenLen = strlen(token);
		if(token[0]=='('){
			parenthesisDepth++;
			strcat(parenthesisStr, token);
			strcat(parenthesisStr, " ");
			if(token[tokenLen-1]==')'){ //If it isn't a list with only a single element
				parenthesisDepth--;
				if(parenthesisDepth == 0){

					list *subList = parse(parenthesisStr);
					if(subList == NULL){ // Error while parsing subList
						return NULL;
					}
					elementArr[elementN++] = newListElement(subList);
				}
			}
		}
		else if(token[tokenLen-1]==')'){
			parenthesisDepth--;
			strcat(parenthesisStr, token);
			if(parenthesisDepth == 0){
				printf("Nested List, sending %s!\n",parenthesisStr);
				list *subList = parse(parenthesisStr);
				if(subList == NULL){ // Error while parsing subList
					return NULL;
				}
				elementArr[elementN++] = newListElement(subList);
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
				if(token[0] >= '0' && token[0] <= '9'){ //If token is a number
					//check if every letter of the token is a number
					for(int i=0;i<tokenLen;i++){
						if(token[i] < '0' || token[i] > '9'){
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
					newAtom = newOpAtom(token);
				}
				else{
					printf("Parsing Error! Unrecognized Character!\n");
					return NULL;
				}
				elementArr[elementN++] = newAtomElement(newAtom);
			}
		}
		token = strtok(NULL, " ");
	}
	if(parenthesisDepth>0){
		printf("Parsing Error! Unclosed Parenthesis!\n");
		return NULL;
	}
	resultList = malloc(sizeof(list));
	resultList->size = elementN;
	resultList->elements = malloc(sizeof(element*)*elementN);
	for(int i=0;i<elementN;i++){
		resultList->elements[i] = elementArr[i];
	}
	return resultList;
}

void printAtom(atom x){
	if(x.type == 0){ // If atom x is an integer 
		printf("%d", x.value);
	}
	else{ //If atom x is a keyword (variable or function) 
	      printf("%s", x.opName);
	}
}

void printElem(element x){
	if(x.type==0){ // If the element is an atom
		printAtom(*(x.atomVal));
	}
	else{ // If the element is a list
		printList(*(x.listVal));
	}
}

void printList(list listX){
	printf("(");
	for(int i=0;i<listX.size;i++){
		printElem(*(listX.elements[i]));
		if(i<(listX.size-1)){
			printf(" ");
		}
	}
	printf(")");
}

int main(int argc, char* argv[]){
	list* testList;
	char testExp[] = "(add 1 (mult 3 4))";
	printf("parsing test expression: %s\n", testExp);
	testList = parse(testExp);
	printf("Parsing Done! awefawe\n");
	printf("Running Print List!\n");
	printList(*testList);
	printf("\n");
	return 0;
}

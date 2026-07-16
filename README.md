# sonchaLISP
sonchaLISP is a bare-bones LISP interpreter written in pure C for educational purposes.

## TODO
* Read from/Run files
* Atom types other than Integers. Add char, float
* Standard Input and Output
* Refactor memory/time inefficient code (change static array linear searches to hash sets)
* Add Macros/Variables
* Add Caching of function return values (when same functions are called with the same arguments twice, return the cached value)

## Build Instructions
Use the included Makefile.
```make``` to create a standard executable file
```make debug``` to include debug information

## Usage
Once you run the program, your inputs as lists will be parsed, evaluated and printed.

```
$ ./sonchaLISP
>> '(1 2 3 4)
Evaluating Expression!
'(1<I> 2<I> 3<I> 4<I>)<L>
final value: '(1<I> 2<I> 3<I> 4<I>)<L>
>> (add 1 2 3)
Evaluating Expression!
(add<K> 1<I> 2<I> 3<I>)<L>
final value: 6<I>
>>
```

### Output Format
When lists are evaluated or printed, there will be a symbol like ``<I>`` next to each element.
The symbols represent the data type of the element.
* ``<I>`` represents an integer.
* ``<L>`` represents a list.
* ``<K>`` represents a keyword, used as a function name or a function argument in defining a function.

## Apostraphy(')
Putting an ``'`` before a list will prevent the list from being evaluated as an expression and return the list as is.

Example:
```
>> (add 1 2)
Evaluating Expression!
(add<K> 1<I> 2<I>)<L>
final value: 3<I>
>> '(add 1 2)
Evaluating Expression!
'(add<K> 1<I> 2<I>)<L>
final value: '(add<K> 1<I> 2<I>)<L>
```

## Functions

### add
``add`` function returns the sum of all arguments. ``add`` accepts only integers as arguments.

Example:
```
>> (add 3 4)
Evaluating Expression!
(add<K> 3<I> 4<I>)<L>
final value: 7<I>
>> (add 1 2 3)
Evaluating Expression!
(add<K> 1<I> 2<I> 3<I>)<L>
final value: 6<I>
```

### sub
``sub`` function returns the first arguments subtracted by every other arguments.
For example, 
``(sub 9 6) = 9 - 6 = 3``
``(sub 30 25 2) = 30 - 25 - 2 = 3``
``sub`` function only accepts integers as arguments.

Example:
```
>> (sub 9 6)
Evaluating Expression!
(sub<K> 9<I> 6<I>)<L>
final value: 3<I>
>> (sub 30 25 2)
Evaluating Expression!
(sub<K> 30<I> 25<I> 2<I>)<L>
final value: 3<I>
```

### mult
``mult`` function returns the product of all arguments. ``mult`` function only accepts integers as arguments.

Example:
```
>> (mult 3 4)
Evaluating Expression!
(mult<K> 3<I> 4<I>)<L>
final value: 12<I>
>> (mult 2 5 8)
Evaluating Expression!
(mult<K> 2<I> 5<I> 8<I>)<L>
final value: 80<I>
```

### div
``div`` function returns the first argument divided by all the rest of the arguments. ``div`` function only accepts integers as arguments. ``div`` function does not support division by zero.

Example:
```
>> (div 50 5)
Evaluating Expression!
(div<K> 50<I> 5<I>)<L>
final value: 10<I>
>> (div 15 4)
Evaluating Expression!
(div<K> 15<I> 4<I>)<L>
final value: 3<I>
>> (div 60 2 3)
Evaluating Expression!
(div<K> 60<I> 2<I> 3<I>)<L>
final value: 10<I>
```

### eq
``eq`` function returns 1 if the first argument and the second argument are equal. If not, ``eq`` returns 0. ``eq`` only accepts two integers as arguments.

Example:
```
>> (eq 3 4)
Evaluating Expression!
(eq<K> 3<I> 4<I>)<L>
final value: 0<I>
>> (eq 4 4)
Evaluating Expression!
(eq<K> 4<I> 4<I>)<L>
final value: 1<I>
>> (eq (mult 3 4) (div 60 5))
Evaluating Expression!
(eq<K> (mult<K> 3<I> 4<I>)<L> (div<K> 60<I> 5<I>)<L>)<L>
final value: 1<I>
```

### cond
``cond`` function returns the second argument if the first argument is 1. If not, ``cond`` function returns the third argument. ``cond`` only accepts three arguments.

Example:
```
>> (cond 1 4 5)
Evaluating Expression!
(cond<K> 1<I> 4<I> 5<I>)<L>
final value: 4<I>
>> (cond 0 4 5)
Evaluating Expression!
(cond<K> 0<I> 4<I> 5<I>)<L>
final value: 5<I>
>> (cond (eq 2 2) 4 5)
Evaluating Expression!
(cond<K> (eq<K> 2<I> 2<I>)<L> 4<I> 5<I>)<L>
final value: 4<I>
>> (cond (eq 3 2) 4 5)
Evaluating Expression!
(cond<K> (eq<K> 3<I> 2<I>)<L> 4<I> 5<I>)<L>
final value: 5<I>
```

### greater
``greater`` function returns 1 if the first argument is greater than the second argument. ``greater`` only accepts two integer arguments.

Example:
```
>> (greater 4 5)
Evaluating Expression!
(greater<K> 4<I> 5<I>)<L>
final value: 0<I>
>> (greater 10 8)
Evaluating Expression!
(greater<K> 10<I> 8<I>)<L>
final value: 1<I>
>> (greater 10 10)
Evaluating Expression!
(greater<K> 10<I> 10<I>)<L>
final value: 0<I>
>> (greater (mult 4 5) (add 7 8))
Evaluating Expression!
(greater<K> (mult<K> 4<I> 5<I>)<L> (add<K> 7<I> 8<I>)<L>)<L>
final value: 1<I>
```

### less
``less`` function returns 1 if the first argument is smaller than the second argument. ``less`` only accepts two integer arguments.

Example:
```
>> (less 4 5)
Evaluating Expression!
(less<K> 4<I> 5<I>)<L>
final value: 1<I>
>> (less 5 5)
Evaluating Expression!
(less<K> 5<I> 5<I>)<L>
final value: 0<I>
>> (less 6 5)
Evaluating Expression!
(less<K> 6<I> 5<I>)<L>
final value: 0<I>
```

### len
``len`` function returns the length of the first argument (list). ``len`` only accepts one list argument.

Example:
```
>> (len '(1))
Evaluating Expression!
(len<K> '(1<I>)<L>)<L>
final value: 1<I>
>> (len '(1 2))
Evaluating Expression!
(len<K> '(1<I> 2<I>)<L>)<L>
final value: 2<I>
>> (len '(1 2 3 4))
Evaluating Expression!
(len<K> '(1<I> 2<I> 3<I> 4<I>)<L>)<L>
final value: 4<I>
```

### first
``first`` function returns the first element of the first argument (list). ``first`` only accepts one non-empty list argument.

Example:
```
>> (first '(1 2 3))
Evaluating Expression!
(first<K> '(1<I> 2<I> 3<I>)<L>)<L>
final value: 1<I>
>> (first '(3 5 10))
Evaluating Expression!
(first<K> '(3<I> 5<I> 10<I>)<L>)<L>
final value: 3<I>
>> (first '())
Evaluating Expression!
(first<K> '()<L>)<L>
Eval Error! Error while running function first!
final value: -1<I>
```

### rest
``rest`` function returns the first argument (list) excluding the first element. ``rest`` only accepts one non-empty list argument.

Example:
```
(rest<K> '(1<I> 2<I> 3<I>)<L>)<L>
final value: (2<I> 3<I>)<L>
>> (rest '(3 5 10))
Evaluating Expression!
(rest<K> '(3<I> 5<I> 10<I>)<L>)<L>
final value: (5<I> 10<I>)<L>
111
```


### def
``def`` function defines a new user function. ``def`` function accepts three arguments:
1. Argument 1 is the name of the user-defined function.
2. Argument 2 is the list of parameters the user-defined function will have.
3. Argument 3 is the list that will be evaluated when the function is called, acting as a function body.

Example 1:
```
>> (def addTwo '(x) '(add x 2))
Evaluating Expression!
(def<K> addTwo<K> '(x<K>)<L> '(add<K> x<K> 2<I>)<L>)<L>
final value: 0<I>
>> (addTwo 5)
Evaluating Expression!
(addTwo<K> 5<I>)<L>
final value: 7<I>
```

Example 2:
```
>> (def militaryTime
...     '(hr min)
...     '(add
...             (mult hr 100)
...             min 
...     )
...     )
Evaluating Expression!
(def<K> militaryTime<K> '(hr<K> min<K>)<L> '(add<K> (mult<K> hr<K> 100<I>)<L> min<K>)<L>)<L>
final value: 0<I>
>> (militaryTime 15 30)
Evaluating Expression!
(militaryTime<K> 15<I> 30<I>)<L>
final value: 1530<I>
>> (militaryTime 22 0)
Evaluating Expression!
(militaryTime<K> 22<I> 0<I>)<L>
final value: 2200<I>
```


## Example Code

### Fibbonacci Sequence
```
>> (def fibb 
...     '(n)
...     '(cond (greater n 2)
...             (add
...                     (fibb (sub n 1))
...                     (fibb (sub n 2))
...             )
...             1
...     )
...     )
Evaluating Expression!
(def<K> fibb<K> '(n<K>)<L> '(cond<K> (greater<K> n<K> 2<I>)<L> (add<K> (fibb<K> (sub<K> n<K> 1<I>)<L>)<L> (fibb<K> (sub<K> n<K> 2<I>)<L>)<L>)<L> 1<I>)<L>)<L>
final value: 0<I>
>> (fibb 1)
Evaluating Expression!
(fibb<K> 1<I>)<L>
final value: 1<I>
>> (fibb 2)
Evaluating Expression!
(fibb<K> 2<I>)<L>
final value: 1<I>
>> (fibb 3)
Evaluating Expression!
(fibb<K> 3<I>)<L>
final value: 2<I>
>> (fibb 13)
Evaluating Expression!
(fibb<K> 13<I>)<L>
final value: 233<I>
```

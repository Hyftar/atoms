# Commands
## Pushing on the stack
### Integer
type the value
```
4
```
pushes `[4]` on the top of the stack


### String
the `""` operator keeps everything inside as a string. You can put only one if it ends your string
```
"Hello World!
```
pushes `['H','e','l','l','o',' ','W','o','r','l','d','!']` on top of the stack

### Vector
the `,` operator add the next element to the top vector
```
3,4,5
```
pushes the vector `[3,4,5]`

### Float
3f14
```
3f14
```
1. pushes `[3]` on the top of the stack
2. add .14 to the last element in the top vector resulting in `[3.14]`

## Popping and pushing from the stack

Atoms automatically pop an element when a method is called

to push a vector to the stack use a whitespace
```
3,4 4,5
```
push `[3,4]` then push `[4,5]`

## Using input base

### binary decimal octal and hexadecimal base

The interpreter is by default in base 10. Any commands will be added as a multiple of 10.
to change to other base simply use their modifier :
```
b1001,d23,h1Ah,077
```
will push `[0b1001,23,0x1A,077]`
notes : a leading zero will automatically modifie the base to octal

### string base
The interpreter can also write in string base with `""` enclosing as seen higher

### float base
the interpreter can write floating point in float base

## Simple Math

### Flatten operator
```
+ - addition
- - subtraction
* - multiplication
/ - division
# - concatenation
& - binary and
| - binary or
```
`&` can be replaced by any operator above
1. if the first vector of the stack is a non single value
```
3,4&
```
push `[3&4]`
2. when the vector has 3+ elements
```
3,4,5&
```
push `[3&4&5]`
3. if the vector is only one var it will pop the second to do the operation
```
3,4 5&
```
push `[3&5,4&5]`
#### Some Examples
```
3,4+; push [7]
3,4,5-; push [-6]
3,4 5+; push [8,9]
3,4 4,5++; push [12,13] -> [3+(4+5),4+(4+5)]
3,2,1#; push [321]
3,4 1,1+-; push [1,2]
1,2,3 0#+; push [60]
```
### none flatten operator
```
% - modulus
^ - exponentiation
```
1. if the first vector of the stack is a non single value
```
3,4%
```
push `[3%4]`
2. when the vector has 3+ elements
```
3,4,5%
```
push `[3%4,3%5]`
3. if the vector is only one var it will pop the second to do the operation
```
3,4 5%
```
push `[3%5,4%5]`

## Generator

Atoms lets you create some special vector with simple commands

### NumberGenerator
the `r` operator returns a random number between 0 and 1
```
r,r,r -> [0.9865,0.8274,0.4567]
```
the `d` operator push a vector of all the digit
```
d -> [0,1,2,3,4,5,6,7,8,9]
```
the `ƥ` (latin small letter p with hook) push the n first prime number where n is the first number in the first vector in the stack. if no number is found it returns the first 100
```
4ƥ -> [2,3,5,7]
```
the `ƒ` (latin small letter f with hook) push the n first fibonacci number where n is the first number in the first vector in the stack. if no number is found it returns the first 100
```
ƒ -> [0,1,1,...,]
```

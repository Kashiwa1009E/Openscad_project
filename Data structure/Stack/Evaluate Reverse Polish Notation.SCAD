//Evaluate Reverse Polish Notation

/* You are given an array of strings tokens that represents an arithmetic expression 
in a Reverse Polish Notation.

Evaluate the expression. Retruen an integer that represents that value of the expression.

Note that:
・The valid operators are '+','-','*'and'/'.
・Each operand may be an integer or another expression.
・The division between two integers always truncates toward zero.
・There will not be any division by zero.
・The input represents a valid arithmetic expression in a reverse polish notation.
・The answer and all the intermediate calculations can be represented in a 32-bit integer.
*/

token=[1,5,"+",3,"*"];



function append(array,num)=[
     for(i=array)
     i,num];

function pop(array)=
     let(init=0)
     let(leng=len(array)-1)
     leng==0?[]:
     [for(i=[init:leng-1])
          array[i]];

function evaluate(token)=
    let(init=0)
    let(leng=len(token)-1)
    let(temp_list=[])
    evaluate_inner(init,leng,token,temp_list);

function evaluate_inner(init,leng,token,temp_list)=
   init>leng ?  temp_list[0]:
   token[init]!="-" &&
   token[init]!="+" &&
   token[init]!="*" && 
   token[init]!="/"?
   let(temp_list_=append(temp_list,token[init]))
   evaluate_inner(init+1,leng,token,temp_list_):
   
   token[init]=="+"?
   let(temp_list_1=pop(temp_list))
   let(temp_list_2=pop(temp_list_1))
   let(leng_temp=len(temp_list)-1)
   let(leng_1=len(temp_list_1)-1)
   let(num=temp_list[leng_temp]+temp_list_1[leng_1])
   let(temp_list_=append(temp_list_2,num))
   evaluate_inner(init+1,leng,token,temp_list_):

   token[init]=="-"?
   let(temp_list_1=pop(temp_list))
   let(temp_list_2=pop(temp_list_1))
   let(leng_temp=len(temp_list)-1)
   let(leng_1=len(temp_list_1)-1)
   let(num=temp_list[leng_temp]-temp_list_1[leng_1])
   let(temp_list_=append(temp_list_2,num))
   evaluate_inner(init+1,leng,token,temp_list_):

   token[init]=="*"?
   let(temp_list_1=pop(temp_list))
   let(temp_list_2=pop(temp_list_1))
   let(leng_temp=len(temp_list)-1)
   let(leng_1=len(temp_list_1)-1)
   let(num=temp_list[leng_temp]*temp_list_1[leng_1])
   let(temp_list_=append(temp_list_2,num))
   evaluate_inner(init+1,leng,token,temp_list_):

   let(temp_list_1=pop(temp_list))
   let(temp_list_2=pop(temp_list_1))
   let(leng_temp=len(temp_list)-1)
   let(leng_1=len(temp_list_1)-1)
   let(num=temp_list[leng_temp]/temp_list_1[leng_1])
   let(temp_list_=append(temp_list_2,num))
   evaluate_inner(init+1,leng,token,temp_list_);

echo(evaluate(token));      
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
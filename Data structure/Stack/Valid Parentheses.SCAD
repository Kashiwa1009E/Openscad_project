// Valid Parentheses 

/* Given a string s containing just the characters '(',')','{','}','['and']',determine if the input string is valid. 
An input string is valid if:

1.Open brackets must be closed by the came type of brackets.
2.Open brackets must be closed in the correct order.
3.Every close bracket has a corresponding open bracket of the same type.

*/

string=("[{()}]");
function append(array,num)=[
     for(i=array)
          i,num];

function pop(array)=
     let(init=0)
     let(leng=len(array)-1)
     leng==0?[]:
     [for(i=[init:leng-1])
            array[i]];
     
function valid_parentheses(string)=
     let(init=0)
     let(leng=len(string)-1)
     let(temp_list=[])
     valid_parentheses_inner(init,leng,string,temp_list);

function valid_parentheses_inner(init,leng,string,temp_list)=
     init>leng && len(temp_list)==0? true:
     string[init]=="(" || string[init]=="{" || string[init]=="["?
     let(temp_list_=append(temp_list,string[init]))
     valid_parentheses_inner(init+1,leng,string,temp_list_):
               
     stack(temp_list,string,init)==true?
     let(temp_list_=pop(temp_list))
     valid_parentheses_inner(init+1,leng,string,temp_list_)
     :
     false;

function stack(temp_list,list,init)=
      let(leng=len(temp_list)-1)
      temp_list[leng]=="{" && list[init]=="}" ? true :
      temp_list[leng]=="[" && list[init]=="]" ? true :
      temp_list[leng]=="(" && list[init]==")" ? true :
      false ;
      
      
echo(valid_parentheses(string));      
      













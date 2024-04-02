// Exponential Search 

//Doubling Search
//Gallpoing Search


array=[2,9,30,32,38,47,61,69,79,81];
target=61;

function exponential_search(array,target)=
     let(index=0)
     let(answer=exponential_search_inner(array,target,index))
     array[answer[0]]==target?
     [answer[0]]:  
     binary_search_inner(array,target,pow(2,answer[0]-1),pow(2,answer[0]));
     
function exponential_search_inner(array,target,index)=
    let(pivot=pow(2,index))     
    let(answer=
        array[pivot]==target?
        pivot:
        array[pivot]<target?
        exponential_search_inner(array,target,index+1):
        index 
        )
      [each(answer)];
    
function binary_search_inner(array,target,init_num,end_num)=
    let(mid_num=round(
        (init_num+end_num)/2))            
    let  (answer=
           array[mid_num]==target?
           mid_num:
           target>array[mid_num]?    
           binary_search_inner(array,target,mid_num+1,end_num):
           
           binary_search_inner(array,target,0,mid_num-1) 
           )
       [each(answer)];    


echo(exponential_search(array,target));


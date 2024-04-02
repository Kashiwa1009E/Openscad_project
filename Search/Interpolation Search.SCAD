//Interpolation Search



array=[1,4,6,9,21,29,31,42,45,56,66,68,74,100,120,136,190];

target=74;


function interpolation_search(array,target)=
     let(leng=len(array)-1)
     let(init_num=0)
     interpolation_search_inner(array,target,init_num,leng);
    
    
function interpolation_search_inner(array,target,init_num,end_num)=
    let(pivot=round((target-array[init_num])*(end_num-init_num)/
               (array[end_num]-array[init_num])+init_num))
    let(answer=
        array[pivot]==target?
        pivot:
        target>array[pivot]?
        interpolation_search_inner(array,target,pivot+1,end_num):
        
        interpolation_search_inner(array,target,init_num,pivot-1)     
        )           
        [each(answer)];
        
        
echo(interpolation_search(array,target));        
      
      
  
  

 
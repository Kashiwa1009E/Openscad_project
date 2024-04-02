//Binary Search

array=[1,4,6,9,21,29,31,42,45,56,66,68,74,100,120,136,190];

target=74;

function binary_search(array,target)=
    let(leng=len(array)-1)
    let(init_num=0)
         binary_search_inner(array,target,init_num,leng);
    


function binary_search_inner(array,target,init_num,end_num)=
    let(mid_num=round(
        (init_num+end_num)/2))            
    let  (answer=
           array[mid_num]==target?
           mid_num:
           target>array[mid_num]?    
           binary_search_inner(array,target,mid_num+1,end_num):
           
           binary_search_inner(array,target,0,mid_num-1) 
           )[
       each(answer)];    


echo(binary_search(array,target));
 


                  
                        
                   
                   
//Selection sort

array=[5,3,42,53,12,54,62,19,24,3,98];
index=0;
pivot_loc=0;

function Selection_sort(array)=
     let(index=0)
     let(pivot_loc=0)
     Selection_sort_inner(array,index,pivot_loc);


function Selection_sort_inner(array,index,pivot_loc)=
     let(leng=len(array)-1)
     let(rearrange_array=Selection_sort_inner_inner(array,index,leng,pivot_loc))
     let(list=
              index==leng?array:
              Selection_sort_inner(rearrange_array,index+1,pivot_loc+1))
              list;

function Selection_sort_inner_inner(array,index,leng,pivot_loc)=
     let(pivot=array[pivot_loc])
     let(rearrange_array= 
             index==leng? array:
              pivot>array[index+1]?
                   Selection_sort_inner_inner(swap(array,pivot_loc,index+1),index+1,leng,pivot_loc):
                   Selection_sort_inner_inner(array,index+1,leng,pivot_loc))
                   
          rearrange_array;
         
//"swap position once detected."       
function swap(array,pivot_loc,index)=
    let(leng=len(array)-1)
    [for(i=[0:leng])
         i==pivot_loc?
         array[index]:
         i==index?
         array[pivot_loc]:
         array[i]
    ];
          
 
 echo(Selection_sort(array));
         
         
         
        
       
     
 
   



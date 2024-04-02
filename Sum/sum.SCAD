//sum 


array=[3,6,9,-8,1,10,11,39];

     
function sum_num(array)=
     let(leng=len(array)-1)
     leng<=0? array :

     let(two_num_sum=array[0]+array[1])
     let(new_array=
         
         leng>1?
        [two_num_sum, for(i=[2:leng])
              array[i]]:
        [two_num_sum]
        )
        sum_num(new_array);        
     
 echo(sum_num(array));            
              
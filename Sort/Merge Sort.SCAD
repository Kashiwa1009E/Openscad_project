//Merge sort


array=[5,3,4,1];
     
function merge_sort(array)=    
     let(init=0)
     let(leng=len(array)-1)
     leng==0? array:
      
     let(mid=round(leng/2))
     let(left_array=[for(i=[init:mid-1])
                     array[i]])
     let(right_array=[for(i=[mid:leng])
                     array[i]])
     merge(merge_sort(left_array),merge_sort(right_array));     
     
      
     
function merge(left_array,right_array)=
     let(result=[])
     let(left_index=0)
     let(right_index=0)
    
function merge_inner(left_index,right_index)=
         left_index<len(left_array) || right_index < len(right_array)?
            result=concat(result,right_array[right_index:len(right_array)-1])
          
/*
   while (left_index < len(left_array) || right_index < len(right_array)) {
        if (left_index == len(left_array)) {
            result = concat(result, right_array[right_index : len(right_array) - 1]);
            right_index = len(right_array);
        } else if (right_index == len(right_array)) {
            result = concat(result, left_array[left_index : len(left_array) - 1]);
            left_index = len(left_array);
        } else if (left_array[left_index] <= right_array[right_index]) {
            result = concat(result, [left_array[left_index]]);
            left_index = left_index + 1;
        } else {
            result = concat(result, [right_array[right_index]]);
            right_index = right_index + 1;
        }
    }

    result;

result = merge_sort(array);
echo(result);
*/
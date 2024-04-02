//Bubble Sort 

array=[23,1,45,3,234,6,4,73,4,9,23,1,45,3,234,6,4,73,4,9,23,1,45,3,234,6,4,73,4,9,23,1,45,3,234,6,4,73,4,9,23,1,45,3,234,6,4,73,4,9];

function bubble_sort(array)=
let(iii=0)
let(check_num=0)
     bubble_sort_check(array,iii,check_num);

function bubble_sort_check(array,iii,check_num)=
     let(leng=len(array)-1)
     let(index=0)
    
     check_num==leng-1?array:
      array[iii]>array[iii+1]?
     
     bubble_sort_check(bubble_sort_inner(array,index,leng),0,0):
     bubble_sort_check(array,iii+1,check_num+1);
     
  
function bubble_sort_inner(array,index,leng)=      
      let(
          sorted_array=[
          if(array[index]>array[index+1])
          for(i=[0:leng])  
                   i==index?
                        array[index+1]:
                   i==index+1?
                        array[index]:
                   array[i]           
          else
          for(i=[0:leng])
                  array[i]])
        index==leng-1?
            sorted_array:
          bubble_sort_inner(sorted_array,index+1,leng)
          ;
         
echo(bubble_sort(array));
   
  
      
                        

          
        
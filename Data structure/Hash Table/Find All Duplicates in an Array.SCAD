//Find All Duplicates in an Array 
/*
Given an integer array nums of length n where all the integers of nums are in the range[1,n] and each integer appears ince of twice, return an array of all the integers that appears twice.abs
*/

nums=[4,3,2,7,8,2,3,1,4,4];

unvisited=0;

function init_array(array)=[
     for(i=array)
         [i,unvisited]
];
     
function get_status(array)=array[1];
function get_num(array)=array[0];

function append(list,num)=[
     for(i=list)
         i,num
     ];



function set_visited(array,num)=[
     for(i=array)
         get_num(i)==num?
             [get_num(i),get_status(i)+1]:i  
     ];

function find_duplicates(array)=
     let(init=0)
     let(leng=len(array)-1)
     let(list=[])
     find_duplicates_inner(init,leng,list,init_array(array));
     
function find_duplicates_inner(init,leng,list,array)=
     init>leng? list:
     let(visited_array=set_visited(array,get_num(array[init])))
     
     let(temp_list=
         get_status(visited_array[init])==2?
         append(list,get_num(array[init])):
         list   
        )    

         find_duplicates_inner(init+1,leng,temp_list,visited_array);
         
         
echo(find_duplicates(nums));         
         
         
          
         
     
     
      
      
    
     
     
     
     
     
     
     
     
     
     
 
     
     
     
     
     
     
     
     
     
     
     
     
     
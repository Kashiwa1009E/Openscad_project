//Number of Good Pairs

/*
Given an array of integer nums, return the number of good pairs.

input=[1,2,3,1,1,3,3]
output=6

*/

nums=[1,2,3,1,1,3,1];

unvisited=0;
visited=1;

function init_array(array)=[
     for(i=array)
         [i,unvisited]
];
      
function get_status(array)=array[1];
function get_num(array)=array[0];

function set_visited(array,num)=[
     for(i=array)
         get_num(i)==num?
             [get_num(i),get_status(i)+1]:i 
     ];

function append(list,num)=[
     for(i=list)
         i,num
     ];

function number_of_good_pairs(array)=
     let(init=0)
     let(leng=len(array)-1)
     let(number=0)
     let(temp_list=[])
     number_of_good_pairs_inner(init,leng,number,temp_list,init_array(array));
     
     
function number_of_good_pairs_inner(init,leng,number,temp_list,array)=
     init>leng? number:
     let(temp_list_=append(temp_list,array[init]))
     let(num=get_num(array[init]))
     let(visited_array=set_visited(temp_list_,num))
     let(number_=number(visited_array))
     
     number_of_good_pairs_inner(init+1,leng,number+number_,visited_array,array);     
    
      
function number(temp_list)=
     let(init=0)
     let(leng=len(temp_list)-1)
     let(index=0)
     let(target_num=get_num(temp_list[leng]))
          number_inner(init,leng,index,target_num,temp_list);    
     
function number_inner(init,leng,index,target_num,temp_list)=
     init>leng? index:
     get_status(temp_list[init])>1 && get_num(temp_list[init])==target_num?
     number_inner(init+1,leng,index+1,target_num,temp_list):
     number_inner(init+1,leng,index,target_num,temp_list);
     
     
echo(number_of_good_pairs(nums));   
     
     
      
     
     
     
     
     
     
     
     
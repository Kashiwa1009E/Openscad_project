//Contains Duplicate
/*
Given an integer array nums, return if any value appears at least twice in the array, and return false if every element is distinct.
*/

nums=[5,2,6,1,4,6];

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
         [get_num(i),visited]:i] ;


function contains_duplicate(array)=
     let(init=0)
     let(leng=len(array)-1)
     contains_duplicate_inner(init,leng,init_array(array));

function contains_duplicate_inner(init,leng,array)=
     get_status(array[init])==visited? false :
     init>leng? true: 
     let(visited_array=set_visited(array,get_num(array[init])))
     contains_duplicate_inner(init+1,leng,visited_array);
     
echo(contains_duplicate(nums));     


 
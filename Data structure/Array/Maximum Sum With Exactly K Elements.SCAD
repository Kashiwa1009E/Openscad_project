//Maximum Sum With Exactly K Elements 

/*
You are given a 0-indexed interger array nums and an integer k. Your task is to perform the following operation exactly k times in order to maximize your score.

*/

nums=[1,2,3,4,5];
k=3;

//O(n)
function max_num(list)=
    let (index=1)
    let(leng=len(list)-1) 
    let (pivot=list[0])
    max_num_inner(index,pivot,leng,list);
 
function max_num_inner(index,pivot,leng,list)=
    index>leng? pivot:
    list[index]>pivot?
    max_num_inner(index+1,list[index],leng,list):
    max_num_inner(index+1,pivot,leng,list);


echo(max_num(nums));



function maximizeSum(list,k)=
     let (init=1)     
     maximizeSum_inner(list,init,k);

function maximizeSum_inner(list,init,k)=
     init>k?list:
     let(maximum=max_num(list))
     let (new_list=
         [ for (i=list)
              i==maximum?
              i+1:
              i]
          )
      maximizeSum_inner(new_list,init+1,k);
       
  echo(maximizeSum(nums,k));
    
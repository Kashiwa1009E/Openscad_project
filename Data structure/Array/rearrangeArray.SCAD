
/* 
You are given a 0-indexed interger array nums of even length consisting of an equal number of positive and negative integers.

You should rearrange the elements of nums such that the modified array follows the given conditions:

1.Every consecutive pair of integers have opposite sings.
2.For all integers with the same sign, the order in which they were present in nums is preserved.
3.The rearranged array begins with a positive integer.

*/


nums=[3,1,-2,-5,2,-4,-3,1,-1,-1];

function append(list,num)=
    [for(i=list)
        i,num
    ];

function append_two_sum(list,num1,num2)=
    [for(i=list)
        i,num1,num2
    ];

    
function rearrangeArray(nums)=
    let(init=0)
    let(leng=len(nums)-1)
    let(positive_array=[])
    let(negative_array=[])
    rearrangeArray_inner(init,leng,positive_array,negative_array);
    
    
function rearrangeArray_inner(init,leng,positive_array,negative_array)=
    init>leng?[positive_array,negative_array]:
    nums[init]>=0?
    rearrangeArray_inner(init+1,leng,append(positive_array,nums[init]),negative_array):
    rearrangeArray_inner(init+1,leng,positive_array,append(negative_array,nums[init]));
        

function RearrangeArray(rearrangeArray)=
     let(positive_array=rearrangeArray[0])
     let(negative_array=rearrangeArray[1])
     let(init=0)
     let(leng=len(positive_array)>len(negative_array)?
              len(positive_array)-1:
              len(negative_array)-1
     )
     let(array=[])
     RearrangeArray_inner(positive_array,negative_array,init,leng,array);
     
function RearrangeArray_inner(positive_array,negative_array,init,leng,array)=
    init>leng? array:
    
    positive_array[init]==undef?
    RearrangeArray_inner(positive_array,negative_array,init+1,leng,
    append(array,negative_array[init])):
      
    negative_array[init]==undef?
    RearrangeArray_inner(positive_array,negative_array,init+1,leng,
    append(array,positive_array[init])):
    
    RearrangeArray_inner(positive_array,negative_array,init+1,leng,
    append_two_sum(array,positive_array[init],negative_array[init])
    );
    
    
echo(RearrangeArray(rearrangeArray(nums)));    
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

    
    
    
    
    
    
    
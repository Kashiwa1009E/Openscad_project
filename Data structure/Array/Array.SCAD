//移除或更動 O(n)

listA=[5,1,6,9,1];


function append(list,num)=[
     for(i=list)
         i,
         num
];



//移除最後一個元素 
function pop(list)=
     let(leng=len(list)-1)
     [for(i=[0:leng-1])
         list[i]    
];
     
     
     
//移除選定元素

function pop_index(list,index)=
     let(leng=len(list)-1)
     [for(i=[0:leng])
           if(i!=index)
           list[i] 
     ];    
          
          
echo(pop_index(listA,0));

                

// Queue 

/*   front →　□　→　□　→　rear(tail) 
Enqueue
Dequeue
*/

queue=[1,2,3,4];

function dequeue(queue)=
    let(leng=len(queue)-1)
    let(init=0)
    leng==0?[]:
    [for(i=[init+1:leng])
         queue[i]       
    ];


echo(dequeue(queue));
    
function enqueue(queue,num)=
    [for(i=queue)
        i,num];
    
    
echo(enqueue(dequeue(queue),5));  
    
  
//Binary Tree Level Order Traversal 


/* Given the root of a binary tree, return the level order traversal of its node's values{i.e., from left to right, level by level}.

*/


/*
BFS通常使用一個佇列當作資料結構來存放每層的節點，
演算法流程:開始於根節點，將其放入佇列中。
1.當佇列不為空時，從前端取出佇列的第一個節點，訪問它。
2.並將其子節點(如果有的話)放入佇列的末尾。
3.這個過程不斷重複，直到佇列為空。
*/

roots=[3,6,9,1,2,3,4,5];

function append(list,num)=
     [for(i=list)i,num];
   
function bfs_append(temp_list,index,rear,queue,roots)=
     let(init=0)
     let(leng=len(temp_list)-1)
     leng>0?
     index<rear?
     [for(i=[init:leng])
     i!=leng?
     temp_list[i]:
     [for (j=temp_list[i])j,queue[0]]
     ]:
     
     roots[index+1]!=undef?
     [for(i=[init:leng])  // index>=rear
     i!=leng?
     temp_list[i]:
     [for (j=temp_list[i])j,queue[0],],[]
     ]:
     
     [for(i=[init:leng])  // index>=rear
     i!=leng?
     temp_list[i]:
     [for (j=temp_list[i])j,queue[0],]
     ] 
     :
     
     leng==0?
     [temp_list[init],[queue[0]]]:
     [[queue[init]]];
     
function enqueue(queue,roots,child_node_index)=
     let(init=0)
     enqueue_inner(queue,roots,child_node_index,init);
function enqueue_inner(queue,roots,child_node_index,init)=
     init>1? queue:
     let(child_index=child_node_index[init])
     let(child=roots[child_index])
     child!=undef?
     let(queue_=append(queue,child))
     enqueue_inner(queue_,roots,child_node_index,init+1):
     enqueue_inner(queue,roots,child_node_index,init+1);

function dequeue(queue)=
     let(leng=len(queue)-1)
     let(init=1)
     leng>0?
     [for(i=[init:leng]) queue[i]]:   
     []
     ;

function child_node_index(roots_index)=
     let(left_index=2*roots_index+1)
     let(right_index=2*roots_index+2)
     [left_index,right_index];
     
function bfs(roots)=
     let(init=0)
     let(leng=len(roots)-1)
     roots[init]==undef?[]:
     let(queue=[roots[init]])
     let(temp_list=[])
     let(index=0)
     let(level=1)
     let(rear=(pow(2,level))-2)
     bfs_inner(roots,init,leng,queue,temp_list,index,level,rear);

function bfs_inner(roots,init,leng,queue,temp_list,index,level,rear)=
     queue==[] ?temp_list:
     let(temp_list_=bfs_append(temp_list,index,rear,queue,roots))
     let(de_queue_=dequeue(queue))
     let(queue_=enqueue(de_queue_,roots,child_node_index(index)))
     
     index>=rear?
     let(level_=level+1)
     let(rear_=(pow(2,level_))-2)
     bfs_inner(roots,init,leng,queue_,temp_list_,index+1,level_,rear_):
     bfs_inner(roots,init,leng,queue_,temp_list_,index+1,level,rear);




echo(bfs(roots));


     
     
     
     
     
     
     
     
    
     

     

//Binary tree Inorder Traversal 
root=[3,5,8,7,undef,9];


function left_child_node_index(root_index)=root_index*2+1;
function right_child_node_index(root_index)=root_index*2+2;

function dfs(root)=
     let(init=0)
     let(root_num=root[init])
     root_num==undef?[]:
     dfs_inner(root,root_num,init);
     
function dfs_inner(root,root_num,root_index)=     
     let(pivot=root_num)
     let(left_child_index=left_child_node_index(root_index))
     let(right_child_index=right_child_node_index(root_index))     
     let(left_child_num=root[left_child_index])
     let(right_child_num=root[right_child_index])
     
     left_child_num==undef && right_child_num==undef? pivot:
     
     left_child_num!=undef && right_child_num==undef?
     [each dfs_inner(root,left_child_num,left_child_index),pivot]:
     
     left_child_num==undef && right_child_num!=undef?
     [pivot, each dfs_inner(root,right_child_num,right_child_index)]:
     
     [each dfs_inner(root,left_child_num,left_child_index), 
     pivot,
      each dfs_inner(root,right_child_num,right_child_index)];
    
echo(dfs(root));                   


       
       
       
       
       
    
        
     
     
     
     
       

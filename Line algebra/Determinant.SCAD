//determinat 
array=[[1,2,3],
       [2,1,1],
       [1,1,2]
       ];       
// circular linked list 
//---------------------------------------------------
function next_node(index,init_num,count_num,array)=
     let(head=0)
     let(end=len(array)-1)
     count_num>=index? init_num:
     init_num==end?
     next_node(index,head,count_num+1,array):  
     next_node(index,init_num+1,count_num+1,array);
     
function linked_list(index,array)=
     let(init_num=0)
     let(count_num=0) 
     next_node(index,init_num,count_num,array);
     
//---------------------------------------------------     
function next_node_(index,init_num,count_num,array)=
     let(head=len(array)-1)
     let(end=0)
     count_num>=index? init_num:
     init_num==end?
     next_node_(index,head,count_num+1,array):
     next_node_(index,init_num-1,count_num+1,array);
     
function linked_list_(index,array)=
     let(init_num=len(array)-1)
     let(count_num=0)
     next_node_(index,init_num,count_num,array);
     
//--------------------------------------------------     
    
    
function list(init_num,array)=
       let(index=0)
       let(num=array[index][linked_list(init_num,array)])
       list_inner(index+1,init_num+1,num,array);    
function list_inner(index,init_num,num,array)=     
       let(leng=len(array))
       index==leng?num:
       let(num_=num*array[index][linked_list(init_num,array)])
       list_inner(index+1,init_num+1,num_,array);

//------------------------------------------------------------------
function list_(init_num,array)=
      let(index=0)
      let(num=array[index][linked_list_(init_num,array)])
      list_inner_(index+1,init_num+1,num,array);
function list_inner_(index,init_num,num,array)=
      let(leng=len(array))
      index==leng?num:
      let(num_=num*array[index][linked_list_(init_num,array)]) 
      list_inner_(index+1,init_num+1,num_,array);
      
    
//--------------------------------------------------------------------        
function sum(list)=
      let(leng=len(list))
      leng==1?list[0]:
      leng==2?list[0]+list[1]:
      let( 
          sum_first=list[0]+list[1],
          sum_after=[for(i=[2:leng-1])
              list[i]])    
      sum(concat(sum_first,sum_after));
          

function determinant(array)=
     let(stairs=len(array)-1)
     let(sum1=sum([for(i=[0:stairs]) list(i,array)]))
     let(sum2=sum([for(i=[0:stairs])list_(i,array)]))
    sum1-sum2; 
                      
echo(determinant(array));
         
for(i=[0:2])
    echo(list(i,array));
                  
          
          
for(i=[0:2])
    echo(list_(i,array));    
          
   
      
      
      
      echo(determinant(array));
      
      
       
       
       
       
       
       
       
     
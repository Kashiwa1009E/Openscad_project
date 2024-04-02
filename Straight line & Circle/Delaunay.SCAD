//Delaunay 

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
    
    
function circumcenter(x1,y1,x2,y2,x3,y3)=
      let(x=determinant([[pow(x1,2)+pow(y1,2),y1,1],
                    [pow(x2,2)+pow(y2,2),y2,1],
                    [pow(x3,2)+pow(y3,2),y3,1]])/(2*
        determinant([[x1,y1,1],
                     [x2,y2,1],
                     [x3,y3,1]]))     
         )
      let(y=determinant([[x1,pow(x1,2)+pow(y1,2),1],
                         [x2,pow(x2,2)+pow(y2,2),1],
                         [x3,pow(x3,2)+pow(y3,2),1] 
                         ])/(2*
            determinant([[x1,y1,1],
                         [x2,y2,1],
                         [x3,y3,1]])))
      [x,y];
     
     

echo(circumcenter(0,0,1,5,10,0));

      
      
      
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);      
      
function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
        [rnd_v(0,width),rnd_v(0,length)]];
     
     
     
for (i=rnd_points(50,50,30)) 
      translate(i)
          sphere(1);
         
 /*     
function delaunay(rnd_points)=
*/


 
      
      
      
      
      
      
      
 
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
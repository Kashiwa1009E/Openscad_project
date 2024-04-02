// Smallest closing circle

//random points---------------------------------
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=200;
points_num=100;

points=[
for(i=[0:points_num-1]
    )
    [rnd_v(init_value,end_value),
     rnd_v(init_value,end_value)
    ]];
for(i=points)
    translate(i)
        sphere(3);
//----------------------------------------------
function append(array,num)=
      [for(i=array) i,num];

function pop(array)=
     let(init=0)
     let(leng=len(array)-1)
     leng==0?[]:
     [for(i=[init:leng-1])
          array[i]];
     
function make_diameter(a,b)=
    let(cx=(a[0]+b[0])/2)
    let(cy=(a[1]+b[1])/2)
    let(r=distance([cx,cy],a))
    [[cx,cy],r];

function is_in_circle(c,p)=
    let(d=distance(c[0],p))  
    d<=c[1]? true:false;  
              
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
          
     
function distance(p1,p2)=
     pow(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2),0.5);      
      
function determinant(array)=
     let(stairs=len(array)-1)
     let(sum1=sum([for(i=[0:stairs]) list(i,array)]))
     let(sum2=sum([for(i=[0:stairs])list_(i,array)]))
    sum1-sum2; 
    
    
function circumcenter(p1,p2,p3)=
      let(x1=p1.x,y1=p1.y,
          x2=p2.x,y2=p2.y,
          x3=p3.x,y3=p3.y)
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
     let(circumcenter=[x,y])      
     let(r=distance(circumcenter,p1))        
     [circumcenter,r];      
//---------------------------------------------      

function smallest_closing_circle(points)=
     let(leng=len(points)-1)
     let(i=1)
     let(c=make_diameter(points[i-1],points[i]))
     sma_clo_cir_i(points,i+1,c,leng);

function sma_clo_cir_i(points,i,c,leng)=
    i>leng ? c:
    is_in_circle(c,points[i])==true?
    sma_clo_cir_i(points,i+1,c,leng):
  
    //is_in_circle(c,points[i])==false
    let(j=0)
    let(stack=[points[i],points[j]])
    let(c_=make_diameter(stack[0],stack[1]))    
    sma_clo_cir_i(points,i+1,sma_clo_cir_j(stack,i,j+1,c_),leng);

function sma_clo_cir_j(stack,i,j,c)=
    j>=i? c:
    is_in_circle(c,points[j])==true?
    sma_clo_cir_j(stack,i,j+1,c):
    
    //is_in_circle(c,points[j]==false
    let(k=0)
    let(stack_pop=pop(stack))
    let(stack_=append(stack_pop,points[j]))
    let(c_=make_diameter(stack_[0],stack_[1]))
    sma_clo_cir_j(stack_,i,j+1,sma_clo_cir_k(stack_,j,k,c_));    
  
function sma_clo_cir_k(stack,j,k,c)=
    k>=j? c:
    is_in_circle(c,points[k])==true?
    sma_clo_cir_k(stack,j,k+1,c):
    //is_in_circle(c,points[k]==false)
    let(c_=circumcenter(stack[0],stack[1],points[k]))
    sma_clo_cir_k(stack,j,k+1,c_);
    
 
    
test=smallest_closing_circle(points);    
    

translate(test[0])
    color("red")
         sphere(3);
         
for(i=[0:360])
    translate([test[0][0]+test[1]*sin(i),test[0][1]+test[1]*cos(i)])
       sphere(1);










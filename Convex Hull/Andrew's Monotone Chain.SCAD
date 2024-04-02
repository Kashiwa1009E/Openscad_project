//Andrew's Monotone Chain 


//random points---------------------------------
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=200;
points_num=20;
points=[
for(i=[0:points_num-1]
    )
    [rnd_v(init_value,end_value),
     rnd_v(init_value,end_value)
    ]];



for(i=[0:points_num-1])
    translate(points[i])
        sphere(3);


//quick_sort------------------------------------

function quick_sort(points)=
     let(leng=len(points)-1)
     leng<1? points:
     let(pivot=points[0])
     let(before=[for(i=[1:leng])
                 if(compare(points[i],pivot))
                     points[i]
                 ])
     let(after=[for(i=[1:leng])
                if(compare(points[i],pivot)==false)
                    points[i]
                ])  
      [each quick_sort(before),pivot,each quick_sort(after)];
//---------------------------------------------
                
//lower。find the lowest/leftmost point.
function compare(pa,pb)=
         pa.x<pb.x || (pa.x==pb.x && pa.y<pb.y)? true: false;                
      
//向量OA叉積向量OB。大於零表示OA到OB為逆時針旋轉。
function cross_(po,pa,pb)=
     (pa.x-po.x)*(pb.y-po.y)-(pa.y-po.y)*(pb.x-po.x);                
            
function angular_compare(po,pa,pb)=
        let(c=cross_(po,pa,pb))
        c>0? true:false;         
                
function append(array,num)=[
     for(i=array)
     i,num];

function pop(array)=
     let(init=0)
     let(leng=len(array)-1)
     leng==0?[]:
     [for(i=[init:leng-1])
          array[i]];                     



function andrew_monotone_chain(points)=
         let(array=quick_sort(points))
         let(upper=andrew_monotone_chain_upper(array))
         let(lower=andrew_monotone_chain_lower(array))
         let(new_array=concat(upper,lower))
         new_array;
         
     
function andrew_monotone_chain_upper(array)=
        let(leng=len(array)-1)
        let(upper=[for(i=[0:leng])
                 if(cross_(array[leng],array[0],array[i])<=0)
                      array[i]
                  ])
        let(upper_leng=len(upper)-1)
        upper_leng<=2? upper:         
        let(stack=[upper[0],upper[1]])
        let(index=len(stack))
        andrew_monotone_chain_upper_inner(upper_leng,index,stack,upper);

function andrew_monotone_chain_upper_inner(upper_leng,index,stack,array)=
       let(stack_leng=len(stack)-1)
       index>upper_leng?stack:
       
       stack_leng<=0?
       let(start_p=stack[0])
       let(pivot_p=array[index])
       let(stack_=append(stack,pivot_p))
       andrew_monotone_chain_upper_inner(upper_leng,index+1,stack_,array):
                 
       let(start_p=stack[stack_leng-1])
       let(pivot_p=stack[stack_leng])
       let(test_p=array[index])
       cross_(start_p,pivot_p,test_p)<=0?
       let(stack_=append(stack,test_p))
       andrew_monotone_chain_upper_inner(upper_leng,index+1,stack_,array):
       let(stack_=pop(stack))
       andrew_monotone_chain_upper_inner(upper_leng,index,stack_,array);  
                 
function andrew_monotone_chain_lower(array)=
        let(leng=len(array)-1)
        let(lower=[for(i=[0:leng])
                if(cross_(array[leng],array[0],array[i])>=0)
                      array[i]              
        ])
        let(lower_leng=len(lower)-1)
        lower_leng<=2? lower:
        let(stack=[lower[0],lower[1]])
        let(index=len(stack))
        andrew_monotone_chain_lower_inner(lower_leng,index,stack,lower); 
               
function andrew_monotone_chain_lower_inner(lower_leng,index,stack,array)=
       let(stack_leng=len(stack)-1)
       index>lower_leng?stack:    
                
       stack_leng<=0?
       let(start_p=stack[0])
       let(pivot_p=array[index])
       let(stack_=append(stack,pivot_p))
       andrew_monotone_chain_lower_inner(lower_leng,index+1,stack_,array):
        
                
       let(start_p=stack[stack_leng-1])
       let(pivot_p=stack[stack_leng])
       let(test_p=array[index])
       cross_(start_p,pivot_p,test_p)>=0?
       let(stack_=append(stack,test_p))
       andrew_monotone_chain_lower_inner(lower_leng,index+1,stack_,array):
       let(stack_=pop(stack))
       andrew_monotone_chain_lower_inner(lower_leng,index,stack_,array);                
                
test=andrew_monotone_chain(points);
echo(test);
for(i=test)
    translate(i)
    color("red")
         sphere(3);

/*                
test1=quick_sort(points);                
translate(test1[0])
     color("blue")
          sphere(3);
translate(test1[points_num-1])
    color("blue")
          sphere(3);            
  */              
                
                
                
                
                
                
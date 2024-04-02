//Graham's Scan

// Convex Hull

//random points---------------------------------
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=-100;
end_value=100;
points_num=20;
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
                              
function hypo_sort(start_p,points)=
      let(leng=len(points)-1)
      leng<1? points:
      let(pivot=points[0])
      let(before=[for(i=[1:leng])
          if(compare(points[i]-start_p,pivot-start_p))
                 points[i]   
          ])
      let(after=[for(i=[1:leng])
          if(compare(points[i]-start_p,pivot-start_p)==false)
                 points[i]
          ])
    [each hypo_sort(start_p,before),pivot,each hypo_sort(start_p,after)];          
               
          
function angular_sort(points)=
          let(array=quick_sort(points))               
          let(start_p=array[0])
          let(new_array=[for(i=[1:len(array)-1])array[i]])
          [start_p,each angular_sort_inner(start_p,new_array)];      
                
          
function angular_sort_inner(start_p,array)=          
          let(leng=len(array)-1)
          leng<1? array:      
                
          let(next_p=array[0])
      
          let(before=[for(i=[1:leng])
                      if(cross_(start_p,next_p,array[i])<0)
                           array[i]
                     ]) 
          let(pivot=[for(i=[1:leng]) 
                     if(cross_(start_p,next_p,array[i])==0)
                           array[i],next_p
                     ])
          let(after=[for(i=[1:leng])
                     if(cross_(start_p,next_p,array[i])>0)
                          array[i]
                    ])   
         [each angular_sort_inner(start_p,before),each hypo_sort(start_p,pivot),each angular_sort_inner(start_p,after)];                               
                     
                                  
//兩點距離的平方
function hypo2(p1,p2)=
     pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2);  
                //---------------------------------------------------

//lower。find the lowest/leftmost point.
function compare(pa,pb)=
         pa.y<pb.y || (pa.y==pb.y && pa.x<pb.x)? true: false;
                
function hypo(x,y)=
     pow(pow(x,2)+pow(y,2),0.5);

//兩點距離的平方
function hypo2(p1,p2)=
     pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2);

//向量OA叉積向量OB。大於零表示OA到OB為逆時針旋轉。
function cross_(po,pa,pb)=
     (pa.x-po.x)*(pb.y-po.y)-(pa.y-po.y)*(pb.x-po.x);

function append(array,num)=[
     for(i=array)
     i,num];

function pop(array)=
     let(init=0)
     let(leng=len(array)-1)
     leng==0?[]:
     [for(i=[init:leng-1])
          array[i]];


function graham_scan(points)=
     let(array=angular_sort(points))
     let(leng=len(array)-1)   
     let(stack=[array[0],array[1],array[2]])
     let(index=len(stack))
     graham_scan_inner(leng,index,stack,array);
     
     
function graham_scan_inner(leng,index,stack,array)=
     index>leng? stack:
     let(stack_leng=len(stack)-1)
     let(start_p=stack[stack_leng-1])
     let(pivot_p=stack[stack_leng])
     let(test_p=array[index])
     
     cross_(start_p,pivot_p,test_p)>0?
     let(stack_=append(stack,test_p))
     graham_scan_inner(leng,index+1,stack_,array):
     
     let(stack_=pop(stack))
     graham_scan_inner(leng,index,stack_,array);
     
echo(graham_scan(points));
 
for(i=graham_scan(points))
    translate(i)
       color("red")
          sphere(3);
     
     
     
     
     

     














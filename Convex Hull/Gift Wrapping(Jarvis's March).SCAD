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

function append(array,num)=[for(i=array) i,num];

function far(po,pa,pb)=
     hypo2(po,pa)>hypo2(po,pb)? true:false;


function gift_wrapping(points)=
     let(array=quick_sort(points))
     let(init=0)
     let(index=0)
     let(leng=len(array)-1)
     leng<=0?array:
     let(start_p=array[init])
     let(convex_points=[start_p])
     gift_wrapping_inner(init,index+1,leng,start_p,convex_points,array);     

function gift_wrapping_inner(init,index,leng,start_p,convex_points,array)=
    index>leng? convex_points:
    let(next_p=next_convex_point(start_p,init,leng,array))
    let(convex_points_=append(convex_points,next_p))
    gift_wrapping_inner(init,index+1,leng,next_p,convex_points_,array);

function next_convex_point(start_p,index,leng,array)=
    let(next_p=array[index])
    next_convex_point_inner(start_p,next_p,index+1,leng,array);
function next_convex_point_inner(start_p,next_p,index,leng,array)=    
    index>leng? next_p:
    let(test_p=array[index])
    let(c=cross_(start_p,next_p,test_p))
    c>0  || (c==0 && far(start_p,test_p,next_p))?
    next_convex_point_inner(start_p,test_p,index+1,leng,array):
    next_convex_point_inner(start_p,next_p,index+1,leng,array);
    

convex=gift_wrapping(points);
for(i=convex)
    translate(i)
         color("red")
             sphere(3);




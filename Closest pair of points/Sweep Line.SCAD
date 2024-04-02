
//random points---------------------------------
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=1000;
points_num=40;


points=[
for(i=[0:points_num-1]
    )
    [rnd_v(init_value,end_value),
     rnd_v(init_value,end_value)
    ]];
for(i=points)
    translate(i)
        sphere(10);
        
  
//quick_sort------------------------------------
function quick_sort(points)=
     let(leng=len(points)-1)
     leng<1? points:
     let(pivot=points[0])
     let(before=[for(i=[1:leng])
                 if(points[i].x<pivot.x)
                     points[i]
                 ])
     let(after=[for(i=[1:leng])
                if(points[i].x>=pivot.x)
                    points[i]
                ])  
      [each quick_sort(before),pivot,each quick_sort(after)];          
//---------------------------------------------------


function hypo(x,y)=
     pow(pow(x,2)+pow(y,2),0.5);
                
                
function sweep_line(points)=
     let(p=quick_sort(points))                
     let(init=0)
     let(index=1)
     let(leng=len(p)-1)
     leng==1? [p[0],p[1]]:
                
     let(p1=p[init],
     p2=p[index]) 
     let(min_distance_points=[p1,p2])          
     let(distance=hypo(p1.x-p2.x,p1.y-p2.y))
     sweep_line_inner(p,init,index+1,leng,distance,min_distance_points);     
                
function sweep_line_inner(p,init,index,leng,distance,min_distance_points)= 
     init>leng? min_distance_points:
     index>leng? 
     let(init_=init+1)
     let(index_=init_+1)
     sweep_line_inner(p,init_,index_,leng,distance,min_distance_points):
     
     let(p1=p[init],
         p2=p[index])
     p2.x-p1.x>distance?
     let(init_=init+1)
     let(index_=init_+1)
     sweep_line_inner(p,init_,index_,leng,distance,min_distance_points):
    
     let(distance_=hypo(p1.x-p2.x,p1.y-p2.y))
     distance_>distance?
     sweep_line_inner(p,init,index+1,leng,distance,min_distance_points):
     
     
     sweep_line_inner(p,init,index+1,leng,distance_,[p1,p2]);
     
                                           
test=sweep_line(points);
echo(test);
for(i=test)
    translate(i)
    color("red")
        sphere(10);





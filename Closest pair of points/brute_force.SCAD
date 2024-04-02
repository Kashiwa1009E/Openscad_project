// brute_force 
/*
find the nearest point
*/



//random points---------------------------------
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=100;
points_num=3;

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


function hypo(x,y)=
     pow(pow(x,2)+pow(y,2),0.5);


function find_min_distance(points)=
     let(init=0)
     let(index=1)
     let(leng=len(points)-1)
     leng==0? points[init]:
     let(p1=points[init])
     let(p2=points[index])
     let(min_distance=hypo(p1.x-p2.x,p1.y-p2.y))
     let(min_distance_points=[p1,p2])
    
     
     find_min_distance_inner(min_distance,   min_distance_points,init,index+1,leng);



function find_min_distance_inner(min_distance,min_distance_points,init,index,leng)=
     
     init>leng? min_distance_points:
     index>leng? 
     let(init_=init+1)
     let(index_=init_+1)
     find_min_distance_inner(min_distance,min_distance_points,init_,index_,leng):



     let(p1=points[init])
     let(p2=points[index])
     let(distance=hypo(p1.x-p2.x,p1.y-p2.y))
     min_distance>distance ?
     let(min_distance_points_=[p1,p2])
     let(min_distance_=distance)
     find_min_distance_inner(min_distance_,     min_distance_points_,init,index+1,leng):

     find_min_distance_inner(min_distance,min_distance_points,init,index+1,leng);     
     
        
    
two_points=find_min_distance(points);

echo(two_points);

for(i=two_points)
    translate(i)
        color("red")
           sphere(3);















//random points---------------------------------
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=100;
points_num=10;

points=[
for(i=[0:points_num-1]
    )
    [rnd_v(init_value,end_value),
     rnd_v(init_value,end_value)
    ]];
/*
for(i=points)
    translate(i)
        sphere(3);
*/
//----------------------------------------------


//atan(y,x) 返回值是弧度


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
            

            
                
function compare(p1,p2)=
       atan2(p1.y,p1.x)<atan2(p2.y,p1.x)?true: false;             
                


 echo(quick_sort(points));   
                
       
function test(points)=
      let(points=quick_sort(points))
      let(leng=len(points)-1)
      let(init=0)
      [for(i=[init:leng])[points[i],i]];
          
for(i=test(points))
    translate(i[0])
        sphere(i[1]);
        
                
                
                
                
                
                
          
               
               
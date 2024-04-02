//aabb bounding box

//找出點集合的上下左右的極值，在圍成正方形

//arithmetic mean

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);            
function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
        [rnd_v(0,width),rnd_v(0,length)]];     
array=rnd_points(100,100,5) ;
for(i=array)
     translate(i)
         sphere(3);
function sum(list)=
      let(leng=len(list))
      leng==1?list[0]:
      leng==2?list[0]+list[1]:
      let( 
          sum_first=list[0]+list[1],
          sum_after=[for(i=[2:leng-1])
              list[i]])    
      sum(concat(sum_first,sum_after));
function arithmetic_mean(array)=
     let(amount=len(array))
     let(x=[for(i=array)
          i.x
          ])
     let(y=[for(i=array)
          i.y
          ]) 
     [sum(x)/amount,sum(y)/amount];
translate(arithmetic_mean(array)) 
     color("red")
     sphere(3);
     
     
function distance(center_point,points)=
[ for(i=points)
    pow(
    (pow((center_point.x-i.x),2)+pow((center_point.y-i.y),2)),
        1/2)     
     ];


     
     
     
     
     
     
     
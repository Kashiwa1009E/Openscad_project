//arithmetic mean

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);      
      
function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
        [rnd_v(0,width),rnd_v(0,length)]];
     
array=rnd_points(150,150,60) ;
       
  
for(i=array)
     translate(i)
         sphere(1);

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
     
//-------------------------------------------------------------------------------------------
function sort(list)=
     let(leng=len(list))
     leng<=1? list:
          let(
               pivot=list[0],
              
               before=[for(j=1;j<leng;j=j+1) 
               if(list[j]<pivot) 
                    list[j]],               
               after=[for(j=1;j<leng;j=j+1)
               if(list[j]>=pivot)
                    list[j]]       
               )               
     [each sort(before),pivot,each sort(after)];   
    
function midian(array)=
     let(array_x=sort([for(i=array)i.x]))
     let(array_y=sort([for(i=array)i.y]))
     let(amount=len(array_x))
     let(x=
     amount%2==0?
     (array_x[amount/2]+array_x[amount/2+1])/2:
     array_x[round(amount/2)])
     
     let(y=
     amount%2==0?
     (array_y[amount/2]+array_y[amount/2+1])/2:
     array_y[round(amount/2)])
     [x,y];



translate(arithmetic_mean(array)) 
     color("red")
     sphere(1.5);
 
 translate(midian(array))
     color("blue")
     sphere(1.5);
 
 
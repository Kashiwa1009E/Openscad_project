//median

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);      
      
function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
        [rnd_v(0,width),rnd_v(0,length)]];
     
array=rnd_points(100,100,10) ;
         
for(i=array)
     translate(i)
         sphere(1);


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
     
 array_x=sort([for(i=array)i.x]);
 array_y=sort([for(i=array)i.y]);    
              
               
function midian(array_x,array_y)=
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
 
 
 echo(midian(array_x,array_y));
     
     
 
     
     
   
     
     
     
     
     
     
     
     
     
     
     
     
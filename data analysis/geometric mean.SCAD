//geometric mean 

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);      
      
function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
        [rnd_v(0,width),rnd_v(0,length)]];
     
array=rnd_points(100,100,100) ;
       
  
for(i=array)
     translate(i)
         sphere(1);

function multiplied(list)=
      let(leng=len(list))
      leng==1?list[0]:
      leng==2?list[0]*list[1]:
      let( 
          multiplied_first=list[0]*list[1],
          multiplied_after=[for(i=[2:leng-1])
              list[i]])    
      multiplied(concat(multiplied_first,multiplied_after));
          
echo(multiplied([1,2,3,4,5,6,7]));          
          


function geometric_mean(array)=
          let(amount=len(array))
          let(x=pow(multiplied([for(i=array)i.x]),1/amount))
          let(y=pow(multiplied([for(i=array)i.y]),1/amount))
          [x,y];    
              
        
        
translate(geometric_mean(array))
          color("red")
               sphere(1.5);
          
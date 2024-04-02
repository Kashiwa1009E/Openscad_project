function f(x,y)=((x)^2)-(y^2);



min_value=0;
max_value=1;

resolution=1;
//解析度

thickness=3;


points=[
for (i=[min_value:resolution:max_value])
    for (j=[min_value:resolution:max_value])
        [i,j,f(i,j)]    
    ];
    


for (point = points)
     translate(point)
          sphere(1);
    
 
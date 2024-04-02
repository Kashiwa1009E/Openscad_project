

function rnd_v(start_value,end_value)=round(rands(start_value,end_value,1)[0]);

points_num=10;
start_value=0;
end_value=500;


points=[for(i=[0:points_num]) [rnd_v(start_value,end_value),rnd_v(start_value,end_value)]];
    
for(i=points)
    translate(i)
        sphere(10);




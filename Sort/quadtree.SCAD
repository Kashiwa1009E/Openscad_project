//quadtree 

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);



side_length=20;
side_width=20;

function length_mid(side_length)=side_length/2;
function width_mid(side_width)=side_width/2;

point_amount=100;

points=[
for(i=[0:point_amount])
     [rnd_v(0,side_width),rnd_v(0,side_length)] 
];

echo(rnd_v(0,side_width));

for(i=points)
    translate(i)
        sphere(0.3);




function quad_tree(init_num,width,rnd_points)=
     let(array=[for(i=[init_num.x:init_num.x+width/2:init_num.x+width/2])
                     for(j=[init_num.y:init_num.y++width/2:init_num.y+with/2])]
                [i,j]         
                     )
                     
                    
                     
                     
     
    
            



























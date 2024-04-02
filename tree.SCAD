module tree(
increment,
depth,
angle
){

linear_extrude(height=increment)
children(0);

if (depth>0){
     translate([0,0,increment])
     rotate([angle,0,0])
     tree(increment,
           depth-1,
           angle+30)
     circle(d=3,$fn=4);
      }

if(depth>0){
     translate([0,0,increment])
     rotate([-angle,0,0])
     tree(increment,
          depth-1,
          -(angle+30))
     circle(d=3,$fn=4);
 
}
}

tree(
increment=10,
depth=5,
angle=20
)circle(d=3,$fn=4);
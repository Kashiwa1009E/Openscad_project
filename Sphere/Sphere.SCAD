//Sphere

center=[0,0,0];
r=100;


s=[
for(i=[0:10:180])
for(j=[0:10:360])
    [center.x+r*sin(i)*cos(j),
     center.y+r*sin(i)*sin(j),
     center.z+r*cos(i)]
];
  

for(i=s)
    translate(i)
     
        sphere(3);


translate([r*sin(0)*cos(0),
           r*cos(0)*cos(0),
           r*sin(0)])
     color("red")
         sphere(3);
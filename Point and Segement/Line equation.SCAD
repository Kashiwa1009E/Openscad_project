/*
Find the equation of a line given two points.
*/

pa=[-100,1];
pb=[1,100];

pc=[100,0];
pd=[-1,100];

function line_equ(pa,pb,x)=
    let(m=(pb.y-pa.y)/(pb.x-pa.x))
    [x,m*(x-pa.x)+pa.y];
    

for(i=[-100:100])
    translate(line_equ(pa,pb,i))
        sphere(3);
    
for(i=[-100:100])
    translate(line_equ(pc,pd,i))
        sphere(3);


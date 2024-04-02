
//Pascal's triangle 

resolution=0.1;

control_p=[-10,10];

p=[[0,0],control_p,[10,10]];

//Bezier curve
function bezier_curve(p1,p2,t)=
     let(p=(1-t)*[p1.x,p1.y]+(t)*[p2.x,p2.y])
     [p.x,p.y];
//--------------------------------------

//main-------------------
function pascal(p,t)=
        pascal_inner(p,len(p),t);
//-----------------------


function pascal_inner(p,n,t)=
let(sum_p=[for(i=[0:n-2])
       bezier_curve(p[i],p[i+1],t)])
n>2? 
pascal_inner(sum_p,n-1,t):
sum_p[0];


for(t=[0:resolution:1])
translate(pascal(p,t))
    sphere(1);





// show the points-------------------------------
for(i=p)
    color("red")
    translate(i)
    sphere(2);
//----------------------------------------------



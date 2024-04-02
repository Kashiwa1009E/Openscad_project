//lofted base

poly_num=10;
function squ(side_len,poly_num)=
   let(half_side_len=side_len/2)
   [
    [half_side_len,0],   
    for(i=[half_side_len:-half_side_len/poly_num:half_side_len/poly_num])
         for(j=[half_side_len/poly_num:half_side_len/poly_num:half_side_len])
              if(abs(i)==half_side_len || abs(j)==half_side_len) 
                   [i,j],
    [0,half_side_len],   
    for(i=[-half_side_len/poly_num:-half_side_len/poly_num:-half_side_len])
         for(j=[half_side_len:-half_side_len/poly_num:half_side_len/poly_num])
              if(abs(i)==half_side_len || abs(j)==half_side_len) 
                   [i,j],
    [-half_side_len,0],
    for(i=[-half_side_len:half_side_len/poly_num:-half_side_len/poly_num])
         for(j=[-half_side_len/poly_num:-half_side_len/poly_num:-half_side_len])
             if(abs(i)==half_side_len || abs(j)==half_side_len) 
                  [i,j],
    [0,-half_side_len],
    for(i=[half_side_len/poly_num:half_side_len/poly_num:half_side_len])
        for(j=[-half_side_len:half_side_len/poly_num:-half_side_len/poly_num])
             if(abs(i)==half_side_len || abs(j)==half_side_len)
                  [i,j]
    ];
    
function cir(radius,poly_num)=[
      for(i=[0:45/poly_num:359])
      [radius*cos(i),radius*sin(i)]    
      ];
       
   
//bezier_curve----------------------------------------------------------------------------
function bezier_curve(p1,p2,t)=
     let(p=(1-t)*[p1.x,p1.y]+(t)*[p2.x,p2.y])
     [p.x,p.y];
function pascal(p,t)=
        pascal_inner(p,len(p),t);
function pascal_inner(p,n,t)=
let(sum_p=[for(i=[0:n-2])
       bezier_curve(p[i],p[i+1],t)])
       n>2? 
       pascal_inner(sum_p,n-1,t):
       sum_p[0];

//---------------------------------------

resolution=0.1;
control_p=[1,1];


function points(p1,p2,control_p)=[p1,control_p,p2];
//Bezier curve
function bezier_curve(p1,p2,t)=
     let(p=(1-t)*[p1.x,p1.y]+(t)*[p2.x,p2.y])
     [p.x,p.y];
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




//-----------------------------------------------------------------
aaa=squ(20,poly_num);
bbb=cir(5,poly_num);



ccc=[for(i=[0:len(aaa)-1])
         for(j=[0:resolution:1])
     pascal(points(aaa[0],bbb[0],control_p),j)];


echo(ccc);


for(i=ccc)
    translate(i)
        sphere(1);




//
//hull(){
//for(i=[0:len(aaa)-1])
//     for(t=[0:resolution:1])
//         translate(pascal(p,t))
//             sphere(1);
//}




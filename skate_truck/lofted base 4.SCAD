//lofted base

squ_h=0;
cir_h=40;

poly_num=10;
function squ(side_len,poly_num,squ_h)=
   let(half_side_len=side_len/2)
   [
     for(i=[0:45/poly_num:45])
        [half_side_len,half_side_len*tan(i),squ_h],
     for(i=[45+45/poly_num:45/poly_num:135])
         i!=90? 
        [half_side_len/tan(i),half_side_len,squ_h]:
        [0,half_side_len,squ_h] 
        ,
     for(i=[135+45/poly_num:45/poly_num:225])
        [-half_side_len,-half_side_len*tan(i),squ_h],
     for(i=[225+45/poly_num:45/poly_num:315])
         i!=270?
        [-half_side_len/tan(i),-half_side_len,squ_h]:
        [0,-half_side_len,squ_h]
      ,
     for(i=[315+45/poly_num:45/poly_num:359])
        [half_side_len,half_side_len*tan(i),squ_h] 
    ];
        
function cir(radius,poly_num,cir_h)=[
      for(i=[0:45/poly_num:359])
      [radius*cos(i),radius*sin(i),cir_h]    
      ];      
      
function bezier_p(point,poly_num)=[
    for(i=[0:45/poly_num:359])
      [r(point)*cos(i)+30,r(point)*sin(i),point.z]]; 
         
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

function points(p1,p2,control_p)=[p1,control_p,p2];


//Bezier curve
function bezier_curve(p1,p2,t)=
     let(p=(1-t)*[p1.x,p1.y,p1.z]+(t)*[p2.x,p2.y,p2.z])
     [p.x,p.y,p.z];
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
aaa=squ(50,poly_num,squ_h);
bbb=cir(20,poly_num,cir_h);

point=[-10,30,10];


function r(point)=
    pow((pow(point.x,2)+pow(point.y,2)),0.5);

xxx=bezier_p(point,poly_num);
ccc=[for(i=[0:len(aaa)-1])
         for(j=[0:resolution:1])
     pascal(points(aaa[i],bbb[i],xxx[i]),j)];

/*

for(i=[0:len(xxx)-1])
    translate(xxx[i])
         sphere(1);
*/

/*
for(i=[0:len(aaa)-1])
    translate(aaa[i])
         sphere(1);

*/

/*
for(i=[0:len(bbb)-1])
    translate(bbb[i])
         sphere(3);
*/

/*

for(i=[0:len(ccc)-1])
    translate(ccc[i])
         sphere(1);



echo(ccc);
*/


/*
//test-----------------------------
hull(){
for(i=[0:11:len(ccc)-1])
    translate(ccc[i])
      sphere(2);
}

hull(){
    for(i=[1:11:len(ccc)-1])
        translate(ccc[i])
            sphere(2);
    }


hull(){
    for(i=[2:11:len(ccc)-1])
        translate(ccc[i])
            sphere(2);
    }
    
    
hull(){
    for(i=[3:11:len(ccc)-1])
       translate(ccc[i])
           sphere(2);
    }

hull(){
    for(i=[10:11:len(ccc)-1])
       translate(ccc[i])
          sphere(2);
       }

//test---------------------------------
*/

module slice(ccc,resolution){
    for(i=[0:1/resolution-1])
        hull(){
            for(j=[i:1/resolution+1:len(ccc)-1])
                 translate(ccc[j])
                    sphere(2);
            
            for(j=[i+1:1/resolution+1:len(ccc)-1])
                 translate(ccc[j])
                      sphere(2);
            }
    }






slice(ccc,resolution);














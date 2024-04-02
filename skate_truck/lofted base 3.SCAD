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
      
function bezier_points(point,poly_num)=[
    for(i=[0:45/poly_num:359])
      [r(point)*cos(i),r(point)*sin(i),point.z]]; 
         
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
squ_p=squ(50,poly_num,squ_h);
cir_p=cir(20,poly_num,cir_h);

control_p=[50,30,20];

function r(point)=
    pow((pow(point.x,2)+pow(point.y,2)),0.5);

bezier_p=bezier_points(control_p,poly_num);
all_p=[for(i=[0:len(cir_p)-1])
         for(j=[0:resolution:1])
     pascal(points(squ_p[i],cir_p[i],bezier_p[i]),j)];

/*
hull(){
for(i=all_p)
    translate(i)
      sphere(0.8);
}

*/



//test-----------------------------------------------------------------
//Find the closest point



function distance(control_p,squ_p,cir_p)=[
     for(i=[0:len(squ_p)-1])
         pow(pow(control_p.x-squ_p[i].x,2)+
              pow(control_p.y-squ_p[i].y,2)+
              pow(control_p.z-squ_p[i].z,2),0.5)+
          pow(pow(control_p.x-cir_p[i].x,2)+
              pow(control_p.y-cir_p[i].y,2)+
              pow(control_p.z-cir_p[i].z,2),0.5)
];

function minimun(list)=
     let(leng=len(list))
     leng<=1? list[0]:
          let(
               pivot=list[0],             
               before=[for(j=1;j<leng;j=j+1) 
               if(list[j]<pivot) 
                    list[j]],
               after=[for(j=1;j<leng;j=j+1)
               if(list[j]>=pivot)
                    list[j]]               
               ) 
     [each minimun(before)];   
                       
function ftn(target_num,list)=
     let(count_num=len(list)-1)
          ftn_inner(target_num,list,count_num);

function ftn_inner(target_num,list,count_num)=
    count_num>0?
     target_num==list[count_num]?
          count_num:
        ftn_inner(target_num,list,count_num-1)
         :[];
         
target_num=minimun(distance(control_p,squ_p,cir_p));
  
 
 closest_num=(ftn(target_num[0],distance(control_p,squ_p,cir_p)));


echo(squ_p[closest_num]);
echo(cir_p[closest_num]);
echo(control_p);
//squ_p[closest_num],cir_p[closest_num],control_p 共平面


distance=pow(pow(control_p.x,2)+pow(control_p.y,2),0.5);


vector=[control_p.x-squ_p[closest_num].x,control_p.y-squ_p[closest_num].y,control_p.z-squ_p[closest_num].z];

function dot_p(v1,v2,idx)=v1[idx]*v2[idx]+(idx>0?dot_p(v1,v2,idx-1):0);


function dot_product(v1,v2)=dot_p(v1,v2,len(v1)-1);

angle=acos(dot_product(vector,[1,0,control_p.z])/(norm(vector)*norm([1,0,control_p.z])));


function distance_xy(control_p,point)=
         pow(pow(control_p.x-point.x,2)+
              pow(control_p.y-point.y,2)+
              pow(control_p.z-point.z,2),0.5);



//processing------------------------------------------------------------
          
function tra(p,fi,theta,point)=
  let (r= 
 [[1,0,0,p.x],  
 [0,1,0,p.y],
 [0,0,1,p.z],
 [0,0,0,1]] 
*
 [[cos(fi),sin(fi),0,0],
 [-sin(fi),cos(fi),0,0],    
 [0,0,1,0],
 [0,0,0,1]]
*
 [[1,0,0,0],
  [0,cos(theta),sin(theta),0],
  [0,-sin(theta),cos(theta),0],
  [0,0,0,1]]
*
[point.x,point.y,0,1]
)[r.x,r.y,r.z]; 






function all_control_p(control_p,distance,angle)=[
      for(i=[0:len(squ_p)-1])
          distance_xy(control_p,cir_p[i])>distance_xy(control_p,squ_p[i])?
                    tra([squ_p[i].x,squ_p[i].y,control_p.z],angle,0,[distance,0]):
                    tra([cir_p[i].x,cir_p[i].y,control_p.z],angle,0,[distance,0])
                    ];
 
 
test_p=all_control_p(control_p,distance,angle);   
 
for(i=[0:len(test_p)-1])
     translate(test_p[i])
         sphere(1);
      
      

//--------------------------------------------------------------------------



echo(distance);
echo(angle);


for(i=[0:len(squ_p)-1])
    translate(squ_p[i])
         sphere(1);
for(i=[0:len(squ_p)-1])
    translate(cir_p[i])
         sphere(1);



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










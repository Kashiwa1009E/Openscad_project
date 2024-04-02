module cube(
p1,
p2,
p1_length,
p1_width,
p2_length,
p2_width,
sup_width,
sup_length,
sup_distance,
sup_angle,


sup_pivot_width,
sup_pivot_length,
sup_pivot_distance,
sup_pivot_angle,
radius,

kinpin_radius,
kinpin_distance,
poly_num,

hanger_pin_length,
pivot_radius,

resolution,

hanger_cenpos_d,

hanger_radius,
hanger_length
)
{   

    
function distance_xy(p1,p2)=
     pow((pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2)),0.5);
function distance_y(p1,p2)=
    p1.y-p2.y;
function distance_x(p1,p2)=
   p2.x-p2.y;
    
//將p1以及p2對齊
function fi(p1,p2)=
p1.x-p2.x==0 && p1.y-p2.y==0?
90:
p1.x-p2.x>0&& p1.y-p2.y>0?
acos(distance_y(p1,p2)/distance_xy(p1,p2)):
p1.x-p2.x==0 && p1.y-p2.y>=0?
acos(distance_y(p1,p2)/distance_xy(p1,p2)):
p1.x-p2.x<0 && p1.y-p2.y>0?
360-(acos(distance_y(p1,p2)/distance_xy(p1,p2))):
p1.x-p2.x<0 && p1.y-p2.y<0?
180-(acos(distance_y(p1,p2)/distance_xy(p1,p2))):
180+(acos(distance_y(p1,p2)/distance_xy(p1,p2)));

function distance_xyz(p1,p2)=
     pow((pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2)+pow(p2.z-p1.z,2)),0.5);
     
function theta(p1,p2)=
p1.y-p2.y==0 && p1.x-p2.x>0?
90-(acos(distance_xy(p1,p2)/distance_xyz(p1,p2))):
p1.y-p2.y==0 && p1.x-p2.x<0?
270+(acos(distance_xy(p1,p2)/distance_xyz(p1,p2))):
p1.x-p2.x==0 && p1.y-p2.y==0?
0:
p1.y-p2.y<0 && p1.z-p2.z<0?
90-(acos(distance_xy(p1,p2)/distance_xyz(p1,p2))):
p1.y-p2.y>0 && p1.z-p2.z<0?
90+(acos(distance_xy(p1,p2)/distance_xyz(p1,p2))):
p1.y-p2.y<0 && p1.z-p2.z>0?
90+(acos(distance_xy(p1,p2)/distance_xyz(p1,p2))):
p1.y-p2.y>0 && p1.z-p2.z>0?
90-(acos(distance_xy(p1,p2)/distance_xyz(p1,p2))):
90+acos(distance_xy(p1,p2)/distance_xyz(p1,p2));

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

//平面四頂點
function offset_points(p,length,width)=[
     for(i=[-width/2+radius:width-2*radius:width/2-radius])
         for(j=[-length/2+radius:length-2*radius:length/2-radius])
              [i,j]];
function p_vertex(p1,p2,theta,p1_length,p1_width)=    
     [for (p1_point = offset_points(p1,p1_length,p1_width))
     let(a=[tra(p1,fi(p1,p2),theta, p1_point)])
     each(a)];
aaa=concat(p_vertex(p1,p2,theta(p1,p2),p1_length,p1_width),
           p_vertex(p2,p1,theta(p2,p1),p1_length,p1_width));
hull(){
for(i=aaa)
    translate(i)
    sphere(radius);
}
function sup_p1(p1,p1_length,sup_length,sup_distance,sup_angle)=[
        p1.x+(p1_length/2-(sup_length/2)),
        p1.y,
        p1.z];
function sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle)=[
        p1.x+(p1_length/2-(sup_length/2+sup_distance*cos(sup_angle))),        
        p1.y,
        p1.z+sin(sup_angle)*sup_distance];
        




//pivot_base_plate--------------------------------------------------------------

function pivot_sup_p1(p1,p1_lenth,sup_length,sup_distance,sup_angle)=[
         p1.x-(p1_length/2-(sup_length/2)),
         p1.y,
         p1.z];
function pivot_sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle)=[
        p1.x-(p1_length/2-(sup_length/2+sup_distance*cos(sup_angle))),
        p1.y,
        p1.z+sin(sup_angle)*sup_distance];           
        



        
//---------------------------------------------------
module support_base(p1,
                    p2,
                    sup_p1,
                    sup_p2,
                    p1_length,
                    sup_length,
                    sup_width,
                    sup_distance,
                    sup_angle
                    ){
sup_points=concat(p_vertex(sup_p1,sup_p2,theta(p2,p1),sup_length,sup_width),
     p_vertex(sup_p2,sup_p1,theta(sup_p1,sup_p2),sup_length*sin(sup_angle),sup_width));

hull(){
    
for(i=sup_points)   
     translate(i)
     sphere(radius);}
}
//--------------------------------------------------

support_base(p1,
             p2,
             sup_p1(p1,p1_length,sup_length,sup_distance,sup_angle),          
             sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle),
             p1_length,
             sup_length,
             sup_width,
             sup_distance,
             sup_angle
             );

% support_base(p1,
             p2,
             pivot_sup_p1(p1,p1_length,sup_pivot_length,sup_pivot_distance,sup_pivot_angle),  
             pivot_sup_p2(p1,p1_length,sup_pivot_length,sup_pivot_distance,sup_pivot_angle),  
             p1_length,
             sup_pivot_length,
             sup_pivot_width,
             sup_pivot_distance,
             sup_pivot_angle
             );
    
    
    
//---kinpin---------------------------------------------------

function kinpin_p1(sup_p2,sup_angle,kinpin_distance)=[
     sup_p2.x-kinpin_distance*cos(sup_angle),
     sup_p2.y,
     sup_p2.z+sin(sup_angle)*kinpin_distance
];

function circle_offset_points(kinpin_radius,poly_num)=[ for(i=[0:360/poly_num:360])
    [kinpin_radius*cos(i),kinpin_radius*sin(i)] 
   ];
function circle_p_vertex(p1,p2,theta,kinpin_radius,poly_num)=    
     [for (p1_point = circle_offset_points(kinpin_radius,poly_num))
     let(a=[(tra(p1,fi(p1,p2),theta,p1_point)),
            (tra(p2,fi(p1,p2),theta,p1_point))])
     each(a)];

module kinpin(p1,p2,kinpin_radius,poly_num){

allpoints=circle_p_vertex(p1,p2,theta(p2,p1),kinpin_radius,poly_num);  
hull(){
for(i=allpoints)
    translate(i)
        sphere(radius);
}
 }
       
 
 kinpin(kinpin_p1(sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle),sup_angle,kinpin_distance),
       sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle),kinpin_radius,
       poly_num);

//bezier_curve
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


module pivot(pivot_sup_p1,
             pivot_sup_p2,
             resolution,
             pivot_radius){

function pivot_offset_points(pivot_radius)=[
     let(pivot_points=[[pivot_radius,0],[pivot_radius,pivot_radius],[0,pivot_radius]])
    for(t=[0:0.1:1])
       pascal(pivot_points,t)
];
    
    //----------------
function pivot_p_vertex(p1,fi,theta,pivot_radius)=    
     [for (p1_point = pivot_offset_points(pivot_radius))
     let(a=[tra([0,0,0],fi,theta, p1_point)])
     each(a)];


fff=(pivot_p_vertex(p1,
     fi(pivot_sup_p1,pivot_sup_p2),
     theta(pivot_sup_p1,pivot_sup_p2)+90,
     pivot_radius));
     
 
// 以空間中任一旋轉軸做旋轉     
     function basis_rot_axis(a_point,b_point)=
     let(norm_p=norm(b_point-a_point))
     [(b_point.x-a_point.x)/norm_p,
     (b_point.y-a_point.y)/norm_p,
     ((b_point.z-a_point.z)/norm_p)];    
 function rot_rnd_axis(a_point,b_point,angle,v)=
     let (n=basis_rot_axis(a_point,b_point))
     let (r=[
  [cos(angle)-pow(n.x,2)*(cos(angle)-1),
  -sin(angle)*n.z-n.x*n.y*(cos(angle)-1),
  sin(angle)*n.y-n.x*n.z*(cos(angle)-1)],
 
  [sin(angle)*n.z-n.x*n.y*(cos(angle)-1),
   cos(angle)-pow(n.y,2)*(cos(angle)-1),
   -sin(angle)*n.x-n.y*n.z*(cos(angle)-1)],
   
   [-sin(angle)*n.y-n.x*n.z*(cos(angle)-1),
    sin(angle)*n.x-n.y*n.z*(cos(angle)-1),
    cos(angle)-pow(n.z,2)*(cos(angle)-1)]
  ]
   *[v.x,v.y,v.z]
   )
   [r.x,r.y,r.z];
     
     
     translate(pivot_sup_p2)
     hull(){
     for(i=[0:20:360])
     for(j=fff)         
         translate(rot_rnd_axis(pivot_sup_p1,
                                pivot_sup_p2,
                                i,
                                j))
              sphere(0.3);
 } 
}

color("red")    
pivot(pivot_sup_p1(p1,p1_length,sup_pivot_length,sup_pivot_distance,sup_pivot_angle),
      pivot_sup_p2(p1,p1_length,sup_pivot_length,sup_pivot_distance,sup_pivot_angle),
      resolution,
      pivot_radius); 




//hanger------------------------------------------------------------------
function hanger_cenpos(sup_p2,sup_angle,hanger_cenpos_d)=
             [sup_p2.x+hanger_cenpos_d*cos(sup_pivot_angle),
              sup_p2.y,
              sup_p2.z+hanger_cenpos_d*sin(sup_pivot_angle)];
function hanger_p1(hanger_cen,hanger_length)=[
     hanger_cen.x,
     hanger_cen.y+hanger_length/2,
     hanger_cen.z
];
function hanger_p2(hanger_cen,hanger_length)=[
    hanger_cen.x,
    hanger_cen.y-hanger_length/2,
    hanger_cen.z
];
module hanger(hanger_p1,
              hanger_p2,
              hanger_radius,
              poly_num){
allpoints=circle_p_vertex(hanger_p1,hanger_p2,theta(hanger_p2,hanger_p1),hanger_radius,poly_num);  
hull(){
for(i=allpoints)
    translate(i)
        sphere(radius); 
}
 }


hanger(
 hanger_p1(
 hanger_cenpos(
   pivot_sup_p2(p1,p1_length,sup_pivot_length,sup_pivot_distance,sup_pivot_angle),
   sup_pivot_angle,
   hanger_cenpos_d),
 hanger_length),
  hanger_p2(
 hanger_cenpos(
   pivot_sup_p2(p1,p1_length,sup_pivot_length,sup_pivot_distance,sup_pivot_angle),
   sup_pivot_angle,
   hanger_cenpos_d),
 hanger_length),

 hanger_radius,
 poly_num
 );





}
cube(
 p1=[0,0,2],
 p2=[0,0,0],
 p1_length=20,
 p1_width=14,
 p2_length=20,
 p2_width=20,
 sup_width=5,
 sup_length=5,
 sup_distance=5,
 sup_angle=50,
//
 sup_pivot_width=5,
 sup_pivot_length=5,
 sup_pivot_distance=5,
 sup_pivot_angle=75,



 radius=0.3,

 kinpin_radius=1,
 kinpin_distance=6,
 poly_num=10,

hanger_pin_length=10,

pivot_radius=1.3,

resolution=5,

hanger_cenpos_d=5,

hanger_radius=1,
hanger_length=35

);
  
     
















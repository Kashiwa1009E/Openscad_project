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

kinpin_radius,
kinpin_distance,
poly_num
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
     for(i=[-width/2:width:width/2])
         for(j=[-length/2:length:length/2])
              [i,j]];
         
function p_vertex(p1,p2,theta,p1_length,p1_width)=    
     [for (p1_point = offset_points(p1,p1_length,p1_width))
     let(a=[tra(p1,fi(p1,p2),theta, p1_point)])
     each(a)];
    



aaa=concat(p_vertex(p1,p2,theta(p1,p2),p1_length,p1_width),p_vertex(p2,p1,theta(p2,p1),p1_length,p1_width));
cubefaces=[
   [2,6,7,3],
   [6,4,5,7],
   [4,5,1,0],
   [0,1,3,2],
   [6,4,0,2],
   [7,5,1,3]
   ]; 

polyhedron(aaa,cubefaces);




//----hole--------------------------------------
union(){
    
    polyhedron(aaa,cubefaces);
   polyhedron(aaa,cubefaces);
    
    }
//-----------------------------------------------

function sup_p1(p1,p1_length,sup_length,sup_distance,sup_angle)=[p1.x+(p1_length/2-(sup_length/2)),
        p1.y,
        p1.z];
function sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle)=[
        p1.x+(p1_length/2-(sup_length/2+sup_distance*cos(sup_angle))),        
        p1.y,
        p1.z+sin(sup_angle)*sup_distance];
        
function oppsite_sup_p1(p1,p1_lenth,sup_length,sup_distance,sup_angle)=[
         p1.x-(p1_length/2-(sup_length/2)),
         p1.y,
         p1.z];
function oppsite_sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle)=[
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
                    sup_angle,
                    cubefaces){
sup_points=concat(p_vertex(sup_p1,sup_p2,theta(p2,p1),sup_length,sup_width),
     p_vertex(sup_p2,sup_p1,theta(sup_p1,sup_p2),sup_length*sin(sup_angle),sup_width));
polyhedron(sup_points,cubefaces);}

//--------------------------------------------------
support_base(p1,
             p2,
             sup_p1(p1,p1_length,sup_length,sup_distance,sup_angle),          
             sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle),
             p1_length,
             sup_length,
             sup_width,
             sup_distance,
             sup_angle,
             cubefaces);

support_base(p1,
             p2,
             oppsite_sup_p1(p1,p1_length,sup_length,sup_distance,sup_angle),  
             oppsite_sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle),  
             p1_length,
             sup_length,
             sup_width,
             sup_distance,
             sup_angle,
             cubefaces);





//---kinpin---------------------------------------------------

function kinpin_p1(sup_p2,sup_angle,kinpin_distance)=[
     sup_p2.x-kinpin_distance*cos(sup_angle),
     sup_p2.y,
     sup_p2.z+sin(sup_angle)*kinpin_distance
];


module kinpin(p1,p2,kinpin_radius,poly_num){

function circle_offset_points(kinpin_radius,poly_num)=[ for(i=[0:360/poly_num:360])
    [kinpin_radius*cos(i),kinpin_radius*sin(i)] 
   ];
function top_bottom(poly_num)=
    [for(i=[1:poly_num*2-5])
     if (i%2!=0)  
    let( 
    a=[[1,i+2,i+4],
      [2,i+3,i+5]])
     each a];
circle_cubefaces=[for(i=[1:poly_num*2])
    i==poly_num*2-1?
    [i,i+1,1]:
    i==poly_num*2?
    [i,1,2]:
    [i,i+1,i+2]];


function circle_p_vertex(p1,p2,theta,kinpin_radius,poly_num)=    
     [for (p1_point = circle_offset_points(kinpin_radius,poly_num))
     let(a=[(tra(p1,fi(p1,p2),theta,p1_point)),
            (tra(p2,fi(p1,p2),theta,p1_point))])
     each(a)];
allpoints=circle_p_vertex(p1,p2,theta(p2,p1),kinpin_radius,poly_num);  
Allface=concat(circle_cubefaces,top_bottom(poly_num));
polyhedron(allpoints,Allface);  
 }


       kinpin(kinpin_p1(sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle),sup_angle,kinpin_distance),
       sup_p2(p1,p1_length,sup_length,sup_distance,sup_angle),   kinpin_radius,
       poly_num);


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
 sup_angle=60,

 kinpin_radius=1,
 kinpin_distance=6,
 poly_num=360

 );

 



 
     

 
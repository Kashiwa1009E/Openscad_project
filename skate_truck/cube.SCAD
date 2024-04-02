module cube(
p1,
p2,
p1_length,
p1_width,
p2_length,
p2_width,
support_base
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
p1.x-p2.x==0 && p1.y-p2.y==0?
0:
p1.y-p2.y==0?
90-(acos(distance_xy(p1,p2)/distance_xyz(p1,p2))):

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
         
         
function vertex(p1,p2,p1_length,p1_width,p2_length,p2_width)=    
     [for (p1_point = offset_points(p1,p1_length,p1_width))
     let(a=[tra(p1,fi(p1,p2),theta(p1,p2),p1_point)])
     each(a),
     for(p2_point= offset_points(p2,p2_length,p2_width))
     let(b=[tra(p2,fi(p2,p1),theta(p2,p1),p2_point)]) 
     each (b)];
aaa=vertex(p1,p2,p1_length,p1_width,p2_length,p2_width);
 cubefaces=[
   [2,6,7,3],
   [6,4,5,7],
   [4,5,1,0],
   [0,1,3,2],
   [6,4,0,2],
   [7,5,1,3]
   ];  
     
     
polyhedron(aaa,cubefaces);  
 };     
     

cube(
 p1=[7.5,10,2],
 p2=[5,-3,5],
 p1_length=5,
 p1_width=5,
 p2_length=5,
 p2_width=5,
 support_base=5
 );    
 
 
     

 
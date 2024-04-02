p1=[10,0,-10];
p2=[0,0,10];

function distance_xy(p1,p2)=
     pow((pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2)),0.5);
function distance_y(p1,p2)=
    p1.y-p2.y;


function distance_x(p1,p2)=
   p2.x-p2.y;
   
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


function tra(p,fi,theta,thickness,point)=
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
)
[r.x,r.y,r.z]; 



function offset_points(thickness,poly_num)=[ for(i=[0:360/poly_num:360])
    [thickness*cos(i),thickness*sin(i)] 
   ];
  
    
function vertex(p1,p2,offset_points)=
   [for (point = offset_points)
     let(a=[(tra(p1,fi(p1,p2),theta(p1,p2),6,point)),
     (tra(p2,fi(p2,p1),theta(p1,p2),6,point))])
     each a   
   ];
   
   
poly_num=360;   
allpoints=vertex(p1,p2,offset_points(10,poly_num));

   
 cubefaces=[for(i=[1:poly_num*2])
    i==poly_num*2-1?
    [i,i+1,1]:
    i==poly_num*2?
    [i,1,2]:
    [i,i+1,i+2]];
;

Allface=concat(cubefaces,top_bottom(poly_num));

polyhedron(allpoints,Allface);  
    
function top_bottom(poly_num)=
    [for(i=[1:poly_num*2-5])
     if (i%2!=0)  
    let( 
    a=[[1,i+2,i+4],
      [2,i+3,i+5]])
     each a];



 








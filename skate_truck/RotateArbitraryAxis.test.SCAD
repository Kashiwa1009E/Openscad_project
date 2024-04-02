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
   
p1=[10,1,30];
p2=[20,20,20];
v=[10,10,20];
n_vector=basis_rot_axis(p1,p2);
echo(n_vector);
color("red")
hull(){  
    translate(30*n_vector)
    sphere(1.5);
    translate([0,0,0])
    sphere(1.5);
    }
hull(){
for (i=[0:10:360])   
translate(rot_rnd_axis(p1,p2,i,v))
    sphere(1);
translate(p1)
sphere(1);
}
color("green")
hull(){
translate(p1)
    sphere(1);
translate(p2)
    sphere(1);    
    }
hull(){
    translate(v)
    sphere(1);
    translate(p1)
    sphere(1);
    }   
    
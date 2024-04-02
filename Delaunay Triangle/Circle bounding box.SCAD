// circle bounding box

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=100;
points_num=4;

points=[
for(i=[0:points_num]
    )
    [rnd_v(init_value,end_value),
     rnd_v(init_value,end_value)
    ]];
for(i=points)
    translate(i)
        sphere(3);


function make_circle(points)=
     let(c=undef)
     let(init=0)
     let(leng=len(points)-1)

     points[init]==undef? []:
     let(p=points[init])
     let(c_=[[p],0])
     make_circle_inner(init+1,leng,c_,p,points)

function make_circle_inner(init,leng,c,p,points)
     init>leng? c:
     let(q=points[init])
     is_in_circle(c,p)==true?
     make_circle_inner(init+1,leng,c,points):
     //is_in_circle(c,p)==false
     let(c=make_diameter(p,q))
     
     
     //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     
function _make_circle_one_point(points,c,p,index)

      

  
/*
---------------------------------
c=[[ox,oy],r]
[ox,oy]→circumcircle,r→radius       
input:c,p
output:true or false
---------------------------------
*/
function is_in_circle(c,p)=
     hypo(c[0].x-p.x,c[0].y-p.y)<=c[1]?
     true:
     false;
          
function hypo(x,y)=
     pow(pow(x,2)+pow(y,2),0.5);       
       
       
       
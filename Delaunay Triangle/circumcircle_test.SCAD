function make_circumcircle(p1,p2,p3)=
    let(ox=(min(p1.x,p2.x,p3.x)+max(p1.x,p2.x,p3.x))/2)
    let(oy=(min(p1.y,p2.y,p3.y)+max(p1.y,p2.y,p3.y))/2)
    [ox,oy];

function circumcircle(p1,p2,p3)=
    let(ox=(min(p1.x,p2.x,p3.x)+max(p1.x,p2.x,p3.x))/2)
    let(oy=(min(p1.y,p2.y,p3.y)+max(p1.y,p2.y,p3.y))/2)
    let(p1x=p1.x-ox,p1y=p1.y-oy,
        p2x=p2.x-ox,p2y=p2.y-oy,
        p3x=p3.x-ox,p3y=p3.y-oy)
    let(d=p1x*(p2y-p3y)+p2x*(p3y-p1y)+p3x*(p1y-p2y)*2)
        d==0?
        undef:
    let(x=ox+((p1x*p1x+p1y*p1y)*(p2y-p3y)+(p2x*p2x+p2y*p2y)*(p3y-p1y)+(p3x*p3x+p3y*p3y)*(p1y-p2y))/d)
    let(y=oy+((p1x*p1x+p1y*p1y)*(p3x-p2x)+(p2x*p2x+p2y*p2y)*(p1x-p3x)+(p3x*p3x+p3y*p3y)*(p2x-p1x))/d)    
    let(rp1=hypot(x-p1.x,y-p1.y),
        rp2=hypot(x-p2.x,y-p2.y),
        rp3=hypot(x-p3.x,y-p3.y))
    [[x,y],max(rp1,rp2,rp3)];

function hypot(x,y)=
     pow(pow(x,2)+pow(y,2),0.5);

       
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);
     
init_value=0;
end_value=100;

p1=[rnd_v(init_value,end_value),rnd_v(init_value,end_value)];
p2=[rnd_v(init_value,end_value),rnd_v(init_value,end_value)];
p3=[rnd_v(init_value,end_value),rnd_v(init_value,end_value)];     
  
c=circumcircle(p1,p2,p3);

for(i=[c[0],p1,p2,p3])
         if(i==c[0])
    translate(i)
            color("red")
                sphere(3);
         else
    translate(i)
         sphere(3);
         
         
echo(p1,p2,p3,c[0]);         
         
for(i=[0:360])
     translate([c[0].x+sin(i)*c[1],c[0].y+cos(i)*c[1]])
         color("blue")
         sphere(1);
              
         
         
         
         
         
         
         
         

//The centroid of a triangle

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

module draw_line(p1,p2,thickness,fn=4){
    $fn=fn;
    
    hull(){
        translate(p1)sphere(thickness/2);
        translate(p2)sphere(thickness/2);
        } 
    }
    
module polyline_3D(points,thickness,fn=4){
    module polyline3D_inner(points,index){
         if (index<len(points)){
             draw_line(points[index-1],points[index],thickness,fn);
             polyline3D_inner(points,index+1);
         }  
         else if(index==len(points)){
             draw_line(points[index-1],points[0],thickness,fn);}
    }
    polyline3D_inner(points,1);
}


   

function p(init_v,end_v)=[
     [rnd_v(init_v,end_v),rnd_v(init_v,end_v)],
     [rnd_v(init_v,end_v),rnd_v(init_v,end_v)],
     [rnd_v(init_v,end_v),rnd_v(init_v,end_v)]];


function all_point(init_v,end_v)=
     let(points=p(init_v,end_v))
     let (m1=(points.y.y-points.x.y)/(points.y.x-points.x.x))
     let(m2=(points.z.y-points.y.y)/(points.z.x-points.y.x))
      points.x==points.y==points.z ||
      points.x==points.y ||
      points.y==points.z ||
      points.z==points.x ||
      points.x.x==points.y.x==points.z.x?
      all_point(init_v,end_v):
      points.x.x==points.y.x||
      points.y.x==points.z.x||
      points.z.x==points.x.x?
      points:
      m1==m2?
      all_point(init_v,end_v):
      points;
      
    
function centroid(points)=
     [(points.x.x+points.y.x+points.z.x)/3,
      (points.x.y+points.y.y+points.z.y)/3,
     ];



points=(all_point(0,10));
test=centroid(points);

for(i=points)
    draw_line(i,test,0.1,fn=4);


polyline_3D(points,0.1,fn=4);



















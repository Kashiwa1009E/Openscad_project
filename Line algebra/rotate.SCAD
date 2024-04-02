
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
    }
    polyline3D_inner(points,1);
}


//---------------------------------------------
function rotate_x(vt,angle)=
     let(
     r=
     [
     [1,0,0],
     [0,cos(angle),sin(angle)],
     [0,-sin(angle),cos(angle)]
     ]*
     [vt.x,vt.y,vt.z]
)
  [r.x,r.y,r.z];




points=[[0,0,0],[0,9,9]];
polyline_3D(points,1,4);


test_points=[[0,0,0],rotate_x([0,9,9],30)];
polyline_3D(test_points,1,4);












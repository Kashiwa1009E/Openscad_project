
p1=[1,2,3];

p2=[6,6,9];


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
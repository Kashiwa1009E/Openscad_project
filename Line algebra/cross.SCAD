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




a_vector=[0,2,6];
a_point=[[0,0,0],a_vector];

polyline_3D(a_point,1,4);


b_vector=[0,5,6];
b_point=[[0,0,0],b_vector];

polyline_3D(b_point,1,4);


cross_vector=[[0,0,0],cross(a_vector,b_vector)];

polyline_3D(cross_vector,1,4);








// 歐拉角

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



function matrix(vt,angle)=
     let(
         r=
            


           // [[1,0,0],
           // [0,cos(angle),sin(angle)],
           //  [0,-sin(angle),cos(angle)]]
        // *
        [[cos(angle),sin(angle),0,10],
          [-sin(angle),cos(angle),0,10],
          [0,0,1,10],
          [0,0,0,1]
         ]*
         //[[cos(angle),0,-sin(angle),0],
          //[0,1,0,0],
          //[sin(angle),0,cos(angle),0],
          //[0,0,0,1]]
      
       
       
          //[[1,0,0,10],
          //[0,1,0,10],
          //[0,1,0,10],
          //[0,0,0,1]]
            //   *
     [vt.x,vt.y,vt.z,1]
     )
     [r.x,r.y,r.z];
     
 

points=[for(i=[0:360])
       matrix([5,5,0],i)    
];

polyline_3D(points,5,10);

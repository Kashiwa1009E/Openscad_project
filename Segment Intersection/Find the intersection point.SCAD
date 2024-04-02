

//Find the intersection point of two segements

segement_a=[[1,3],[60,55]];

segement_b=[[45,10],[19,34]];
thickness=3;

module draw_line(p1,p2,thickness,fn=4){
    $fn=fn;    
    hull(){
        translate(p1)sphere(thickness/2);
        translate(p2)sphere(thickness/2);
        } }

segements=[segement_a,segement_b];


for(i=segements)
    draw_line(i[0],i[1],thickness,4);


function dot(v1,v2)=
    v1.x*v2.x+v1.y*v2.y;
    
function cross_(v1,v2)=
    v1.x*v2.y-v1.y*v2.x;


function intersection_point(segement_a,segement_b)=
    let(base_a=segement_a[1]-segement_a[0])
    let(side_ab=[segement_b[0].x-segement_a[0].x,segement_b[0].y-segement_a[0].y])
    let(side_b=segement_b[1]-segement_b[0])
    let(area_a=abs(cross_(base_a,side_ab)))
    let(area_b=abs(cross_(base_a,side_b))-area_a)
    let(x=(area_a*segement_b[1].x+area_b*segement_b[0].x)/(area_a+area_b))
    let(y=(area_a*segement_b[1].y+area_b*segement_b[0].y)/(area_a+area_b))
    [x,y];
   
test=intersection_point(segement_a,segement_b);
echo(test);

translate(test)
    color("red")
        sphere(3);
  
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   


/*
Determine whether two segements intersect.

1.共線段
2.非共線段
*/
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);
init_value=0;
end_value=200;
segement_a=[[rnd_v(init_value,end_value),rnd_v(init_value,end_value)],[rnd_v(init_value,end_value),rnd_v(init_value,end_value)]];
segement_b=[[rnd_v(init_value,end_value),rnd_v(init_value,end_value)],[rnd_v(init_value,end_value),rnd_v(init_value,end_value)]];
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

function seg_inters_compare(line_a,line_b)=
    cross_(line_b[1]-line_b[0],line_a[1]-line_b[0])>=0 &&
    cross_(line_b[1]-line_b[0],line_a[0]-line_b[0])<=0 ||
    cross_(line_b[1]-line_b[0],line_a[1]-line_b[0])<=0 &&
    cross_(line_b[1]-line_b[0],line_a[0]-line_b[0])>=0 ?   
    (cross_(line_a[0]-line_b[1],line_a[1]-line_b[1])>0 &&
    cross_(line_a[0]-line_b[0],line_a[1]-line_b[0])<0) ||
    (cross_(line_a[0]-line_b[1],line_a[1]-line_b[1])<0 &&
    cross_(line_a[0]-line_b[0],line_a[1]-line_b[0])>0)? 
    true:    
    false:false;
    
    
echo(seg_inters_compare(segement_a,segement_b));    
    

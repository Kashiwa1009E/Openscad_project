//Segement intersection 


line_a=[[-10,0],[10,0]];

line_b=[[-10,-5],[29,10]];

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
    
    
echo(seg_inters_compare(line_a,line_b));    
    
for(i=concat(line_a,line_b))
    translate(i)        
        sphere(3);









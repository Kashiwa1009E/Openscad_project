module cube(
v1,
v2,
v1_square_length,
v1_square_width,
v2_square_length,
v2_square_width,

sup_length,
sup_width,
sup_hight,
sup_angle,

oppsite_sup_length,
oppsite_sup_width,
oppsite_sup_hight,
oppsite_sup_angle,


kinpin_radius,
kinpin_hight,
poly_num



){
z_axis=[0,0,1];
y_axis=[0,1,0];
//求出內積
 function dot_p(v1,v2,index)=      
      v1[index]*v2[index]+
      (index>0?
       dot_p(v1,v2,index-1):0);      
function dot_product(v1,v2)=
     dot_p(v1,v2,len(v1)-1);
//求出法向量
function normal_v(v1,v2)=[v2.x-v1.x,v2.y-v1.y,v2.z-v1.z];
echo(normal_v(v1,v2));
//求出法向量在xy平面投影向量 
function dot_product_xy(v)=[v.x,v.y,0];
//利用內積求出角度
function angle(v1,v2)=
     norm(v1)==0 || norm(v2)==0?
     0:
     acos((dot_product(v1,v2))/(norm(v1)*norm(v2)));
//xy平面投影法向量與y軸角度
echo(angle(dot_product_xy(normal_v(v1,v2)),y_axis));


hull(){
    translate(v1)
rotate(angle(normal_v(v1,v2),z_axis),cross(z_axis,normal_v(v1,v2)))
rotate(angle(dot_product_xy(normal_v(v1,v2)),y_axis),z_axis)
    linear_extrude(.1)
square([v1_square_width,v1_square_length],center=true);
translate(v2)
rotate(angle(normal_v(v1,v2),z_axis),cross(z_axis,normal_v(v1,v2)))
rotate(angle(dot_product_xy(normal_v(v1,v2)),y_axis),z_axis)
    linear_extrude(.1)
square([v2_square_width,v2_square_length],center=true);
}


sup_v1=([v2.x,v2.y+v2_square_length/2-sup_length/2,v2.z]);
sup_v2=([v2.x,v2.y+(v2_square_length/2-(sup_length/2+sup_hight*cos(sup_angle))),v2.z+sin(sup_angle)*sup_hight]);
hull(){

translate(sup_v1)
rotate(angle(normal_v(v1,v2),z_axis),cross(z_axis,normal_v(v1,v2)))
rotate(angle(dot_product_xy(normal_v(v1,v2)),y_axis),z_axis)
    linear_extrude(.1)
    square([sup_width,sup_length],center=true);

translate(sup_v2) 
     rotate(angle(normal_v(sup_v1,sup_v2),z_axis),cross(z_axis,normal_v(sup_v1,sup_v2)))     
     rotate(angle(dot_product_xy(normal_v(sup_v1,sup_v2)),y_axis),z_axis)
     linear_extrude(.1)
     square([sup_width,sup_length*sin(180-sup_angle)],center=true);
}

//--------------------------------------------------------------
oppsite_sup_v1=([v2.x,
                v2.y-(v2_square_length/2-oppsite_sup_length/2),
                v2.z]);
oppsite_sup_v2=([v2.x,
                v2.y-(v2_square_length/2-(oppsite_sup_length/2+oppsite_sup_hight*cos(oppsite_sup_angle))),
               v2.z+sin(oppsite_sup_angle)*oppsite_sup_hight]);


hull(){
translate(oppsite_sup_v1)
rotate(angle(normal_v(v1,v2),z_axis),cross(z_axis,normal_v(v1,v2)))
rotate(angle(dot_product_xy(normal_v(v1,v2)),y_axis),z_axis)
    linear_extrude(.1)
    square([oppsite_sup_width,oppsite_sup_length],center=true);


translate(oppsite_sup_v2)
     rotate(angle(normal_v(oppsite_sup_v1,oppsite_sup_v2),z_axis),cross(z_axis,normal_v(oppsite_sup_v1,oppsite_sup_v2)))     
     rotate(angle(dot_product_xy(normal_v(oppsite_sup_v1,oppsite_sup_v2)),y_axis),z_axis)
     linear_extrude(.1)
     square([oppsite_sup_width,oppsite_sup_length*sin(180-oppsite_sup_angle)],center=true);
}



//  kinpin--------------------------------------------------------



kinpin_v1=[sup_v2.x,
           sup_v2.y-kinpin_hight*cos(sup_angle),
           sup_v2.z+sin(sup_angle)*kinpin_hight
];



   hull(){

    translate(sup_v2)
    rotate(angle(normal_v(sup_v2,kinpin_v1),z_axis),cross(z_axis,normal_v(sup_v2,kinpin_v1)))
    rotate(angle(dot_product_xy(normal_v(sup_v2,kinpin_v1)),y_axis),z_axis)
    linear_extrude(.1)
    circle(kinpin_radius);
    
    translate(kinpin_v1)
    rotate(angle(normal_v(sup_v2,kinpin_v1),z_axis),cross(z_axis,normal_v(sup_v2,kinpin_v1)))
    rotate(angle(dot_product_xy(normal_v(sup_v2,kinpin_v1)),y_axis),z_axis)
    linear_extrude(.1)
    circle(kinpin_radius);
     
   }
   
   
    
    






}

cube(
v1=[0,0,0],
v2=[0,0,3],
v1_square_length=18.5,
v1_square_width=13.5,
v2_square_length=18,
v2_square_width=13,


sup_length=5,
sup_width=4,
sup_hight=5,
sup_angle=70,


oppsite_sup_length=5,
oppsite_sup_width=5,
oppsite_sup_hight=5,
oppsite_sup_angle=70,


kinpin_radius=1,
kinpin_hight=6,
poly_num=360


);


    
    
    
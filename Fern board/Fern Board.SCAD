
width=214;
length=272.7;
hight=18;



margin_width=9.6;
margin_length= 9.6;
cube_width=(width-5*margin_width)/4;
cube_length=(length-6*margin_width)/5;


difference(){
union(){
difference(){
cube([width,length,hight]);
    for(i=[margin_width:margin_width+cube_width:4*(margin_width+cube_width)])
        
         for(j=[margin_length:margin_length+cube_length:5*(margin_length+cube_length)] 
            )
        
    translate([i,
           j,
           -20])
           
     color("red")      
     cube([cube_width,cube_width,50]);   
    }


margin_length= 9.8;
second_hight=8;
second_margin_width=2.8;
second_cube_width=(cube_width-2*second_margin_width)/3;     

for(i=[0:cube_width+margin_width:4*cube_width+margin_width])
    for(j=[0:cube_length+margin_length:5*cube_length+margin_length])
translate([i,j,2])    
    
difference(){
    cube([cube_width+2*margin_width,
          cube_width+2*margin_length,
           second_hight]);
    
    for(i=[margin_width:
           second_margin_width+second_cube_width:
        3*(second_margin_width+second_cube_width)])
    
    for(j=[margin_width:
           second_margin_width+second_cube_width:
           3*(second_margin_width+second_cube_width)])
     
    translate([i,j,-20])    
    cube([second_cube_width,
          second_cube_width,
          50])    
    ;
  
  }
} 
    
translate([-1,length/2,hight/2])
rotate([0,90,0])    
cylinder(h=15,r=2.5);  


 translate([width-10,length/2,hight/2])
    rotate([0,90,0])
    cylinder(h=15,r=2.5);

translate([2*margin_width+1.5*cube_width,10,hight/2])    
rotate([90,0,0])
cylinder(h=15,r=2.5);   
    
translate([width-(2*margin_width+1.5*cube_width),10,hight/2])
rotate([90,0,0])
    cylinder(h=15,r=2.5);
    

    }

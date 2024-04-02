function flip_coin()=round(rands(0,1,1)[0])+1;

    
    module line(
    v1,
    v2,
    thickness,
    height=5
) {
    vectors = concat([v1],[v2]);
   
    for(vector=vectors)
    translate(vector)
    linear_extrude(height)
    circle(r=thickness/2,$fn=50);
     
    
    angle = atan((v2[1]-v1[1])/(v2[0]-v1[0]));
    offset = [[(thickness/2)*cos(90-angle), -((thickness/2)*sin(90-angle))],
              [-((thickness/2)*cos(90-angle)), (thickness/2)*sin(90-angle)]];
    points = [for (i=[0:1])
                for (j=[0:1])
                    i==0 ?
                    vectors[i]+offset[j] : vectors[i]-offset[j]];
    linear_extrude(height)
    polygon(points);
}

module liner(points,thickness){
     idx=0;        
     module liner_inner(points,idx){
         if (idx<(len(points)-1)){
              line(points[idx],points[idx+1],thickness);
            
           liner_inner(points,idx+1);}
 }
     liner_inner(points,idx);
}




no_wall=0;
up_wall=1;
right_wall=2;
up_right_wall=3;


function block_data(x,y,walltype)=[x,y,walltype];
function get_x(block_data)=block_data[0];
function get_y(block_data)=block_data[1];
function get_walltype(block_data)=block_data[2];



module draw_block(walltype,block_width,wall_thickness){
        if(walltype==up_wall || walltype==up_right_wall){
            
            liner([[0,block_width],[block_width,block_width]],wall_thickness);
            }
            
        if(walltype==right_wall||walltype==up_right_wall){
            
            liner([[block_width,block_width],[block_width,0]],wall_thickness);
            }
    }
    
    
    module draw_maze(rows,columns,block_width,wall_thickness){
        
   function initialize()=[for(i=[rows:-1:1])
                               for(j=[1:columns])
                                    [j,i,false]];  
    
                               
  /*aaa=(                
    for(i=[1:rows])                          
     [ for(i=[1:columns])
       flip_coin()]);       
    echo(aaa);       
    */
   
   
    blocks=[for( point=initialize())
           (point[1]==rows && point[0]==columns)?
            [point[0],point[1],3]:
            point[1]==rows?
           [point[0],point[1],1]:
           point[0]==columns?
           [point[0],point[1],2]:
           [point[0],point[1],flip_coin()]
          ];

        for(block=blocks){
           translate([get_x(block)-1,get_y(block)-1]*block_width)
             draw_block(
                  get_walltype(block),
                  block_width,
                  wall_thickness            
            ) ;   
            }
        
        liner([[0,0],[block_width*columns,0]],wall_thickness);
        liner([[0,0],[0,block_width*rows]],wall_thickness);     
              
     
  //-----------BASE--------------
   hole_positions=[for(i=[0:columns-1])
                  for(j=[0:rows-1])
                      [i,j]
            ];
   echo(hole_positions);
   echo(rand_hole_pos);         
   rand_hole_pos=round(rands(0,len(hole_positions)-1,1)[0]);
    
 
   
   echo([block_width/2,block_width/2])      
          
                  
            //------------base----------------------- 
               /*   
           difference(){
        linear_extrude(height=1)
             square([columns*block_width,rows*block_width]);
    
               
            
       translate([block_width/2+hole_positions[rand_hole_pos][0]*block_width,
    block_width/2+hole_positions[rand_hole_pos][1]*block_width,-1])
         linear_extrude(height=5)
             square([block_width-wall_thickness,block_width-wall_thickness],center=true);
             */
              
              //-------------------------
        linear_extrude(height=1)
             square([columns*block_width,rows*block_width]);
    
               
            /*
       translate([block_width/2+hole_positions[rand_hole_pos][0]*block_width,
    block_width/2+hole_positions[rand_hole_pos][1]*block_width,-1])
         linear_extrude(height=5)
             square([block_width-wall_thickness,block_width-wall_thickness],center=true);
           */
   //------------------------------- 
        }
   
        
        
draw_maze(10,10,3,1);
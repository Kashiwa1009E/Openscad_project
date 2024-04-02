no_wall=0;
right_wall=1;
down_wall=2;
down_right_wall=3;

columns=10;
rows=10;
    
function block_data(x,y,walltype)=[x,y,walltype];
function get_x(block_data)=block_data[0];
function get_y(block_data)=block_data[1];
function get_walltype(block_data)=block_data[2];

//-----------------------------------------------------------------

function rnd(count_start,columns)=round(rands(count_start,columns-1,1)[0]);
count_start=0;
random_num=rnd(count_start,columns);
function rnd_num(count_start,random_num,columns)=
     random_num>=columns-1?[random_num]:
     concat(random_num,rnd_num((random_num+1),rnd(random_num+1,columns),columns));
     
list=concat(0,(rnd_num(count_start,random_num,columns)));

function from_to(from,to)=
    from ==to?[to]:
    concat(from,from_to(from+1,to));
    
function extend_list(count_start,list)=
          count_start==len(list)-1? 
                []:
          concat(count_start==0?
                 [from_to(list[count_start],list[count_start+1])]:
                 [from_to(list[count_start]+1,list[count_start+1])],
                 extend_list(count_start+1,list));        
pos_list=extend_list(count_start,list);


//-----------------------------------------------------

start_value=0;

function switch_to_type(
         count_start,
         rnd_num,
         start_value,
         pos_list)=
        len(pos_list[start_value])-1 !=rnd_num?
        count_start==len(pos_list[start_value])-1?
        [3]:
        concat(count_start==rnd_num?[0]:[2],switch_to_type(count_start+1,rnd_num,start_value,pos_list)):
        //------------------------------------------------
        count_start==len(pos_list[start_value])-1?
        [1]:
        concat([2],switch_to_type(count_start+1,rnd_num,start_value,pos_list));
      
      
//-------------------------------------------------------------------
function type_list(count_start,start_value,pos_list)=
    start_value==len(pos_list)-1? 
    switch_to_type(
    count_start,
    rnd(0,len(pos_list[start_value])),
    start_value,
    pos_list):
    
concat(switch_to_type(count_start,
                      rnd(0,len(pos_list[start_value])),
                      start_value,
                      pos_list),
                      
      type_list(count_start,start_value+1,pos_list));

//------------------------------------------------------------------------
initial_value=0;

echo(rows);

function block_type_list(count_start,start_value,initial_value,rows)=
     initial_value==rows-1?
     type_list(count_start,start_value,pos_list):
     
     concat(type_list(count_start,start_value,pos_list),
     block_type_list(count_start,start_value,initial_value+1,rows));
//---------------------------------

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

//-------------------------------------
module liner(points,thickness){
     idx=0;        
     module liner_inner(points,idx){
         if (idx<(len(points)-1)){
              line(points[idx],points[idx+1],thickness);
            
           liner_inner(points,idx+1);}
 }
     liner_inner(points,idx);
}

//------------------------------------


module draw_block(walltype,block_width,wall_thickness){
        if(walltype==2 ){
            liner([[0,0],[block_width,0]],wall_thickness);
            }
        if(walltype==1){
            liner([[block_width,0],[block_width,block_width]],wall_thickness);
            }
        if (walltype==3){
            liner([[0,0],[block_width,0]],wall_thickness);
            liner([[block_width,0],[block_width,block_width]],wall_thickness);
            }
    }




block_type_list=block_type_list(count_start,start_value,initial_value,rows);

echo(len(block_type_list));
//-------------------------------------------------------------------
   
module draw_maze(rows,columns,block_width,wall_thickness){
        
         start_maze=[for(i=[rows:-1:1])
                               for(j=[1:columns])
                                    [j,i]];  
         len_block_type_list=len(block_type_list);
    
    
          function blocks(count_start,start_maze,block_type_list)=
          count_start==len_block_type_list-1?
          [concat(start_maze[count_start],block_type_list[count_start])]:
          
          concat([concat(start_maze[count_start],block_type_list[count_start])],
          blocks(count_start+1,start_maze,block_type_list)
          );
          
          echo(blocks(count_start,start_maze,block_type_list));
              
                           
                           
        for(block=blocks(count_start,start_maze,block_type_list)){
           translate([get_x(block)-1,get_y(block)-1]*block_width)
             draw_block(
                  get_walltype(block),
                  block_width,
                  wall_thickness            
            ) ;   
            }  
        
echo(block_type_list(count_start,start_value,initial_value,rows));

                          
  liner([[0,0],[0,block_width*rows]],wall_thickness);
        liner([[0,block_width*rows],[block_width*columns,block_width*rows]],wall_thickness);  
        }
        
draw_maze(columns,rows,3,1);
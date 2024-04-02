//aldous-broder 


no_wall=0;
right_wall=1;
up_wall=2;
up_right_wall=3;


/*
east=0;
north=1;
west=2;
south=3;
*/
function rnd(start_num,end_num)=round(rands(start_num,end_num,1)[0]);




function starting_point(columns,rows)=
[rnd(0,columns-1),rnd(0,rows-1)];

function get_x(list)=list[0];
function get_y(list)=list[1];
function get_wall_type(list)=list[2];
function get_type(list)=list[3];


function block_data(x,y,walltype)=[x,y,walltype];


function indexOf(x,y,maze,i=0)=
    i>len(maze)?-1:(
    [get_x(maze[i]),get_y(maze[i])]==[x,y]?i:
    indexOf(x,y,maze,i+1)
    );

function starting_maze(columns,rows)=[
      for(i=[0:columns-1])
          for(j=[0:rows-1])
      [j,i,up_right_wall,false]
];


function visited(x,y,maze)=maze[indexOf(x,y,maze)][3];

    
function set_visited(x,y,maze)=[
          for(b=maze)
              [x,y]==[get_x(b),get_y(b)]?
                   [x,y,get_wall_type(b),true]:b
          ];

function visitable(x,y,maze,columns,rows)=
     y>=0 && y<rows &&
     x>=0 && x<columns;


function sum(list)=
      let(leng=len(list))
      leng==1?list[0]:
      leng==2?list[0]+list[1]:
      let( 
          sum_first=list[0]+list[1],
          sum_after=[for(i=[2:leng-1])
              list[i]])    
      sum(concat(sum_first,sum_after));
          
function rand_dirs()=
     [
       [0,1,2,3],
       [0,1,3,2],
       [0,2,1,3],
       [0,2,3,1],
       [0,3,1,2],
       [0,3,2,1],
       [1,0,2,3],
       [1,0,3,2],
       [1,2,0,3],
       [1,2,3,0],
       [1,3,0,2],
       [1,3,2,0],
       [2,0,1,3],
       [2,0,3,1],
       [2,1,0,3],
       [2,1,3,0],
       [2,3,0,1],
       [2,3,1,0],
       [3,0,1,2],
       [3,0,2,1],
       [3,1,0,2],
       [3,1,2,0],
       [3,2,0,1],
       [3,2,1,0]       
          ][rnd(0,23)];          


function all_visited(maze)=[
         for(i=[0:len(maze)-1])
         get_type(maze[i])==true? 0:1
         ];

function next_x(x,dir)=x+[1,0,-1,0][dir];
function next_y(y,dir)=y+[0,1,0,-1][dir];

        
function go_maze(x,y,maze,columns,rows)=
       let(dirs=rand_dirs())
        sum(all_visited(maze))==0?
         set_visited(x,y,maze):   
         walk_around_from(
         x,y,
         dirs,
         set_visited(x,y,maze),
         columns,rows,4
         );
                
function walk_around_from(x,y,dirs,maze,columns,rows,i)=
        i>0?
        walk_around_from(
                x,y,
                dirs[4-i],
                try_routes_from(x,y,dirs[4-i],rows,columns),
                rows,columns,i-1)
        :maze;
function try_routes_from(x,y,dir,maze,rows,columns)=     visitable(next_x(x, dir), 
                  next_y(y, dir),
                  maze,
                  columns,
                  rows) ? 
         get_type(maze[indexOf(next_x(x,dir),
                              next_y(y,dir),
                              maze)])==false? 
                 go_maze(
            next_x(x,dir),
            next_y(y,dir), 
            try_block(dir,x,y,maze,columns,rows),
            columns, rows
        ):
                go_maze(
            next_x(x,dir),
            next_y(y,dir),
            maze,
            columns,rows
        ):maze;
             
         
         
         
         
         
//------------------------------------------------------------



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
            liner([[0,block_width],[block_width,block_width]],wall_thickness);
            }
        if(walltype==1){
            liner([[block_width,0],[block_width,block_width]],wall_thickness);
            }
        if (walltype==3){
            liner([[0,block_width],[block_width,block_width]],wall_thickness);
            liner([[block_width,0],[block_width,block_width]],wall_thickness);
            }
    }
        

module draw_maze(columns,rows,blocks,bolck_width,wall_thickness){
    for(block=blocks){
        translate([get_x(block),get_y(block)]*block_width)
        draw_block(
              get_wall_type(block),
              block_width,
              wall_thickness
        );
        }
       
//the lowermost wall
        
    liner(
        [[0,0],[block_width*columns,0]],wall_thickness);
    
//the leftmost wall
    liner(
         [[0,0],[0,block_width*rows]],wall_thickness );
       

    }
    
    
    
function go_right_from(x,y,maze)=[
    for(b=maze)[get_x(b),get_y(b)]==[x,y]?(
         get_wall_type(b)==up_right_wall?
         [x,y,up_wall,visited(x,y,maze)]:
         [x,y,no_wall,visited(x,y,maze)])
        :b];


function go_up_from(x,y,maze)=[
    for(b=maze)[get_x(b),get_y(b)]==[x,y]?(
       get_wall_type(b)==up_right_wall?
       [x,y,right_wall,visited(x,y,maze)]:
       [x,y,no_wall,visited(x,y,maze)])
       :b];    
    
function go_left_from(x,y,maze)=[
    for(b=maze)[get_x(b),get_y(b)]==[x-1,y]?(
       get_wall_type(b)==up_right_wall?
       [x-1,y,up_wall,visited(x,y,maze)]:
       [x-1,y,no_wall,visited(x,y,maze)])
       :b];    
    
function go_down_from(x,y,maze)=[
    for(b=maze)[get_x(b),get_y(b)]==[x,y-1]?(
       get_wall_type(b)==up_right_wall?
       [x,y-1,right_wall,visited(x,y-1,maze)]:
       [x,y-1,no_wall,visited(x,y-1,maze)]) 
       :b];
    
function try_block(dir,x,y,maze,columns,rows)=
    dir==0?go_right_from(x,y,maze):(
         dir==1?go_up_from(x,y,maze):(
              dir==2?go_left_from(x,y,maze):
                   go_down_from(x,y,maze)    
        ));
    
   
    
    
    
    
    
//echo(go_maze(get_x(sp),get_y(sp),starting_maze(5,5),5,5));


block_width = 3;
wall_thickness = 1;
maze_rows = 15;
maze_columns = 15;  
sp=starting_point(maze_columns,maze_rows);

maze_blocks=go_maze(
     get_x(sp),
     get_y(sp),
     starting_maze(15,15),
     15,15
);
draw_maze(maze_columns,maze_rows,maze_blocks,block_width,wall_thickness);
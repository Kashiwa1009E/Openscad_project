NO_WALL = 0;     
UP_WALL = 1;      
RIGHT_WALL = 2;    
UP_RIGHT_WALL = 3;

function block_data(x,y,wall_type,visited)=[x,y,wall_type,visited];

function starting_maze(rows,columns)=[
     for(y=[1:rows])
         for(x=[1:columns])
             block_data(
                  x,y,
         y==rows && x==columns? UP_WALL:UP_RIGHT_WALL,
         
         false 
         )
];

maze=starting_maze(10,10);
function indexOf(x,y,maze,i=0)=
         i>len(maze)?-1:(
             [get_x(maze[i]),get_y(maze[i])]==[x,y]?i:
                  indexOf(x,y,maze,i+1)
            );
         
function visited(x,y,maze)=maze[indexOf(x,y,maze)][3];
 
echo(visited(3,3,maze));
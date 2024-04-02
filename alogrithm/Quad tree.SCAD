//Quad tree


//Generate a set of random points
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);      
      
function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
        [rnd_v(0,width),rnd_v(0,length)]];
     

rnd_points=rnd_points(10,10,5) ;
          

//Set the random points as "unvisited". 
function initialize_rnd_points(rnd_points)=
    [for(i=rnd_points)
        [i.x,i.y,false]];
    
    
//set the point as "visited".     
function set_visited(init_num,width,rnd_points)=
    [for(i=rnd_points)
         init_num.x<i.x && i.x<=init_num.x+width &&
         init_num.y<i.y && i.y<=init_num.y+width ?
         [i.x,i.y,true]:
         [i.x,i.y,false]   
    ];
       
//Sum the list
function sum(list)=
      let(leng=len(list))
      leng==1?list[0]:
      leng==2?list[0]+list[1]:
      let( 
          sum_first=list[0]+list[1],
          sum_after=[for(i=[2:leng-1])
              list[i]])    
      sum(concat(sum_first,sum_after));
          
//Check all radom points is been visited or not 
function all_points_visited(rnd_points)=
    let(check=sum([for(i=rnd_points)
            i[2]==false?
            1:
            0]))
         check==0?true:
                  false;

function quad_tree(init_num,width,rnd_points)=
    let(rnd_p=initialize_rnd_points(rnd_points))
    let(array=
    points_in_block_or_not(init_num,width,rnd_points)?
    [init_num]:[])
    points_in_block_or_not(init_num,width,rnd_points)?
    quad_tree_inner(init_num,width,array,rnd_p):[];
    
    
function quad_tree_inner(init_num,width,array,rnd_p)=
    all_points_visited(rnd_p)? array :
    
         quad_tree_inner(
         generate_four_dirs_points(init_num,width,rnd_p),
         width/2,
         insert_list(generate_four_dirs_points(init_num,width,rnd_p),array),
         set_visited(init_num,width,rnd_p)
         );
 
 //test!!!!!!!!!
 
echo("test",quad_tree_inner(init_num,
                            width,
                            [[0,0]],
                            initialize_rnd_points(rnd_points)));




//inset the num_list into array    
function insert_list(list,array)=
    [for(i=list)
         i,
     for(j=array)
         j
    ];
function insert_num(num,array)=
     [num,
     for(i=array)
         i];
         
//check the points in the block or not 
function points_in_block_or_not(init_num,width,rnd_points)=
    let(check=sum([
         for(i=rnd_points)
             init_num.x<i.x && i.x<=init_num.x+width &&
             init_num.y<i.y && i.y<=init_num.y+width ?
                  1:0 
     ]))     
         check==0? false:  
                   true;
     
         
         
         

//Input the init_num → Output the four init_num
function generate_four_dirs_points(
    init_num,
    width,
    rnd_points
    )=
    let(divide_width=width/2)
    let(top_right=[init_num.x+divide_width,
                   init_num.y+divide_width],
        top_left=[init_num.x,
                  init_num.y+divide_width],
        bottom_left=[init_num.x,
                     init_num.y],
        bottom_right=[init_num.x+divide_width,
                     init_num.y])
    let(array=[])             
    let(four_dirs=[top_right,top_left,bottom_left,bottom_right])    
    generate_four_dirs_points_inner(init_num,divide_width,rnd_points,four_dirs,array,i=0);  
  



  
function generate_four_dirs_points_inner(
     init_num,
     width,
     rnd_points,
     four_dirs,
     array,
     i
     )=
     i>=4? array:
     points_in_block_or_not(four_dirs[i],width,rnd_points)?
           generate_four_dirs_points_inner(
                init_num,
                width,
                rnd_points,
                four_dirs,
                insert_num(four_dirs[i],array),
                i+1
           ):
           generate_four_dirs_points_inner(
                init_num,
                width,
                rnd_points,
                four_dirs,
                array,
                i+1
           );

init_num=[0,0];

width=10;
echo("rnd_points",rnd_points);
echo("four_dirs",generate_four_dirs_points(init_num,width,rnd_points));




/*

echo(quad_tree(init_num,width,rnd_points));
*/


















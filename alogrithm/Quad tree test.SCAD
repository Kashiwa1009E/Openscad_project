//Quad tree

top_right=0;
top_left=1;
bottom_left=2;
bottom_right=3;

rnd_points=rnd_points(10,10,5) ;


//Generate a set of random points
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);      
      
function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
        [rnd_v(0,width),rnd_v(0,length)]];
     
//Set the random points as "unvisited". 
function initialize_rnd_points(rnd_points)=
    [for(i=rnd_points)
        [i.x,i.y,false]];
       
    
function get_quadrant(array)=array[2];
function get_x(array)=array[0];
function get_y(array)=array[1];    
    
   
 // 一次只判斷四象限中的一個象限   
//check the points in the block or not 
function points_in_block_or_not(quadrant,divide_width,rnd_points)=
    let(check=sum(
         get_quadrant(quadrant)==top_right?
         [for(i=rnd_points)
             init_num.x<i.x && i.x<=init_num.x+divide_width &&
             init_num.y<i.y && i.y<=init_num.y+divide_width ?
                  1:0]
         :
         get_quadrant(quadrant)==top_left?
         [for(i=rnd_points)
             init_num.x<=i.x && i.x<=init_num.x+divide_width&&
             init_num.y<i.y && i.y<=init_num+divide_width?
                 1:0]
         :
         get_quadrant(quadrant)==bottom_left?
         [for(i=rnd_points)
             init_num.x<=i.x && i.x<=init_num.x+divide_width&&
             init_num.y<=i.y && i.y<=init_num+divide_width?
                1:0]
         :
         //bottom_right?
         [for(i=rnd_points)
             init_num.x<i.x && i.x<=init_num.x+divide_width &&
             init_num.y<=i.y && i.y<=init_num+divide_width?
               1:0]))     
         check==0? false:  
                   true;    
    
         
         
    //在生成四象限時，就要把屬於哪個象限放入    
    //set the point as "visited".     // 需要更改，因為init_num不只一個
function set_visited(init_num,divide_width,rnd_points)=
    let(leng=len(init_num)-1) 
    let(i=0)    
         set_visited_inner(init_num,divide_width,rnd_points,leng,i);
         
function set_visited_inner(init_num,divide_width,rnd_points,leng,i)=         
         //processing
    i>=leng? rnd_points:
    let(init_n=init_num[i])     
    let(list=     
    get_quadrant(init_num[i])==top_right?   
    [for(i=rnd_points)
         init_n.x<i.x && i.x<=init_n.x+divide_width &&
         init_n.y<i.y && i.y<=init_n.y+divide_width ?
         [i.x,i.y,true]:
         [i.x,i.y,i[2]]   
    ]:
    get_quadrant(init_num[i])==top_left?  
    [for(i=rnd_points)
         init_n.x<=i.x && i.x<=init_n.x+divide_width &&
         init_n.y<i.y && i.y <=init_n.y+divide_width?
         [i.x,i.y,true]:
         [i.x,i.y,i[2]]    
    ]:
    get_quadrant(init_num[i])==bottom_left?
    [for(i=rnd_points)
        init_n.x<=i.x && i.x<=init_n.x+divide_width &&
        init_n.y<=i.y && i.y <=init_n.y+divide_width?
        [i.x,i.y,true]:
        [i.x,i.y,i[2]]
    ]:
    //bottom right
    [for(i=rnd_points)
        init_n.x<i.x && i.x<=init_n.x+divide_width &&
        init_n.y<=i.y && i.y<=init_n.y+divide_width?
        [i.x,i.y,true]:
        [i.x,i.y,i[2]]
    ])
    set_visited_inner(init_num,divide_width,list,leng,i+1);
           
    
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
    points_in_block_or_not(init_num,width,rnd_po)?
    [init_num]:[])
    points_in_block_or_not(init_num,width,rnd_p)?
    quad_tree_inner(init_num,width,array,rnd_p):[];
    
function quad_tree_inner(init_num,width,array,rnd_p)=
       
    all_points_visited(rnd_p)? array :
         quad_tree_inner(
         generate_four_dirs_points(init_num,width,rnd_p),
         width/2,
         insert_list(generate_four_dirs_points(init_num,width,rnd_p),array),
         set_visited(init_num,width,rnd_p)
         );
 
//insert the num_list into array    
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
         
// processing--------------------------------------------------------
function generate_four_dirs_points(
         init_num,
         width,
         rnd_points
         ) =
   let(leng=len(init_num))
   let(divide_width=width/2)
   let(array=[])
   let(i=0)
   generate_four_dirs_points_inner(
         init_num,
         divide_width,
         rnd_points,
         leng,
         array,
         i
         );

function generate_four_dirs_points_inner(
    init_num,
    divide_width,
    rnd_points,
    leng,
    array,
    i
    )=
    i>=leng? array:
    
    generate_four_dirs_points_inner(
     init_num[i],
     divide_width,
     rnd_points,
     leng,
     insert_list(generate_four_quadrant(init_num[i],divide_width,rnd_points),array),
     i+1
     ); 
  
function generate_four_quadrant(
     init_num,
     divide_width,
     rnd_points,
     )=    
     let(top_right=[init_num.x+divide_width,
                    init_num.y+divide_width,
                    top_right],
         top_left=[init_num.x,
                   init_num.y+divide_width,
                   top_left],
         bottom_left=[init_num.x,
                      init_num.y,
                      bottom_left],
         bottom_right=[init_num.x+divide_width,
                       init_num.y,
                       bottom_right])
     let(four_quadrant=[top_right,top_left,bottom_left,bottom_right])
     let(array=[])
     generate_four_quadrant_inner(init_num,divide_width,rnd_points,four_quadrant,array,i=4);
     
function generate_four_quadrant_inner(
     init_num,
     divide_width,
     rnd_points,
     four_quadrant,
     array,
     i
     )= 
     i>=4? array :
     points_in_block_or_not(four_quadrant[i],divide_width,rnd_points)?
           generate_four_dirs_points_inner(
                init_num,
                divide_width,
                rnd_points,
                four_quadrant,
                insert_num([get_x(four_dirs[i]),get_y(four_dirs[i])],array),
                i+1
           ):
           generate_four_dirs_points_inner(
                init_num,
                divide_width,
                rnd_points,
                four_quadrant,
                array,
                i+1
           );
//--------------------------------------------------------------           

init_num=[0,0];

width=10;
echo("rnd_points",rnd_points);

/*
echo(quad_tree(init_num,width,rnd_points));
*/


















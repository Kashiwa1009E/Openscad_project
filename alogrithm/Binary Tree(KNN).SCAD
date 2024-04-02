//Binary Tree

//KNN(K-Nearest Neighbours)



//Genreate a set of random points 
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

function rnd_points(width,length,amount)=
     [for(i=[0:amount-1])
         [rnd_v(0,width),rnd_v(0,length)]];
     
   
//Set the random points as "unvisited".
function initialize_rnd_points(rnd_points)=
       [for(i=rnd_points)
             [i.x,i.y,false]];
       
function get_x(array)=array[0];
function get_y(array)=array[1];       
     
  
test=rnd_points(50,50,200);
       
         
for(i=test)
    translate(i)
        sphere(1);
       
test_r=node(test,50,1)[0];

echo("test_R",test_r);
for(i=test_r)
    translate(i)
        color("red")
            sphere(1);

echo(node(test,50,0));      
               

//Balanced Binary tree

function balanced_binary_tree(rnd_points,width)=
          let(i=0)
          balanced_binary_tree_inner(rnd_points,width,i);




function check_array(array)=
     let(check_num=sum([
          for(i=array) 
              len(i)==2 || len(i)==0?
              0:1
     ]))
         check_num==0? true:
          false;
         
function sum(list)=
      let(leng=len(list))
      leng==1?list[0]:
      leng==2?list[0]+list[1]:
      let( 
          sum_first=list[0]+list[1],
          sum_after=[for(i=[2:leng-1])
              list[i]])    
      sum(concat(sum_first,sum_after));
                                
 //-----------------------------------------------------------                  
                                            
  function node(root,width,level)=
       let(divide_width=width/2)
       let(right_left=level%2==0?
                     node_x(root,divide_width):
                     node_y(root,divide_width)
          )          
       right_left 
    ;
      


function node_x(root,divide_width)=
                   let(left=[
                   for(i=root)
                       if(i.x<divide_width)
                        i],
                       right=[
                    for(i=root)
                       if(divide_width<=i.x)
                         i]  
                       )
                [left,right];  


function node_y(root,divide_width)=
                   let(left=[
                   for(i=root)
                        if(i.y<divide_width)
                        i    
                       ],
                       right=[
                           for(i=root)
                              if(divide_width<=i.y) 
                             i])
                 [left,right];
                              
                              














               
               
               
               
               
               
               
               
               
               
               
               
               
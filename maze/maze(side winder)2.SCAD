no_wall=0;
right_wall=1;
down_wall=2;
down_right_wall=3;

columns=10;
rows=10;

function block_data(x,y,walltype)=[x,y,walltype];
function get_block_x(block_data)=block_data[0];
function get_block_y(block_data)=block_data[1];
function get_walltype(block_data)=block_data[2];

//取隨機個小於columns不重複亂數
function start_list(columns)=[
     for(i=[0:columns-1])
         [i,false]
];   
     
function get_type(x,list)=list[x][1];
function get_x(x,list)=list[x][0];

function rnd_value(init_value,end_value)=round(rands(init_value,end_value,1)[0]);     
function visited(x,list)=[
     for( i = list)
         i[0]==x?[i[0],true]:i];
//------------------------------------------     
function isTrue(init_value,list,leng)=
     let(rnd_num=rnd_value(1,leng-1))
         init_value==0?0:
         get_type(rnd_num,list)==true ?
         isTrue(init_value,list,leng):rnd_num;  
//------------------------------------------     
function nrr_inner(list,leng,rnd_counts,init_value)=
     let(num=isTrue(init_value,list,leng))
     init_value==rnd_counts?[leng]:
     concat(
     num,
     nrr_inner(visited(num,list),leng,rnd_counts,init_value+1));
//------------------------------------------          
function non_repeat_rnd(
     list
     )=
 let(leng=len(list)-1,
     rnd_counts=rnd_value(1,leng-1)
     )
     echo(rnd_counts+1) 
     nrr_inner(list,leng,rnd_counts,0);
 function sort(list)=
     let(leng=len(list))
     leng<=1? list:
          let(pivot=list[0],               
              before=[for(j=1;j<leng;j=j+1) 
              if(list[j]<pivot) 
                    list[j]],
               after=[for(j=1;j<leng;j=j+1)
               if(list[j]>=pivot)
                    list[j]]) 
     [each sort(before),pivot,each sort(after)];   
            
         
 //echo(sort(non_repeat_rnd(start_list(10))));   
          
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
 
              
 
   echo(extend_list(0,sort(non_repeat_rnd(start_list(10)))));   
               
               
  //-------------------- 
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
function last_row(init_val,columns)=
     init_val==columns-1?[3]:
     concat(2,last_row(init_val+1,columns));
     //echo(last_row(0,columns));

function type_list(count_start,start_value,pos_list)=
    start_value==len(pos_list)-1? 
    switch_to_type(
    count_start,
    rnd_value(0,len(pos_list[start_value])-1),
    start_value,
    pos_list):
    
concat(switch_to_type(count_start,
                      rnd_value(0,len(pos_list[start_value])-1),
                      start_value,
                      pos_list),
                      
      type_list(count_start,start_value+1,pos_list));
  
       echo(type_list(0,0,extend_list(0,sort(non_repeat_rnd(start_list(10)))))); 
    
    //-------------------------------------------------------------------
      function block_type_list(count_start,start_value,initial_value,rows,columns)=
     initial_value==rows-1?
     last_row(0,columns):
     concat(type_list(0,0,extend_list(0,sort(non_repeat_rnd(start_list(10))))),
     block_type_list(count_start,start_value,initial_value+1,rows,columns));
   
   echo(block_type_list(0,0,0,rows,columns));
   block_type_list=block_type_list(0,0,0,rows,columns);
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


module draw_maze(count_start,rows,columns,block_width,wall_thickness,block_type_list){
        
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

                                 
        for(block=blocks(count_start,start_maze,block_type_list)){
           translate([get_block_x(block)-1,get_block_y(block)-1]*block_width)
             draw_block(
                  get_walltype(block),
                  block_width,
                  wall_thickness            
            ) ;   
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
    
               

   //------------------------------- 
            }  
        

  liner([[0,0],[0,block_width*rows]],wall_thickness);
        liner([[0,block_width*rows],[block_width*columns,block_width*rows]],wall_thickness);  
        }
        
draw_maze(0,columns,rows,3,1,block_type_list);
        



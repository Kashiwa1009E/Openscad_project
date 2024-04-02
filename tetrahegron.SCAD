
p1=[1,2,3];

p2=[6,6,9];


module draw_line(p1,p2,thickness,fn=4){
    $fn=fn;
    
    hull(){
        translate(p1)sphere(thickness/2);
        translate(p2)sphere(thickness/2);
        } 
    }
    
module polyline_3D(points,thickness,fn=4){
    module polyline3D_inner(points,index){
         if (index<len(points)){
             draw_line(points[index-1],points[index],thickness,fn);
             polyline3D_inner(points,index+1);
         }  
    }
    polyline3D_inner(points,1);
}

function high(side_length)=
            pow(pow(sin(60)*side_length,2)-pow((sin(60)*side_length)/2,2),0.5);
echo(high(10));


function get_x(list)=list[0];
function get_y(list)=list[1];
function get_z(list)=list[2];

function vertex(starting_point,side_length)=            [get_x(starting_point)+cos(30)*side_length*2/3,
        get_y(starting_point),
        get_z(starting_point)+high(side_length)
       ];

function tetrahegron(starting_point,side_length)=
     [starting_point,

      vertex(starting_point,side_length),
       

       [get_x(starting_point)+cos(30)*side_length,
        get_y(starting_point)+sin(30)*side_length,
        get_z(starting_point)],

        
     
      vertex(starting_point,side_length),
       
       
    [get_x(starting_point)+cos(30)*side_length,
    get_y(starting_point)-sin(30)*side_length,
    get_z(starting_point)],
    
  
  starting_point,
   [get_x(starting_point)+cos(30)*side_length,
        get_y(starting_point)+sin(30)*side_length,
        get_z(starting_point)],
         [get_x(starting_point)+cos(30)*side_length,
    get_y(starting_point)-sin(30)*side_length,
    get_z(starting_point)],
  

  
    ];

polyline_3D(tetrahegron([0,0,0],10),1,50);






  
      
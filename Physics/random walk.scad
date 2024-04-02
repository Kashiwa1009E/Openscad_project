//random walk


/*
$t 0-1
fps:frame per second 
*/
/*
sphere(10);
rotate($t*360)
translate([30,0,0])
sphere(5);
*/


start_num=0;
end_num=10;
function rnd_num(start_num,end_num)=rands(start_num,end_num,1)[0];

function rnd_direction()=round(rands(0,4,1)[0]);
echo(rnd_direction());
up=0;
down=1;
right=2;
left=3;

rnd_dir=rnd_direction();

if (rnd_direction()==up)
    walk_up();

module walk_up(){
    translate([0,$t*100,0])
    sphere(10);   
    }










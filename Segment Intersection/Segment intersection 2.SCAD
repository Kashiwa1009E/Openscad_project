upper=0;
lower=1;
inter=2;
function rnd_v(init_value,end_value)=round(rands(start_value,end_value,1)[0]);
start_value=0;
end_value=500;
segments_num=4; 
segments=[
     for(i=[0:segments_num-1])
           [point(start_value,end_value),
           point(start_value,end_value)]
];
function point(start_value,end_value)=  
    [rnd_v(start_value,end_value),
     rnd_v(start_value,end_value)];
thickness=6;

for(i=segments)
    draw_line(i[0],i[1],thickness,4);

module draw_line(p1,p2,thickness,fn=4){
    $fn=fn;    
    hull(){
        translate(p1)sphere(thickness/2);
        translate(p2)sphere(thickness/2);
        } }
//sort by y
function compare(p1,p2)=
       p1.y>p2.y || (p1.y==p2.y && p1.x<p2.x)?
       true:false;  
function quick_sort(points)=
         let(leng=len(points)-1)
         leng<1?points:
         let(pivot=points[0])
         let(before=[for (i=[1:leng])
             if(compare(point_of_array(points[i]),
                        point_of_array(pivot)))
                 points[i]])
         let(after=[for(i=[1:leng])
             if(compare(point_of_array(points[i]),
                        point_of_array(pivot))==false)
                 points[i]])
         [each quick_sort(before),pivot,each quick_sort(after)];                 
function point_of_array(array)=array[0];//[x,y]
function section_of_array(array)=array[1];// upper or lower or inter         
function segment_of_array(array)=array[2];//[[upper_p],[lower_p]]             
             
function upper_of_segment(segment)=segment[0];
function lower_of_segment(segment)=segment[1];
            
//output[[point],upper or lower,segment]            
function event_array(segments)=
        let(leng=len(segments)-1)
        let(uppers=[for(i=[0:leng])
                    (segments[i][0].y>segments[i][1].y) || 
                    (segments[i][0].y==segments[i][1].y && segments[i][0].x<segments[i][1].x) ?
                   [segments[i][0],upper,[segments[i][0],segments[i][1]]]:
                   [segments[i][1],upper,[segments[i][1],segments[i][0]]]
                   ])
        let(lowers=[for(i=[0:leng])
                   (segments[i][0].y>segments[i][1].y) ||
                    (segments[i][0].y==segments[i][1].y && segments[i][0].x<segments[i][1].x)?
                   [segments[i][1],lower,[segments[i][0],segments[i][1]]]:
                   [segments[i][0],lower,[segments[i][1],segments[i][0]]]
                   ])
        quick_sort( [each uppers,each lowers]);
                                        
function dot(v1,v2)=
    v1.x*v2.x+v1.y*v2.y;                        
function cross_(v1,v2)=
    v1.x*v2.y-v1.y*v2.x;             
function dequeue(queue)=
        let(leng=len(queue)-1)
        leng<=0?
        []:
        [for(i=[1:leng])
        queue[i]];    
function inqueue(queue,num)=
       [for(i=queue)i ,num] ;        
function pop(array)=
      len(array)<2?
      []:  
      let(leng=len(array)-2)
      [for(i=[0:leng])
      array[i]   
      ];
function push(array,num)=
      [num,for(i=array) i];
          
function insert_tree(tree,segment)=
     let(leng=len(tree)-1)
     let(right=[])
     insert_tree_inner(tree,segment,leng,right);
 function insert_tree_inner(tree,segment,leng,right)=
     leng<0 && len(right)-1<0?[[segment],[]]:
      leng<0? [[segment,each right],[right[0]]]:
     cross_(lower_of_segment(tree[leng])-upper_of_segment(tree[leng]),
      (upper_of_segment(segment)-upper_of_segment(tree[leng])))<0?   
     let(tree_=pop(tree)) 
     let(right_=push(right,tree[leng]))       
     insert_tree_inner(tree_,segment,leng-1,right_):
      len(right)-1<0?
     [[each tree, segment, each right],[tree[leng]]]:
     [[each tree, segment, each right],[ tree[leng], right[0]]] ;


function extract_tree(tree,segment)=
      let(leng=len(tree)-1)
      let(right=[])
      extract_tree_inner(tree,segment,leng,right);
function extract_tree_inner(tree,segment,leng,right)=
      leng<0?[[],["lower_extract_tree_error"]]:
      tree[leng]==segment?
      let(tree_=pop(tree))
      let(leng_tree_=len(tree_)-1)
      let(leng_right=len(right)-1)
      leng_tree_<0 && leng_right<0?
      [[],[]]:
      leng_right<0?
      [[each tree_],[]]:
      leng_tree_<0?
      [[each right],[]]:
      //leng_tree_>=0 && len_right>=0
      [[each tree_,each right],[tree_[leng_tree_],right[0]]]:
      
      let(tree_=pop(tree))
      let(right_=push(right,tree[leng]))
      extract_tree_inner(tree_,segment,leng-1,right_);
       


function swap_tree(tree,segment_set)=
         let(leng=len(tree)-1)
         let(right=[])
         swap_tree_inner(tree,segment_set,leng,right);
function swap_tree_inner(tree,segment_set,leng,right)=
         leng<0?[[],["swap_tree_error"]]:
         (tree[leng]==segment_set[1] && tree[leng-1]==segment_set[0])
         ||
         (tree[leng]==segment_set[0] && tree[leng-1]==segment_set[1])?
         let(leng_tree=len(tree)-1)
         leng_tree<2?
         let(leng_right=len(right)-1)
         let(tree_=[tree[1],tree[0],each right])
         leng_right>=0?
         [tree_,[[tree[leng-1],right[0]]]]:
         [tree_,[]]
         :
         //leng_tree>=2
         let(tree_=[for(i=[0:leng-2])
             tree[i],tree[leng],tree[leng-1],each right])
         let(leng_right=len(right)-1)
         leng_right>=0?
         [tree_,[[tree[leng],tree[leng-2]],[tree[leng-1],right[0]]]]:
         [tree_,[[tree[leng],tree[leng-2]]]]     
         :
         let(tree_=pop(tree))
         let(right_=push(right,tree[leng]))
         swap_tree_inner(tree_,segment_set,leng-1,right_);
 
         
tree=[[[14, 90], [58, 66]], [[28, 92], [83, 76]], [[68, 83], [31, 18]]];
segment_set= [[[68, 83], [31, 18]], [[28, 92], [83, 76]]];
test_swap=swap_tree(tree,segment_set);
 echo(test_swap);        




function get_tree(tree_array)=[tree_array[0]];
function get_sibling(tree_array)=[tree_array[1]];         


//Put the intercetion point into queue. sort by y
function push_event(event_array,new_event)=
      let(new_event_point=point_of_array(new_event))
      let(upper=[])
      push_event_inner(event_array,new_event,new_event_point,upper);
function push_event_inner(event_array,new_event,new_event_point,upper)=     
      let(event_leng=len(event_array)-1)
      event_leng<0?[each event_array,new_event]:
      let(event_point=point_of_array(event_array[0]))
      new_event_point.y<event_point.y?
      let(event_array_=dequeue(event_array))
      let(upper_=inqueue(upper,event_array[0]))
      push_event_inner(event_array_,new_event,new_event_point,upper_):
      //new_event_point.y>point_of_segment(event_point[index])
      [each upper,new_event,each event_array];


function push_event_points(event_array,new_events)=
    let(leng=len(new_events)-1)
    push_event_points_inner(event_array,new_events,leng);
function push_event_points_inner(event_array,new_events,leng)=
    leng<0? event_array:
    let(event_array_=push_event(event_array,new_events[leng]))
    push_event_points_inner(event_array_,new_events,leng-1); 



//Determine whether two line segments intersect.
function seg_inters_compare(line_a,line_b)=
    cross_(line_b[1]-line_b[0],line_a[1]-line_b[0])>=0 &&
    cross_(line_b[1]-line_b[0],line_a[0]-line_b[0])<=0 ||
    cross_(line_b[1]-line_b[0],line_a[1]-line_b[0])<=0 &&
    cross_(line_b[1]-line_b[0],line_a[0]-line_b[0])>=0 ?   
    (cross_(line_a[0]-line_b[1],line_a[1]-line_b[1])>0 &&
    cross_(line_a[0]-line_b[0],line_a[1]-line_b[0])<0) ||
    (cross_(line_a[0]-line_b[1],line_a[1]-line_b[1])<0 &&
    cross_(line_a[0]-line_b[0],line_a[1]-line_b[0])>0)? 
    true:    
    false:false;

 //Find the two segment intercetion point
function intersection_point(segment_a,segment_b)=
    let(base_a=segment_a[1]-segment_a[0])
    let(side_ab=[segment_b[0].x-segment_a[0].x,segment_b[0].y-segment_a[0].y])
    let(side_b=segment_b[1]-segment_b[0])
    let(area_a=abs(cross_(base_a,side_ab)))
    let(area_b=abs(cross_(base_a,side_b))-area_a)
    let(x=(area_a*segment_b[1].x+area_b*segment_b[0].x)/(area_a+area_b))
    let(y=(area_a*segment_b[1].y+area_b*segment_b[0].y)/(area_a+area_b))
    [x,y];   

function intersection_with_sibling(event_segment,sibling)=
    let(leng=len(sibling)-1)
    let(inter_p=[])
    intersection_with_sibling_inner(event_segment,sibling,leng,inter_p);
function intersection_with_sibling_inner(event_segment,sibling,leng,inter_p)=
    leng<0? inter_p:
    seg_inters_compare(event_segment,sibling[leng])==true?
    let(inter_point=intersection_point(event_segment,sibling[leng]))
    let(inter_array= //leng==1?
                     [inter_point,inter,[event_segment,sibling[leng]]]
                     //:
                     //leng==0
                     //[inter_point,inter,[sibling[leng]]]
                     )
    let(inter_p_=push(inter_p,inter_array))
    intersection_with_sibling_inner(event_segment,sibling,leng-1,inter_p_):
    //seg_inters_compare(event_segment,sibling[leng])==false. Two segment aren't intersection 
    intersection_with_sibling_inner(event_segment,sibling,leng-1,inter_p);




function segments_intersection(event_points,test_count)=
      let(segment=segment_of_array(event_points[0]))
      let(tree=[segment])         
      let(inters=[])
      let(event_points_=dequeue(event_points))
      segments_intersection_inner(tree,inters,event_points_,test_count);

function segments_intersection_inner(tree,inters,event_points,test_count)=
      test_count<0? inters:
      len(event_points)-1<0? inters:      
      let(section=section_of_array(event_points[0]))
//--------------------------------------------------------------------------------      
      echo("tree",tree)
      echo("inters",inters)
      //echo("event_points",event_points)
      section==upper?  //First,determine what type the new event point is.       
      let(event_segment=segment_of_array(event_points[0]))  //which segment
      //push segment into new_tree. [[segments],[sibling]]
      let(new_tree=insert_tree(tree,event_segment))  
      let(tree_=get_tree(new_tree)[0])
      echo("upper_new_tree",tree_)
      let(sibling=get_sibling(new_tree)[0])
      echo("upper_sibilng",sibling)
      let(event_points_=dequeue(event_points))
 
      len(sibling)-1<0?
      segments_intersection_inner(tree_,inters,event_points_,test_count-1): 
 
 
    //find the intersection with sibling
      let(intersection_p=intersection_with_sibling(event_segment,sibling))
      echo("upper_intersection_p",intersection_p)
      len(intersection_p)-1<0?
      segments_intersection_inner(tree_,inters,event_points_,test_count-1):
      //len(intersection_p)>=0
      
      let(inter_points=[for(i=intersection_p) point_of_array(i)])
      let(inters_=concat(inters,inter_points))
      echo("upper_inters_",inters_)
      let(event_points_with_inter=push_event_points(event_points_,intersection_p))
      segments_intersection_inner(tree_,inters_,event_points_with_inter,test_count-1):
//----------------------------------------------------------------------------------          
     section==lower?
     let(event_segment=segment_of_array(event_points[0]))
     //extract segment from tree
     echo("lower_event_segment",event_segment)
     let(new_tree=extract_tree(tree,event_segment))
     let(tree_=get_tree(new_tree)[0])
     echo("lower_tree",tree_) 
     let(sibling=get_sibling(new_tree)[0])
     echo("lower_sibling",sibling)     
     let(event_points_=dequeue(event_points))
     
     len(sibling)-1<0?
     segments_intersection_inner(tree_,inters,event_points_,test_count-1): 
      
     //find the intersection with sibling
     let(intersection_p=intersection_with_sibling(sibling[0],[sibling[1]]))
     echo("lower_intersection_p",intersection_p)
     len(intersection_p)-1<0? //no intersection
     segments_intersection_inner(tree_,inters,event_points_,test_count-1):
      
     let(inter_points=[for(i=intersection_p)point_of_array(i)])
     let(inters_=concat(inters,inter_points))
     echo("lower_inters",inters_)
     let(event_points_with_inter=push_event_points(event_points_,intersection_p))
     segments_intersection_inner(tree_,inters_,event_points_with_inter,test_count-1):
     
     //------------------------------------------------------------------------------------
     
     //section==inter?
     let(segment_set=segment_of_array(event_points[0]))
     echo("inter_segment_set",segment_set)
     let(new_tree=swap_tree(tree,segment_set))
     let(tree_=get_tree(new_tree)[0])
     echo("inter_tree",tree_)
     let(sibling_set=get_sibling(new_tree)[0])
     echo("inter_sibling_set",sibling_set)
     let(event_points_=dequeue(event_points))
     
     sibling_set==[]?
     segments_intersection_inner(tree_,inters,event_points_,test_count-1):
     //---------------------------------------------------------------------------------
     let(intersection_p=[ for(i=sibling_set)
                         intersection_with_sibling(i[0],[i[1]])]) 
     echo("inter_intersection_p",intersection_p)
     
     
     intersection_p[0]==[]?
     segments_intersection_inner(tree_,inters,event_points_,test_count-1):
     let(inters_=concat(inters,[for(i=intersection_p)
                                 point_of_array(i)[0]]))
     echo("inter_inters",inters_) 
     let(event_points_with_inter=push_event_points(event_points_,intersection_p[0])) 
     segments_intersection_inner(tree_,inters_,event_points_with_inter,test_count-1);
//------------------------------------------------------------------------------------

test_count=50;
test_event_array=event_array(segments);
uuu=segments_intersection(test_event_array,test_count);
echo("intersection",uuu);
   

if(len(uuu)-1>=0)     
for(i=uuu)
translate(i)
    color("red")
    sphere(8);   






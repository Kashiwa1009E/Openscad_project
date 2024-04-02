//Segment Intersection 

/*隨著掃描線移動，線段增增減減。如果線段沒有相交，線段的上下順序是固定的。
如果線段相交，那就一定是上下相鄰的線段相交了。

每當線段增增減減，當下就可以檢查上下相鄰的線段是否相交。使用二元搜尋樹紀錄線段，
快速找出上下相鄰的線段。
*/

/*
fundIntersections(S)
Input: set S of n non-overlapping closed line segments
Output: -set I of intersection pts
*/

upper=0;
lower=1;
inter=2;

function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=200;
segements_num=5; 


segements=[
     for(i=[0:segements_num-1])
           [point(init_value,end_value),
           point(init_value,end_value)]
];

function point(init_value,end_value)=  
    [rnd_v(init_value,end_value),
     rnd_v(init_value,end_value)];

//echo(segements);

thickness=1;
for(i=segements)
    draw_line(i[0],i[1],thickness,4);

module draw_line(p1,p2,thickness,fn=4){
    $fn=fn;    
    hull(){
        translate(p1)sphere(thickness/2);
        translate(p2)sphere(thickness/2);
        } }
    

function compare(p1,p2)=
       p1.y>p2.y || (p1.y==p2.y && p1.x<p2.x)?
       true:false;

function quick_sort(points)=
         let(leng=len(points)-1)
         leng<1?points:
         let(pivot=points[0])
         let(before=[for (i=[1:leng])
             if(compare(point_of_segement(points[i]),
                        point_of_segement(pivot)))
                 points[i]])
         let(after=[for(i=[1:leng])
             if(compare(point_of_segement(points[i]),
                        point_of_segement(pivot))==false)
                 points[i]])
         [each quick_sort(before),pivot,each quick_sort(after)];    
             
function point_of_segement(segement)=segement[0];//[x,y]
function section_of_segement(segement)=segement[1];// upper or lower or inter         
function index_of_segement(segement)=segement[2];//[[upper_p],[lower_p]]

function event_points(segements)=
        let(leng=len(segements)-1)
        let(uppers=[for(i=[0:leng])
                    segements[i][0].y>segements[i][1].y?
                   [segements[i][0],upper,[segements[i][0],segements[i][1]]]:
                   [segements[i][1],upper,[segements[i][1],segements[i][0]]]
                   ])
        let(lowers=[for(i=[0:leng])
                   segements[i][0].y>=segements[i][1].y?
                   [segements[i][1],lower,[segements[i][0],segements[i][1]]]:
                   [segements[i][0],lower,[segements[i][1],segements[i][0]]]
                   ])
        quick_sort( [each uppers,each lowers]);
           
test=event_points(segements);
        
echo(test); 


function dot(v1,v2)=
    v1.x*v2.x+v1.y*v2.y;
    
function cross_(v1,v2)=
    v1.x*v2.y-v1.y*v2.x;
        
function dequeue(queue)=[for(i=[1:len(queue)-1])
                            queue[i]];
function pop(array)=
      let(leng=len(array)-1)
      [for(i=[0:leng-1])
      i   
      ];
function push(array,num)=
      [num,for(i=array) i];
    
//search from the right side,if target is on the right side,insert into the tree.      
function insert_tree(tree,segement)=
     let(leng=len(tree)-1)
     let(right=[])
     insert_tree_inner(tree,segement,leng,right);
 function insert_tree_inner(tree,segement,leng,right)=
     leng<0? [segement,right]:
     cross_(tree[leng][1]-tree[leng][0],segement[0]-tree[leng][0])<0? //segement[0]:upper_point      
     let(tree_=pop(tree[leng]))
     let(right_=push(right,tree[leng]))       
     insert_tree_inner(tree_,segement,leng-1,right_):
     let(tree_leng=len(tree)-1)
     [[each tree, segement, each right],[tree[tree_leng],right[0]]];
 
 
function extract_tree(tree,segement)=
      let(leng=len(tree)-1)
      extract_tree_inner(tree,segement,leng);
function extract_tree_inner(tree,segement,leng)=
      let(before=[for(i=tree)
          if(i.x<segement.x || (i.x==segement.x && i.y!=segement.y))
          i   
         ])
      let(after=[for(i=tree)
          if(i.x>segement.x ||(i.x==segement.x && i.y!=segement.y))
          i 
         ])
      let(tree=[each before,each after])
      let(leng_before=len(before)-1)
      [tree,[before[leng],after[0]]];      
     
function swap_tree(tree,segement_set)=
         let(leng=len(tree)-1)
         let(right=[])
         swap_tree_inner(tree,segement_set,leng,right);
function swap_tree_inner(tree,segement_set,leng,right)=
         tree[leng]==segement_set[1] && tree[leng-1]==segement_set[0]?
         leng<0?[]:
         let(leng_tree=len(tree)-1)
         let(tree_=[for(i=[0:leng-2])
             tree[i],tree[leng],tree[leng-1],each right])
         [tree,[[tree[leng],tree[leng-2]],[tree[leng-1],right[0]]]]
         :
         let(tree_=pop(tree[leng]))
         let(right_=push(tree[leng]))
         swap_tree_inner(tree_,segement_set,leng-1,right_);
                          
      
function get_tree(tree)=[tree[0]];
function get_sibling(tree)=[tree[1]];

//Put the intercetion point into queue. sort by y
function push_event_points(event_points,new_event)=
      let(new_event_point=point_of_segement(new_event))
      let(leng=len(event_points)-1)
      let(index=0)
      let(upper=[])
      push_event_points_inner(event_points,new_event,new_event_point,index,leng,upper);
function push_event_points_inner(event_points,new_event,new_event_point,index,leng,upper)=      
      index>leng?[each event_points,new_event]:
      new_event_point.y<point_of_segement(event_points[index])?
      let(event_points_=pop(event_points[index]))
      let(upper_=push(upper,event_points[index]))
      push_event_points_inner(event_points_,new_event,new_event_point,index+1,leng,upper_):
      //new_event_point.y>point_of_segement(event_point[index])
      [each upper,new_event,each event_points];
           

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

 //Find the intercetion point
function intersection_point(segement_a,segement_b)=
    let(base_a=segement_a[1]-segement_a[0])
    let(side_ab=[segement_b[0].x-segement_a[0].x,segement_b[0].y-segement_a[0].y])
    let(side_b=segement_b[1]-segement_b[0])
    let(area_a=abs(cross_(base_a,side_ab)))
    let(area_b=abs(cross_(base_a,side_b))-area_a)
    let(x=(area_a*segement_b[1].x+area_b*segement_b[0].x)/(area_a+area_b))
    let(y=(area_a*segement_b[1].y+area_b*segement_b[0].y)/(area_a+area_b))
    [x,y];    


//output intersection points and it's sibling
function intersection_with_sibling(event_segement,sibling)=
    let(leng=len(sibling)-1)
    let(inter_p=[])
    intersection_with_sibling_inner(event_segement,sibling,leng,inter_p);
function intersection_with_sibling_inner(event_segement,sibling,leng,inter_p)=
    leng<0? inter_p:
    seg_inters_compare(event_segement,sibling[leng])==true?
    let(inter_point=intersection_point(event_segement,sibling[leng]))
    let(inter_array= leng==1?
                     [inter_point,inter,[event_segement,sibling[leng]]]:
                     //leng==0
                     [inter_point,inter,[sibling[leng]]]
                     )
    let(inter_p_=push(inter_p,inter_array))
    intersection_with_sibling_inner(event_segement,sibling,leng-1,inter_p_):
    //seg_inters_compare(event_segement,sibling[leng])==false. Two segement aren't intersection 
    intersection_with_sibling_inner(event_segement,sibling,leng-1,inter_p);

//     /*

function segements_intersection(event_points)=  
      let(tree=[index_of_segement(0)])         
      let(inter=[])
      let(event_points_=dequeue(event_points))
      segements_intersection_inner(leng,pivot,tree,inter,event_points_);

function segements_intersection_inner(tree,inter,event_points)=
      leng(event_points)-1<0? inter:
      
      let(section=section_of_segement(event_points[0]))
      
      section==upper?  //First,determine what type the new event point is.       
      let(event_segement=index_of_segement(event_points[0]))  //which segement
      //push segement into new_tree. [[segements],[sibling]]
      let(new_tree=insert_tree(tree,event_segement))  
      let(tree_=get_tree(new_tree))
      let(sibling=get_sibling(new_tree))
      
      let(event_points_=dequeue(event_points))
      //find the intersection with sibling
      let(intersection_p=intersection_with_sibling(event_segement,sibling))
      
      leng(intersection_p)-1<0?
      segements_intersection_inner(tree_,inter,event_points_):
      //leng(intersection_p)>0
      let(inter_=concat(inter,point_of_segement(intersection_p))
      let(event_points_with_inter=push_event_points(event_points_,intersection_p))
      segements_intersection_inner(tree_,inter_,event_points_with_inter)
      
       
     section==lower?
     let(event_segement=index_of_segement(event_points[0]))
     //extract segement from tree
     let(new_tree=extract_tree(tree,event_segement))
     let(tree_=get_tree(new_tree))
     let(sibling=get_sibling(new_tree))
     
     let(event_points_=dequeue(event_points))
     //find the intersection with sibling
     let(intersection_p=intersection_with_sibling(event_segement,sibling))
     
     leng(intersection_p)-1<0? //no intersection
     segements_intersection_inner(tree_,inter,event_points_):
     let(inter_=concat(inter,point_of_segement(intersection_p))
     let(event_points_with_inter=push_event_points(event_points_,intersection_p))
     segements_intersection_inner(tree_,inter_,event_points_with_inter)
     
     
         
     ://section==inter?
     let(segement_set=index_of_segement(event_points[0]))
     let(new_tree=swap_tree(tree,segement_set))
     let(tree_=get_tree(new_tree))
     let(sibling_set=get_sibling(new_tree))
     
     let(event_points_=dequeue(event_points))
     let(intersection_p=[ for(i=[0:len(sibling_set)-1])
                         intersection_with_sibling(i[0],[i[1]])]) //!!!!!!!!!!!!
         ;
     leng(intersection_p)-1<0? //!!!!!!!!!!!!!!!!!!!!
     segements_intersection_inner(tree_,inter,event_points_)://!!!!!!!!!!
     let(inter_=concat(inter,point_of_segement(intersection_p))) //!!!!!!!!!!!!
     let(event_points_with_inter=push_event_points(event_points_,intersection_p))//!!!!!!!!
     segements_intersection_inner(tree_,inter_,event_points_with_inter);//!!!!!!!!
//     */






















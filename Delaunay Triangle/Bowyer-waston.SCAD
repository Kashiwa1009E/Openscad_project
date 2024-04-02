//Bowyer-waston 

/*
function BowyerWaston(pointList)
//pointList is a set of coordinates defining the points to be triangulated 
triangulation:=empty triangle mesh data structure 
add super_triangle to triangulation 

badTriangles:=empty set 
     for each point in pointList do//add all the points one at a time to the triangulation 
     　　　　if point is inside circumcircle of triangle 
     　　　　add triangle to badTriangles
     polygon:=empty set 
     for each triangle in badTriangles do//find the boundary of the polygonal hole 
         for each edge in triangle do 
             if edge is not shared by any other triangles in badTriangles 
                 add edge to polygon 
        
         for each triangle in badTriangles do //remove the from the data structure 
              remove triangle from triangulation   
              
         for each edge in polygon do // re-triangulate the polygonal hole 
             newTri :=form a triangle from edge to point 
             add newTri to triangulation 
    for each triangle in triangulation // done inserting points, now clean up 
         if triangle contains a vertex from original super-triangle 
              remove triangle from triangulation 
    return triangulaion     
    
*/
function bw(points)=
    let(triangulation=[])
    let(super_tri=[a,b,c])
    let(triangulation_=append(triangulation,super_tri))
    let(count_p=0)
    let(leng=len(points)-1)
    bw_inner(points,triangulation_,count_p,leng);

function bw_inner(points,triangulation,count_p,leng,super_tri)=
    count_p>leng? remove_original_super_tri(triangulation,super_tri):
    let(insert_p=points[count_p])
    let(bad_triangles=bad_tri(triangulation,insert_p))
    let(polygonal=polygonal_points(bad_triangles))
    let(triangulation_remove=remove(triangulation,bad_triangles))
    let(re_triangulate=retriagulate(polygonal,insert_p))
    let(new_tri=concat(triangulation_remove,re_triangulate))
    bw_inner(points,new_tri,count_p+1,leng);
    
function remove_duplicated_segement(segements)=
     let(leng=len(segements)-1)
     leng<1?segements:
     let(pivot=segements[0])
     let(before=[for(i=[1:leng])
            if(segements[i].x<pivot.x && 
            segements[i].x != pivot.y &&
            segements[i].y != pivot.x)
            segements[i]])
     let(after=[for(i=[1:leng])
           if(segements[i].x>=pivot.x &&
              segement[i].y !=pivot.y)
              segements[i]])
      [each remove_duplicated_segement(before),
       pivot,
       each remove_duplicated_segement(after)];     
           
function line(triangulation)= 
     let(lines=[])
     let(count_t=0)
     let(leng=len(triangulation)-1)
     line_inner(lines,count_t,leng,triangulation);
function line_inner(lines,count_t,leng,triangulation)=
     count_t>leng?  lines:
     let(segements=segement(triangulation[count_t]))
     let(lines_=append_line(lines,segements))
     line_inner(lines_,count_t+1,leng,triangulation);
 
function segement(triangle)=
     let(segement_1=[triangle[0],triangle[1]])
     let(segement_2=[triangle[1],triangle[2]])
     let(segement_3=[triangle[2],triangle[0]])
     [segement_1,segement_2,segement_3]; 

function append_line(array,num)=
    [for(i=array)i,each num];
  
 
function remove_original_super_tri(triangulation,super_tri)=
     let(count_t=0)
     let(leng=len(triangulation)-1)
     let(valid_tri=[])
     remove_original_super_tri_inner(triangulation,super_tri,count_t,leng,valid_tri);
function remove_original_super_tri_inner(triangulation,super_tri,count_t,leng,valid_tri)=
    count_t>leng? valid_tri: 
    contain(triangulation[count_t],super_tri)==true?
    remove_original_super_tri_inner(triangulation,super_tri,count_t+1,leng,valid_tri):
    let(valid_tri_=append(valid_tri,triangulation[count_t]))
    remove_original_super_tri_inner(triangulation,super_tri,count_t+1,leng,valid_tri_);    
      
function contain(triangle,super_tri)=
     let(count_t=0)
     let(leng=len(triangle)-1)
     contain_inner(triangle,super_tri,count_t,leng);
function contain_inner(traingle,super_tri,count_t,leng)=
     count_t>leng? false:
     triangle[count_t].x==super_tri[0].x && triangle[count_t].y==super_tri[0].y ||
     triangle[count_t].x==super_tri[0].x && trianlge[count_t].y==super_tri[0].y ||
     triangle[count_t].x==super_tri[0].x && triangle[count_t].y==super_tri[0].y ?
     true: 
     contain_inner(triangle,super_tri,count_t+1,leng);
      
     
function remove(triangulation,bad_triangles)= 
    let(triangles=concat(triangulation,bad_triangles))
    let(triangles_sort=quick_sort_tri(triangles))
    triangles_sort;
    
function quick_sort_tri(triangles)=
     let(leng=len(triangles)-1)
     leng<1? triangles:
     let(pivot=triangles[0])
     let(before=[for(i=[1:leng])
                 if(triangles[i]<pivot)
                     triangles[i]
                 ])
     let(after=[for(i=[1:leng])
                if(triangles[i]>pivot)
                     triangles[i]
                ])  
      [each quick_sort_tri(before),pivot,each quick_sort_tri(after)];
                             

function bad_tri(triangulation,insert_p)=
    let(count_tri=0)
    let(leng=len(triangulation)-1)
    let(bad_triangles=[])
    bad_tri_inner(triangulation,bad_triangles,count_tri,leng);
function bad_tri_inner(triangulation,bad_triangles,count_tri,leng)=
    count_tri>leng? bad_triangles:
    let(tri=triangulation[count_tri])
    is_in_circumstance(tri,insert_p)==true?
    let(bad_triangles_=append(bad_triangles))
    bad_tri_inner(triangulation,bad_triangles_,count_tri+1,leng):
    bad_tri_inner(triangulation,bad_triangles,count_tri+1,leng);
    
 /*  
function is_in_circumstance(triangulate,insert_p)=
*/
 
function polygonal_points(bad_triangles)=
    let(polygonal=[])
    let(count_bt=0)
    let(leng=len(bad_triangles))
    polygonal_points_inner(bad_triangles,polygonal,count_bt,leng);

function polygonal_points_inner(bad_triangles,polygonal,count_bt,leng)=
   count_bt>leng? polygonal:
   let(tri=bad_triangles[0])
   let(polygonal_=append(polygonal,tri))
   let(polygonal_sort=quick_sort(polygonal_))
   polygonal_points_inner(bad_triangles,polygonal_sort,count_bt+1,leng);
   
function quick_sort(points)=
     let(leng=len(points)-1)
     leng<1? points:
     let(pivot=points[0])
     let(before=[for(i=[1:leng])
                 if(points[i].x<pivot.x && points[i].y!=pivot.y)
                     points[i]
                 ])
     let(after=[for(i=[1:leng])
                if(points[i].x>=pivot.x && points[i].y!=pivot.y)
                    points[i]
                ])  
      [each quick_sort(before),pivot,each quick_sort(after)];

         
function retriagulate(polygonal_hole,insert_p)=
     let(triangulation=[])     
     let(firt=polygonal_hole[0])
     let(triangulate_mesh=[polygonal_hole[0],polygonal_hole[1],insert_p])
     let(triangulation_=enqueue(triangulation,triangulate_mesh))
     let(polygonal_hole_de=dequeue(polygonal_hole))
     let(polygonal_hole_=enqueue(polygonal_hole_de,insert_p))
     retriagulate_inner(first,triangulation_,polygonal_hole_,insert_p);
function retriagulate_inner(first,triangulation,polygonal_hole,insert_p)=
     polygonal_hole[0]==first?triangulation:
     let(triangulate_mesh=[polygonal_hole[0],polygonal_hole[1],insert_p])
     let(triangulation_=enqueue(triangulation,triangulate_mesh))
     let(polygonal_hole_de=dequeue(polygonal_hole))
     let(polygonal_hole_=enqueue(polygonal_hole_de,insert_p))
     retriagulate_inner(first,triangulation_,polygonal_hole_,insert_p);
  
  
function dequeue(queue)=
    let(leng=len(queue)-1)
    let(init=0)
    leng==0?[]:
    [for(i=[init+1:leng])
         queue[i]       
    ];
function enqueue(queue,num)=
    [for(i=queue)
        i,num];
         
  
   
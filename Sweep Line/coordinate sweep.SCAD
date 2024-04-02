function quick_sort(points)=
     let(leng=len(points)-1)
     leng<1? points:
     let(pivot=points[0])
     let(before=[for(i=[1:leng])
                 if(compare(points[i],pivot))
                  points[i]
                 ])
     let(after=[for(i=[1:leng])
                if(compare(points[i],pivot)==false)
                    points[i]
                ])  
      [each quick_sort(before),pivot,each quick_sort(after)];
            

function compare(p1,p2)=
                p1.x<p2.x || (p1.x==p2.x && p1.y<p2.y)? true :false;
            
            
 echo(quick_sort([[1,1],[1,4],[4,5],[1,-3]]));   
          
               
               
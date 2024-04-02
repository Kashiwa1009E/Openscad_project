    
function line(triangulation)= 
     let(lines=[])
     let(count_t=0)
     let(leng=len(triangulation)-1)
     line_inner(lines,count_t,leng,triangulation);
function line_inner(lines,count_t,leng,triangulation)=
     count_t>leng?  lines:
     let(segements=segement(triangulation[count_t]))
     let(lines_=append(lines,segements))
     line_inner(lines_,count_t+1,leng,triangulation);
 
function segement(triangle)=
     let(segement_1=[triangle[0],triangle[1]])
     let(segement_2=[triangle[1],triangle[2]])
     let(segement_3=[triangle[2],triangle[0]])
     [segement_1,segement_2,segement_3]; 
  
    
triangulation=[[1,2,3],[3,4,5],[4,5,6],[1,2,3]];
echo(line(triangulation));


function append(array,num)=
    [for(i=array)i,each num];


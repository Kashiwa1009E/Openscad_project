function sort(list)=
     let(leng=len(list))
     leng<=1? list:
 
          let(
               pivot=list[0],
              
               before=[for(j=1;j<leng;j=j+1) 
               if(list[j]<pivot) 
                    list[j]],               
               
               after=[for(j=1;j<leng;j=j+1)
               if(list[j]>=pivot)
                    list[j]]
               
               ) 
              
     [each sort(before),pivot,each sort(after)];   
            
            
            
 echo(sort([7,3,1,6,9]));   
          
               
               
 
              
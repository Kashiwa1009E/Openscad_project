function minimun(list)=
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
     [each minimun(before)];   
            
 echo(minimun([7,3,2,6,9]));   
          
               
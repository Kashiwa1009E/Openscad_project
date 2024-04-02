list=[[1,true],[1,true],[3,true],[5,[true]]];

echo(list);

function find(init_value,list)=
    let(leng=len(list)-1)
    init_value==leng?[
    list[init_value][1]==false?1:0
    ]:
    concat(list[init_value][1]==false?1:0,
    find(init_value+1,list)
    );


function sum(list)=
      let(leng=len(list))
      leng==1?list[0]:
      leng==2?list[0]+list[1]:
      let( 
          sum_first=list[0]+list[1],
          sum_after=[for(i=[2:leng-1])
              list[i]])    
      sum(concat(sum_first,sum_after));
          


function visited_all_or_not(list)=
     let(num=sum(list))
          num==0?true:false;


echo(visited_all_or_not(find(0,list)));


   
         
    

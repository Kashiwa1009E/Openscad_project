function start_list(columns)=[
     for(i=[0:columns-1])
         [i,false]
];   
     
function get_type(x,list)=list[x][1];
function get_x(x,list)=list[x][0];

function rnd_value(init_value,end_value)=round(rands(init_value,end_value,1)[0]);     
       
function visited(x,list)=[
     for( i = list)
         i[0]==x?[i[0],true]:i];
     
     
//------------------------------------------     


function isTrue(init_value,list,leng)=
     let(rnd_num=rnd_value(1,leng-1))
         init_value==0?0:
         get_type(rnd_num,list)==true ?
         isTrue(init_value,list,leng):rnd_num;  
  
//------------------------------------------     
function nrr_inner(list,leng,rnd_counts,init_value)=
     let(num=isTrue(init_value,list,leng))
     init_value==rnd_counts?[leng]:
     concat(
     num,
     nrr_inner(visited(num,list),leng,rnd_counts,init_value+1));
//------------------------------------------          
function non_repeat_rnd(
     list
     )=
 let(leng=len(list)-1,
     rnd_counts=rnd_value(1,leng-1)
     )
     echo(rnd_counts+1) 
     nrr_inner(list,leng,rnd_counts,0);
     

 
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
            
            
            
 echo(sort(non_repeat_rnd(start_list(10))));   
          
               
               
 
              
 
  
               
               
  
  
          
   
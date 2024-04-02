
//--------test list------------------
function start_list(init_val,end_val)=
    init_val==end_val?[end_val]:
    concat(init_val,
    
    start_list(init_val+1,end_val)
    );



function starting_list(init_val,end_val)=[
    for(i=[init_val:end_val])
    i
   ];
    
//--------------------------    
    
    




list=starting_list(0,100);

function fliter_odd(init_val,list)=
     init_val==len(list)?[]:
     
     
     concat(
          list[init_val]%2==0?
          list[init_val]:[]
     ,
     fliter_odd(init_val+1,list));
     
//echo(fliter_odd(0,list));


function fliter_add(init_val,list)=
     init_val==len(list)?[]:
     concat(
           list[init_val]%2!=0?
           list[init_val]:[]
           ,
           fliter_add(init_val+1,list));
           
     

// echo(fliter_add(0,list));
 

 
     
 function fliter_isPrime(list)=[                  for(i =list)
         if (i>2)
         for(j=[2:i-1])
              if (i%j==0)
          [i,j]];
              /*
function isPrime(list,fliter_isPrime(list))=[
   for(i=list)
        if i!==fliter_isPrime(list)[0]
              [i]      
              ]              
             */ 
echo(fliter_isPrime(list)); 
   
              
function unique_values(list)=[
              
           
              
              ]
     
   
      
    
     
          
          
          
          
          

     

 
     
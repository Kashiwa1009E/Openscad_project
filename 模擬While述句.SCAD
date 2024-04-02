
/*
function my_while(condition,action)=
     if(condition()){
         action();
         my_while(condition,action); 
         }   */
         
//   instance


module my_while(count,condition){
      if (count<condition){
          echo(count);
          my_while(count+1,condition);
      }
  }
 my_while(1,10);
   
      
    
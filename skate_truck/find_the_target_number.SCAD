
/*
list=[1,3,5,3,6,9,10,11];


function find_the_number(target_num,list)=
           let (leng=len(list))
           let (num=[
               for(i=[0:leng-1])
                   if(list[i]==target_num)
                      i
           ])
          [each num]; 
                 
echo(find_the_number(3,list));
*/


//由後數回來---------------------------
/*
  list=[3,24,1,54,24,19,1,2];
function ftn(target_num,list)=
     let(count_num=len(list)-1)
          ftn_inner(target_num,list,count_num);

function ftn_inner(target_num,list,count_num)=
    count_num>0?
     target_num==list[count_num]?
          count_num:
        ftn_inner(target_num,list,count_num-1)
         :[];
         
 echo(ftn(1,list));


 //----------------------------------
*/ 


//由前數後----------------------------------------
   list=[3,24,1,54,24,19,1,2];
function ftn(target_num,list)=
     let(count_num=0)
          ftn_inner(target_num,list,count_num);

function ftn_inner(target_num,list,count_num)=
    count_num<len(list)-1?
     target_num==list[count_num]?
          count_num:
        ftn_inner(target_num,list,count_num+1)
         :[];
         
 echo(ftn(1,list));
 
 //--------------------------------------
 
 
 
 
 
 
 
 
 
 
 
 
 
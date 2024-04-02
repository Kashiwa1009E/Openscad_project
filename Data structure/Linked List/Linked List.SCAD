n1=2;
n2=10;
n3=6;


n1_next=n_next(n1,n1,n2,n3);
n2_next=n_next(n2,n1,n2,n3);

function n_next(n,n1,n2,n3)=
      let(pointer=
               n==n1?
                  n2:
               n==n2?
                  n3:
               undef
          ) 
          pointer;  

function linked_list(head,n1,n2,n3)=
       let(next=n_next(head,n1,n2,n3))
       next==undef?[]:
       let(array=[head])
       linked_list_inner(head,n1,n2,n3,array);
       
function linked_list_inner(head,n1,n2,n3,array)=
        let(next=n_next(head,n1,n2,n3))
          next==undef? array:
         
         linked_list_inner(
                n_next(head,n1,n2,n3),
                n1,
                n2,
                n3,
                insert_array(next,array)
         );

function insert_array(num,array)=
      let(new_array=[
                    for(i=array)
                       i ,num])
         new_array;           



echo(linked_list(n1,n1,n2,n3));








// coefficient matrix

A=[[0,2,2,1],
   [1,1,1,1],
   [3,4,5,19]
  ];

function coefficient_matrix(matrix)=
      let(new_matrix=quick_sort(matrix,0))
      let(init=0)
      let(pivot_index=0)
      coefficient_matrix_inner(new_matrix,init,pivot_index);
      
function coefficient_matrix_inner(matrix,init,pivot_index)=
     let(leng=len(matrix)-1)
     init>leng-1? matrix:
     let(pivot=matrix[init][pivot_index])
     pivot==0?
     coefficient_matrix_inner(matrix,init,pivot_index+1):
     let(after_delete=delete_pivot(matrix,init,pivot_index))
     let(after_sort=quick_sort(after_delete,pivot_index))
     coefficient_matrix_inner(after_delete,init+1,pivot_index+1);
                 
function delete_pivot(matrix,init,pivot_index)=
       let(pivot=matrix[init][pivot_index])
       let(new_matrix=
                   concat([for(i=[0:init])
                   matrix[i]],[
                   for(i=[init+1:len(matrix)-1]) 
                   matrix[i]-((matrix[i][pivot_index]/
              matrix[init][pivot_index])*matrix[init])]))     
        new_matrix;      
   

function quick_sort(matrix,pivot_index)=
     let(leng=len(matrix)-1)
     leng<1? matrix:    
     let(before=[for(i=[0:leng])
                 if(matrix[i][pivot_index]!=0)matrix[i]])
      let(after=[for(i=[0:leng])
                 if(matrix[i][pivot_index]==0)matrix[i]])
   [each before,each quick_sort(after,pivot_index+1)];           
  
echo(coefficient_matrix(A));              
               
echo(quick_sort(A,0));               
echo(delete_pivot(quick_sort(A,0),0,0));               
             
                               
        
        
                 
/*
function pivotal_row(matrix)=
     let(pivot=0)
     let(index=0)
     let(m=len(matrix)-1)
     let(n=len(matrix[0])-2)
          pivotal_row_inner(matrix,pivot,index,m,n);
    
function pivotal_row_inner(matrix,pivot,index,m,n)=     
     pivot>n? undef:     
     matrix[index][pivot]!=0? index:     
     index>=m?
     let(pivot_=pivot+1)
     let(index_=0)
     pivotal_row_inner(matrix,pivot_,index_,m,n):
     pivotal_row_inner(matrix,pivot,index+1,m,n);
     
echo(pivotal_row(A));    
  */   
 
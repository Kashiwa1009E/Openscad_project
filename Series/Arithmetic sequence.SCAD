
//Arithmetic sequence 

/*
function ari_seq(a1,d,n)=
     n==1? a1:
     a1+(n-1)*d;
  */   

function ari_seq(d,adj,n)=
     [for(i=[1:n])
      d*i+adj   
     ];

echo(ari_seq(3,1,10));
echo(ari_seq(-4,3,10));

//geometric_sequence-------------------
    
function geometric_seq(base,adj,n)=
     [for(i=[1:n])
         adj*pow(base,i)    
     ];
     
echo(geometric_seq(2,3,10));



//recrution_sequence-----------------------     

function recrution_seq(a1,a2,n)=
     [for(i=[1:n]) 
         recrution_seq_inner(a1,a2,i)];

function recrution_seq_inner(a1,a2,n)=
     n==1? a1: 
     n==2? a2:
     let(an=recrution_seq_inner(a1,a2,n-1)+recrution_seq_inner(a1,a2,n-2))
     an;      

echo(recrution_seq(1,1,10));

//------------------------------------

/* input:[a1,a2]
   output:[d,adj]
*/
function general_item(a1,a2)=
     let(d=a2-a1)
     let(adj=a1-d)
     [d,adj];

echo(general_item(-1,-5));


/*
arithmetic progression

差成階梯狀→　皆差數列 
*/
function ari_progression(n)=
     [for(i=[1:n]) pow(i,2)+1];



echo(ari_progression(10));


function ari_test(n)=
     [for(i=[1:n]) 1/i*(i+1)];
         
echo(ari_test(10));



//Sum of arithmetic sequence 

function sum_of_ari_seq(a1,d,n)=
    let(an=a1+(n-1)*d)
    n==1? a1:
    (a1+an)/2;
    
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

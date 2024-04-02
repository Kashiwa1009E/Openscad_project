
/*

function test()= [   for(i=[-100:0.01:100])
    i==0?[0,0]:
    [i,abs(log(2,abs(i)))]]
     ;
  */       

function test()= [   for(i=[0.00001:0.01:100])
    i==0?[0,0]:
    [i,pow(i,log(10,i))]]
     ;



for(i=test())
    translate(i)
         sphere(0.5);
/*
echo(-2,log(2,))       
    */     


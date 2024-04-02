//Linear Search
//Sequential Search 

//inedx 0,1,2,3,4,5,6,7
//num   4,2,5,6,4,7,2,0


array=[3,2,5,6,1,64,4,29,0,13];
target=1;

function Linear_Search(target,points)=
    let(leng=len(points)-1)
[   for(i=[0:leng])
    if (points[i]==target)
    each[i]
];

echo(Linear_Search(target,array));
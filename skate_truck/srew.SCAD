////$fn=100;
////%cylinder(10);
//
//
//
//
//
//
//hight=30;
//p=1.5;
//diameter=5;
//
//
////一圈60個
//slices=90;
//
//
//positions=[ for(i=[0:slices*(hight/p)])
//     [cos(i)*diameter/2,
//     sin(i)*diameter/2,
//     i*0.02]
//];
//
//echo(positions);
//
//
//
//for(i=positions)
//    translate(i)
//         sphere(0.3);

$fn=10;
radius=20;
levels=15;
hight=50;
level_distance=hight/levels;


a_step=360/$fn;
l_step=level_distance/$fn;


positions=[for(i=[0:a_step:360*levels])
    [radius*cos(i),
     radius*sin(i),
     i/a_step*l_step    
]
];

echo(positions);


for(i=positions)
    translate(i)
         sphere(0.8);






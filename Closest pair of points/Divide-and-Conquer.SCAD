//Divide-and-Conquer Method

/*
分成左右兩側
三種情形
1.最近點對在左側
2.最近點對在右側
3.最近點對橫跨兩側

先將左側與右側分別遞迴求解之後，
再利用左側與右側的答案，快速算出橫跨兩側的答案。

*/

/*
Preprocessing:
一.排序所有點，以X座標為主，Y座標無所謂。0(NlogN)
二.檢查是否有共點。如果有，就找出所有共點，演算法結束。0(N)

Divide:
把所有點分為左右兩側，左側，右側的點數盡量一樣多。

Conquer:
左側、右側分別遞迴求解。

Combine:

*/


//random points---------------------------------
function rnd_v(init_value,end_value)=round(rands(init_value,end_value,1)[0]);

init_value=0;
end_value=1000;
points_num=5 ;


points=[
for(i=[0:points_num-1]
    )
    [rnd_v(init_value,end_value),
     rnd_v(init_value,end_value)
    ]];
for(i=points)
    translate(i)
        sphere(10);
        
  
//quick_sort------------------------------------
function quick_sort(points)=
     let(leng=len(points)-1)
     leng<1? points:
     let(pivot=points[0])
     let(before=[for(i=[1:leng])
                 if(points[i].x<pivot.x)
                     points[i]
                 ])
     let(after=[for(i=[1:leng])
                if(points[i].x>=pivot.x)
                    points[i]
                ])  
      [each quick_sort(before),pivot,each quick_sort(after)];          
//---------------------------------------------------


function hypo(x,y)=
     pow(pow(x,2)+pow(y,2),0.5);

function middle_num(points)=
         let(leng=len(points)-1)
                leng%2!=0? 
                let(middle_num=round(leng/2))
                [middle_num-1,middle_num,]:
                leng/2; 
                
echo(middle_num(points));






















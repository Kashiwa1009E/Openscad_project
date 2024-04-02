
//點積結果是一個純量
function dot(v1,v2)=
    v1.x*v2.x+v1.y*v2.y;
    
//兩個向量做叉積的結果為一個向量    
function cross_(v1,v2)=
    v1.x*v2.x-v1.y*v2.x;


function length(v)=
    pow(pow(v.x,2)+pow(v.y,2),0.5);

//點積、叉積跟長度的關係--------------------

// 點積取絕對值，再除以底向量長度，取得底
function base(po,p1,p2)=
    let(v1=p1-po)
    let(v2=p2-po)
    let(base=abs(dot(v1,v2))/length(v1))
    base_height;
    
//叉積取絕對值，再除以底向量長度，取得高   
function height(po,p1,p2)=
    let(v1=p1-po) 
    let(v2=p2-po)
    let(height=abs(cross(v1,v2)/length(v1)))
    height;


//點積、叉積跟角度的關係--------------------    
//acos 跟 asin 的回傳值是弳度量(radian)而非度量(grade)

function cos_(po,p1,p2)=
    let(v1=p1-po)
    let(v2=p2-po)
    let(l1=length(v1))
    let(l2=lenth(v2))
    let(cos_=dot(v1,v2)/(l1*l2));
    let(radian=acos(cos_));
    radian;
    
function sin_(po,p1,)    
　  let(v1=p1-po)
    let(v2=p2-po)
    let(l1=length(v1))
    let(l2=length(v2))
    let(sin_=cross_(v1,v2)/(l1*l2));
    let(radian=asin(sin_));
    radian;

//點積與向量夾角
/*

利用點積的性質，可以粗略判斷夾角大小
點積>0 兩項量夾角<90度
   =0 兩項量夾角=90度
   <0 夾角大於90且 180>角度>90
*/


//叉積與向量旋轉

/*
利用叉積的性質，可以粗略判斷夾角方向
叉積>0 兩向量前後順序為逆時針順序(在180之內)
   =0 兩向量平行  夾角=0或 180
   <0 兩向量前後順序為順時針順序(在180之內)
*/














    

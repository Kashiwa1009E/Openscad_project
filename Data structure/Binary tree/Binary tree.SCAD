

data=[10,21,5,9,13,28];
                                  
function create_btree(data)=
     let(leng=len(data)-1)
     let(level=0)
     let(init_num=0)
     let(btree=data[level])
     data[level]!= true? []:
     create_btree_inner(data,leng,level,init_num+1,[data[level]]);    
      
     
function create_btree_inner(data,leng,level,init_num,btree)=
    init_num>=leng? btree:
    
    let(root_node=data[level])
    
    create_btree_inner(data,
                       leng, 
                       level,
                       init_num+1,
                       insert_btree(btree,
                                    which_level(level,
                                                btree,
                                                data,
                                                data[init_num],
                                                root_node
                                                ),
                                    data[init_num]            
                                                ));    
 
 
function which_level(level,btree,data,target_num,root_node)=

     root_node==undef || root_node==0 ? level:
     let(new_level=target_num>root_node?
             2*level+2:
             2*level+1)
    which_level(new_level,btree,data,target_num,btree[new_level]);
     
     
     
function insert_btree(btree,level,num)=
   let(leng=len(btree)-1)
   level>leng?
   [for(i=[0:level])
        btree[i]!=undef ? btree[i]:
        i==level? num:
        0  
   ]:
   [for(i=[0:leng])
       i==level?num:
       btree[i] 
   ];


echo(create_btree(data));











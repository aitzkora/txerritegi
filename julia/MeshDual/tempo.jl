using MeshDual

ENV["METIS_LIB"]="/home/fux/sources/metis_modify/build/libmetis/libmetis.so"

m = Mesh([[1,2,3],
          [1,2,6],
          [2,6,5],
          [2,5,7],
          [2,7,4],
          [2,4,3]])

ptr, ind, ne  = mesh_to_scotch_fmt(m)

g1 = graph_dual_new(m, 1)
g2 = graph_dual_new(m, 2)
g3 = graph_dual_new(m, 3)
 
m1 = metis_graph_dual(m, 1)
m2 = metis_graph_dual(m, 2)
m3 = metis_graph_dual(m, 3)

m1p = graph_dual(m, 1);
m2p = graph_dual(m, 2);
m3p = graph_dual(m, 3);

@assert map(x->x .- 1, m1p.adj) == g1
@assert map(x->x .- 1, m2p.adj) == g2
@assert map(x->x .- 1, m3p.adj) == g3


@assert m1 == m1p
@assert m2 == m2p
@assert m3 == m2p # yes it is m2, due to the special heuristic of metis

eptr = Cint[ 0, 3, 6, 9, 12, 15, 18]
eind = Cint[0, 1, 2, 0, 1, 5, 1, 5, 4, 1, 4, 6, 1, 6, 3, 1, 3, 2]
xadj, adjncy = metis_mesh_to_dual(ne=6, nn= 7, eptr=eptr, eind=eind, ncommon = 1, baseval=0)

eptr = Cint[ 1, 4, 7, 10, 13, 16, 19]
eind = Cint[ 0, 1, 2, 3, 1, 2, 6, 2, 6, 5, 2, 5, 7, 2, 7, 4, 2, 4, 3]
xadj1, adjncy1 = metis_mesh_to_dual(ne=6, nn= 7, eptr=eptr, eind=eind, ncommon = 1, baseval=1)

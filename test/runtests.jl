using ObaraSaika
using Test

@testset "ObaraSaika.jl" begin
    @test ObaraSaika.get_ijk_list(0) == Array{Int, 1}[[0,0,0]]
    @test ObaraSaika.get_ijk_list(1) == Array{Int, 1}[[1,0,0],[0,1,0],[0,0,1]]
    @test ObaraSaika.get_ijk_list(2) == Array{Int, 1}[[2,0,0],[1,1,0],[1,0,1],[0,2,0],[0,1,1],[0,0,2]]

    @test ObaraSaika.get_shell2(0, 0) == Array{Int, 1}[
        [0, 0, 0, 0, 0, 0]
    ]
    @test ObaraSaika.get_shell2(0, 1) == Array{Int, 1}[
        [0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 1]
    ]
    @test ObaraSaika.get_shell2(1, 0) == Array{Int, 1}[
        [1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0]
    ]
    @test ObaraSaika.get_shell2(0, 2) == Array{Int, 1}[
        [0, 0, 0, 2, 0, 0],
        [0, 0, 0, 1, 1, 0],
        [0, 0, 0, 1, 0, 1],
        [0, 0, 0, 0, 2, 0],
        [0, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 0, 2]
    ]
end

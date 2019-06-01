function get_ijk_list(m)
    l = Array{Int, 1}[]
    for a = 1 : m + 1
        for b = 1 : a
            i = m + 1 - a
            j = a - b
            k = b - 1
            push!(l, [i, j, k])
        end
    end
    return l
end

function test_get_ijk_list()
    l0 = get_ijk_list(0)
    l1 = get_ijk_list(1)
    l2 = get_ijk_list(2)
    # Is there a cleaner way to specify these arrays?
    @assert l0 == Array{Int, 1}[[0,0,0]]
    @assert l1 == Array{Int, 1}[[1,0,0],[0,1,0],[0,0,1]]
    @assert l2 == Array{Int, 1}[[2,0,0],[1,1,0],[1,0,1],[0,2,0],[0,1,1],[0,0,2]]
end

function get_shell4(a, b, c, d)
    components = Array{Int, 1}[]
    for p in get_ijk_list(a)
        for q in get_ijk_list(b)
            for r in get_ijk_list(c)
                for s in get_ijk_list(d)
                    push!(components, vcat(p, q, r, s))
                end
            end
        end
    end
    return components
end

function get_shell2(a, b)
    components = Array{Int, 1}[]
    for p in get_ijk_list(a)
        for q in get_ijk_list(b)
            push!(components, vcat(p, q))
        end
    end
    return components
end

function test_get_shell2()
    a0b0 = get_shell2(0, 0)
    @assert a0b0 == Array{Int, 1}[
        [0, 0, 0, 0, 0, 0]
    ]
    a0b1 = get_shell2(0, 1)
    a1b0 = get_shell2(1, 0)
    @assert a0b1 == Array{Int, 1}[
        [0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 1]
    ]
    @assert a1b0 == Array{Int, 1}[
        [1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0]
    ]
    a0b2 = get_shell2(0, 2)
    @assert a0b2 == Array{Int, 1}[
        [0, 0, 0, 2, 0, 0],
        [0, 0, 0, 1, 1, 0],
        [0, 0, 0, 1, 0, 1],
        [0, 0, 0, 0, 2, 0],
        [0, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 0, 2]
    ]
end

# TODO need to implement the X2 type
# TODO need to implement the X4 type

function list_is_flat(l)
    for x in l
        if x <: Array
            return false
        end
    end
    return true
end

function flatten_sub(l)
    return [item for sublist in l for item in sublist]
end

function flatten(l)
    l_out = deepcopy(l)
    max_tries = 50
    for _ = 1 : max_tries
        if list_is_flat(l_out)
            return l_out
        else
            l_out = flatten_sub(l_out)
        end
    end
    # thrown an error?
    # sys.stderr.write('ERROR: max depth reached in flatten\n')
    # sys.exit(1)
end

function find_fun_to_lower(q, n)

    # Determine the total angular momentum on each center.
    l = Int[]
    for i = 1 : n
        push!(l, q[i*3] + q[i*3 + 1] + q[i*3 + 2])
    end

    # find function to lower
    # start with lowest angular momentum above s
    fun = -1
    kmax = max(l) + 1
    for i = 1 : n
        k = l[i]
        # If we're larger than an s-function...
        if k > 0
            if k < kmax
                kmax = k
                fun = i
            end
        end
    end

    return fun

end

function find_component_to_lower(fun)
    for (i, c) in enumerate(fun)
        if c > 0
            return i
        end
    end
    return -1
end

function apply_os4(x4)
    # TODO
end

function apply_os2(x, kind)
    # TODO
end

function get_r12_squared(r1, r2)
    # have an assertion that they're both length 3?
    # do some array trick rather than this crap?
    return (r1[0] - r2[0])^2.0 + (r1[1] - r2[1])^2.0 + (r1[2] - r2[2])^2.0
end

function get_k(z1, z2, r1, r2)
    r12 = get_r12_squared(r1, r2)
    f0 = z1 + z2
    if r12 > 0.0
        f1 = -z1*z2*r12/f0
        f2 = exp(f1)
    else
        f2 = 1.0
    end
    return sqrt(2.0)*f2*pi^(5.0/4.0)/f0
end

function get_rho(za, zb, zc, zd)
    z = za + zb
    n = zc + zd
    return z * n / (z + n)
end

function get_bi_center(z1, z2, r1, r2)
    z = z1 + z2
    rx = (z1*r1[0] + z2*r2[0])/z
    ry = (z1*r1[1] + z2*r2[1])/z
    rz = (z1*r1[2] + z2*r2[2])/z
    return [rx, ry, rz]
    # return (z1*r1 + z2*r2) / z
end

using GSL

function boys(n, x)
    if x > 0.0
        f = 2.0*x^(n + 0.5)
        g = gamma(n + 0.5)
        gi = 1.0 - gammainc(n + 0.5, x, regularized=True)
        return g*gi/f
    else
        return 1.0/(n*2 + 1)
    end
end


test_get_ijk_list()
test_get_shell2()

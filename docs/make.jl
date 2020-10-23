using ObaraSaika
using Documenter

makedocs(;
    modules=[ObaraSaika],
    authors="Eric Berquist <eric.berquist@gmail.com> and contributors",
    repo="https://github.com/berquist/ObaraSaika.jl/blob/{commit}{path}#L{line}",
    sitename="ObaraSaika.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://berquist.github.io/ObaraSaika.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/berquist/ObaraSaika.jl",
)

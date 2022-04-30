using Documenter
using Org

orgfiles = filter(f -> endswith(f, ".org"),
                  readdir(joinpath(@__DIR__, "src"), join=true))

for orgfile in orgfiles
    mdfile = replace(orgfile, r"\.org$" => ".md")
    read(orgfile, String) |>
        c -> Org.parse(OrgDoc, c) |>
        o -> sprint(markdown, o) |>
        s -> replace(s, r"\.org]" => ".md]") |>
        m -> write(mdfile, m)
end

makedocs(;
    format=Documenter.HTML(),
    pages=[
        "Introduction" => "index.md",
        "Usage" => "usage.md",
    ],
    repo="https://github.com/GTrunSec/cellsAnalyzer.jl/blob/{commit}{path}#L{line}",
    sitename="cellsAnalyzer.jl",
    authors = "GuangTao Zhang and contributors: https://github.com/GTrunSec/cellsAnalyzer.jl/graphs/contributors"
)

deploydocs(;
    repo="github.com/GTrunSec/cellsAnalyzer.jl",
    devbranch = "main"
)

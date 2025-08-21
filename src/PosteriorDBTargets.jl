module PosteriorDBTargets

using Pigeons 
using BridgeStan

# TODO: move that here, or switch over to PosteriorDB.jl 
#       (but we do not need the extra features of that package at the moment, 
#       and we would still need to bridge to Pigeons so maybe not high priority).
include("$(dirname(dirname(Base.pathof(Pigeons))))/test/supporting/postdb.jl")

installed() = isdir(Pigeons.mpi_settings_folder() * "/posteriordb/posterior_database")
if !installed() 
    setup_posterior_db() 
end

provide_targetIds() = map(posterior_db_list(false)) do string 
    without_suffix = string[begin:end-5]
    return Symbol(without_suffix)
end

provide_target(symbol) = log_potential_from_posterior_db("$symbol.json")

end 
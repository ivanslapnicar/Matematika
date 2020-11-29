### A Pluto.jl notebook ###
# v0.12.11

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ cc9d0080-323c-11eb-3a85-c90ff746ef6d
begin
	using Plots
	using PlutoUI
end

# ╔═╡ aa073e00-323c-11eb-0297-83e3db12248d
md"
# Opća sinusoida

Vizualizacija opće sinusoide i kosinusoide.
"

# ╔═╡ e6afb200-323d-11eb-0c1d-89d62fc72af8
md"
$(@bind A Slider(0.4:0.2:4))
$(@bind ω Slider(0.2:π))
$(@bind φ Slider(-π:0.2:π))
"

# ╔═╡ 2ab1a092-323d-11eb-18f9-a360e9c13c31
# Probajte kosinus umjesto sinusa
f(x)=A*sin(ω*x+φ)

# ╔═╡ 607227e2-323d-11eb-3a5f-2d5d34130b84
plot(f,-2π,2π,legend=false)

# ╔═╡ Cell order:
# ╟─aa073e00-323c-11eb-0297-83e3db12248d
# ╠═cc9d0080-323c-11eb-3a85-c90ff746ef6d
# ╠═2ab1a092-323d-11eb-18f9-a360e9c13c31
# ╠═607227e2-323d-11eb-3a5f-2d5d34130b84
# ╠═e6afb200-323d-11eb-0c1d-89d62fc72af8

### A Pluto.jl notebook ###
# v0.12.16

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
	using SymPy
end

# ╔═╡ aa073e00-323c-11eb-0297-83e3db12248d
md"
# Tangenta i normala

Vizualizacija tangente i normale.
"

# ╔═╡ ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# Nezvisna varijabla
x=symbols("x", real=true);

# ╔═╡ 2ab1a092-323d-11eb-18f9-a360e9c13c31
# Funkcija
f(x)=cos(x)

# ╔═╡ 7ff6b1e0-3813-11eb-1ab5-19fe919036ec
df=diff(f(x),x);

# ╔═╡ 607227e2-323d-11eb-3a5f-2d5d34130b84
begin
	# Lijevi i desni rub intervala i širina za crtanje
	a=0.0
	b=10.0
	dx=5.0
end

# ╔═╡ 47854920-3818-11eb-0c5c-3564f8022020
@bind x₀ Slider(a:0.1:b)

# ╔═╡ ca9006b0-3814-11eb-1f33-0bb96d19ad33
begin
	# x₀ i y₀=f(x₀)
	y₀=f(x₀)
	x₀,y₀
end

# ╔═╡ e07f69c0-3814-11eb-180f-351a75f67a3b
# Tangenta
t(x)=df(x₀)*(x-x₀)+y₀

# ╔═╡ 8b7bb0e0-3815-11eb-3511-dbbf3e026bc3
# Normala
n(x)=(-1.0/df(x₀))*(x-x₀)+y₀

# ╔═╡ a0e3d7fe-3814-11eb-2b06-2746249700e1
begin
	plot(f,xlims = (x₀-dx,x₀+dx), ylims = (y₀-dx,y₀+dx), aspect_ratio=1,label="Funkcija")
	plot!(t,xlims = (x₀-dx,x₀+dx), ylims = (y₀-dx,y₀+dx), label="Tangenta")
	plot!(n,xlims = (x₀-dx,x₀+dx), ylims = (y₀-dx,y₀+dx), label="Normala")
end

# ╔═╡ Cell order:
# ╟─aa073e00-323c-11eb-0297-83e3db12248d
# ╠═cc9d0080-323c-11eb-3a85-c90ff746ef6d
# ╠═ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# ╠═2ab1a092-323d-11eb-18f9-a360e9c13c31
# ╠═7ff6b1e0-3813-11eb-1ab5-19fe919036ec
# ╠═607227e2-323d-11eb-3a5f-2d5d34130b84
# ╠═ca9006b0-3814-11eb-1f33-0bb96d19ad33
# ╠═e07f69c0-3814-11eb-180f-351a75f67a3b
# ╠═8b7bb0e0-3815-11eb-3511-dbbf3e026bc3
# ╠═a0e3d7fe-3814-11eb-2b06-2746249700e1
# ╠═47854920-3818-11eb-0c5c-3564f8022020

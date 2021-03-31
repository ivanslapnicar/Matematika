### A Pluto.jl notebook ###
# v0.12.21

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

# ╔═╡ 0bdd0fc6-9203-11eb-1ea3-9fe58aca7da0
using PlutoUI, SymPy, Plots

# ╔═╡ aa073e00-323c-11eb-0297-83e3db12248d
md"
# Vektorska funkcija

Vizualizacija putanje točke $T=(f(t),g(t),h(t))$ kao hodograf vektorske funkcije realne varijable

$$\vec F(t)=f(t)\vec i +g(t)\vec j + h(t)\vec k$$

i računanje i vizualizacija brzine $\vec v(t)=\vec{F'}(t)$  i ubrzanja 
$\vec a(t)=\vec{F''}(t)$.
"

# ╔═╡ 24a51cd8-9203-11eb-17c9-2f4c9f661de1
plotly()

# ╔═╡ ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# Nezvisna varijabla
t=symbols("t", real=true);

# ╔═╡ 2ab1a092-323d-11eb-18f9-a360e9c13c31
# Vektorska funkcija - Položaj točke T u trenutku t
s=(cos(t),2sin(t),2t)

# ╔═╡ d1cedc8e-827d-11eb-3029-05c983ea391f
# Vremenski interval
I=0:0.01:20

# ╔═╡ b48a9c60-828b-11eb-30de-dfc0dd06dc64
# Putanja
T=[subs.(s,t,x) for x in I]

# ╔═╡ ec3548d0-827d-11eb-0448-19c055c84fa8
# Nacrtajmo putanju
plot3d(T,xlabel="x",ylabel="y",label="Putanja")

# ╔═╡ f283ad40-8281-11eb-2046-af757fa13c7b
begin
	# Brzina i ubrzanje su vektori
	v=diff.(s,t)
	a=diff.(v,t)
end

# ╔═╡ cc522230-8288-11eb-0795-d7f5a8dfce69
# Na primjer
subs.(v,t,1),subs.(a,t,1)

# ╔═╡ fe11c640-827e-11eb-31a7-1f3008f993d6
@bind x Slider(I[1]:I[5]-I[1]:I[end],show_value=true)

# ╔═╡ 794c55d0-8281-11eb-180d-97b6176aff70
begin
	# Nacrtajmo putanju, točku, brzinu i ubrzanje
	# Putanja
	plot3d(T,xlabel="x",ylabel="y",label="Putanja")
	# Točka
	scatter!(subs.(s,t,x),label="Točka",ms=2,color=:black)
	# Brzina
	plot!([subs.(s,t,x), subs.(s.+v,t,x)], label="Brzina", lw=2, arrow=:arrow, lc=:red)
	# Ubrzanje
	plot!([subs.(s,t,x), subs.(s.+a,t,x)], label="Ubrzanje", lw=2, arrow=:arrow, lc=:green)
end

# ╔═╡ Cell order:
# ╟─aa073e00-323c-11eb-0297-83e3db12248d
# ╠═0bdd0fc6-9203-11eb-1ea3-9fe58aca7da0
# ╠═24a51cd8-9203-11eb-17c9-2f4c9f661de1
# ╠═ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# ╠═2ab1a092-323d-11eb-18f9-a360e9c13c31
# ╠═d1cedc8e-827d-11eb-3029-05c983ea391f
# ╠═b48a9c60-828b-11eb-30de-dfc0dd06dc64
# ╠═ec3548d0-827d-11eb-0448-19c055c84fa8
# ╠═f283ad40-8281-11eb-2046-af757fa13c7b
# ╠═cc522230-8288-11eb-0795-d7f5a8dfce69
# ╠═fe11c640-827e-11eb-31a7-1f3008f993d6
# ╠═794c55d0-8281-11eb-180d-97b6176aff70

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

# ╔═╡ cc9d0080-323c-11eb-3a85-c90ff746ef6d
begin
	using PlutoUI
	using SymPy
	using Plots
	plotly()
end

# ╔═╡ aa073e00-323c-11eb-0297-83e3db12248d
md"
# Vektorska funkcija

Vizualizacija putanje točke $T=(f(t),g(t),h(t))$ kao hodograf vektorske funkcije realne varijable

$$\vec F(t)=f(t)\vec i +g(t)\vec j + h(t)\vec k$$

i računanje i vizualizacija brzine $\vec v(t)=\vec{F'}(t)$  i ubrzanja 
$\vec a(t)=\vec{F''}(t)$.
"

# ╔═╡ ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# Nezvisna varijabla
t=symbols("t", real=true);

# ╔═╡ a4bd3bc0-827d-11eb-3002-e9648fcf1ef1
begin
	# Komponente vektorske funkcije
	f(t)=cos(t)
	g(t)=2sin(t)
	h(t)=2t
end

# ╔═╡ 2ab1a092-323d-11eb-18f9-a360e9c13c31
# Vektor položaja točke T u trenutku t
T=[f(t),g(t),h(t)]

# ╔═╡ 606cc190-828a-11eb-095f-9b235be449a4
subs.(T,t,1)

# ╔═╡ d1cedc8e-827d-11eb-3029-05c983ea391f
# Vremenski interval
I=0:0.01:20

# ╔═╡ b48a9c60-828b-11eb-30de-dfc0dd06dc64
# Putanja
P=[Tuple(subs.(T,t,x)) for x in I]

# ╔═╡ ec3548d0-827d-11eb-0448-19c055c84fa8
# Nacrtajmo putanju
plot3d(P,xlabel="x",ylabel="y",label="Putanja")

# ╔═╡ f283ad40-8281-11eb-2046-af757fa13c7b
begin
	# Brzina i ubrzanje su vektori
	v=diff.(T,t)
	a=diff.(v,t)
end

# ╔═╡ cc522230-8288-11eb-0795-d7f5a8dfce69
subs.(v,t,1),subs.(a,t,1)

# ╔═╡ fe11c640-827e-11eb-31a7-1f3008f993d6
@bind x Slider(I[1]:I[5]-I[1]:I[end],show_value=true)

# ╔═╡ 794c55d0-8281-11eb-180d-97b6176aff70
begin
	# Nacrtajmo putanju, točku, brzinu i ubrzanje
	# Putanja
	plot3d(P,xlabel="x",ylabel="y",label="Putanja")
	# Točka
	scatter!(Tuple(subs.(T,t,x)),label="Točka",ms=2,color=:black)
	# Brzina
	plot!([Tuple(subs.(T,t,x)), Tuple(subs.(T+v,t,x))], label="Brzina", lw=2, arrow=:arrow, lc=:red)
	# Ubrzanje
	plot!([Tuple(subs.(T,t,x)), Tuple(subs.(T+a,t,x))], label="Ubrzanje", lw=2, arrow=:arrow, lc=:green)
end

# ╔═╡ Cell order:
# ╟─aa073e00-323c-11eb-0297-83e3db12248d
# ╠═cc9d0080-323c-11eb-3a85-c90ff746ef6d
# ╠═ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# ╠═2ab1a092-323d-11eb-18f9-a360e9c13c31
# ╠═606cc190-828a-11eb-095f-9b235be449a4
# ╠═a4bd3bc0-827d-11eb-3002-e9648fcf1ef1
# ╠═d1cedc8e-827d-11eb-3029-05c983ea391f
# ╠═b48a9c60-828b-11eb-30de-dfc0dd06dc64
# ╠═ec3548d0-827d-11eb-0448-19c055c84fa8
# ╠═f283ad40-8281-11eb-2046-af757fa13c7b
# ╠═cc522230-8288-11eb-0795-d7f5a8dfce69
# ╠═fe11c640-827e-11eb-31a7-1f3008f993d6
# ╠═794c55d0-8281-11eb-180d-97b6176aff70

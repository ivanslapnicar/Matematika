### A Pluto.jl notebook ###
# v0.14.7

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
using Plots, PlutoUI, SymPy

# ╔═╡ 8ad18300-3869-11eb-251b-1faf2f0e4d6e
using Base.MathConstants

# ╔═╡ aa073e00-323c-11eb-0297-83e3db12248d
md"
# Tangenta i normala

Računanje i vizualizacija tangente i normale.
"

# ╔═╡ 4ed0642a-0e3b-4f66-99ed-69c4a80bd39f
plotly()

# ╔═╡ ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# Nezvisna varijabla
x=symbols("x", real=true);

# ╔═╡ 2ab1a092-323d-11eb-18f9-a360e9c13c31
# Funkcija
f(x)=sin(x)

# ╔═╡ 78797d12-91ff-11eb-3630-e1cbf90810e6
# Definicija derivacije f'
Base.adjoint(f::Function)=diff(f(x),x)

# ╔═╡ 607227e2-323d-11eb-3a5f-2d5d34130b84
begin
	# Lijevi i desni rub intervala i širina za crtanje
	a=-1.0
	b=10.0
	dx=5.0
end

# ╔═╡ e07f69c0-3814-11eb-180f-351a75f67a3b
# Tangenta
tangenta(f,x₀)= x -> f'(x₀)*(x-x₀)+f(x₀)

# ╔═╡ 8b7bb0e0-3815-11eb-3511-dbbf3e026bc3
# Normala
normala(f,x₀)=x -> (-1.0/f'(x₀))*(x-x₀)+f(x₀)

# ╔═╡ 47854920-3818-11eb-0c5c-3564f8022020
md"
x₀ = $(@bind x₀ Slider(a:0.1:b,show_value=true))
"

# ╔═╡ a0e3d7fe-3814-11eb-2b06-2746249700e1
begin
	y₀=f(x₀)
	plot(f,xlims = (x₀-dx,x₀+dx), ylims = (y₀-dx,y₀+dx), aspect_ratio=1,
		label="Funkcija")
	plot!(tangenta(f,x₀), xlims = (x₀-dx,x₀+dx), ylims = (y₀-dx,y₀+dx),
		label="Tangenta")
	plot!(normala(f,x₀), xlims = (x₀-dx,x₀+dx), ylims = (y₀-dx,y₀+dx),
		label="Normala")
end

# ╔═╡ bca6e1e0-3873-11eb-2bc9-95d05556c02a
md"
__Zadatak.__ Nađimo jednadžbu tangenta na elipsu 

$\frac{x^2}{4}+y^2=1$

u točki $x=1$, $y>0$, i nacrtajmo odgovarajuću sliku.

Vrijedi 

$$\begin{aligned}
y(x)&=\sqrt{1-\frac{x^2}{4}},\cr
y(1)&=-\frac{1}{2\sqrt{3}},\cr
y'(x)&=\frac{1}{2\sqrt{1-\frac{x^2}{4}}}\cdot \frac{-2x}{4},\cr
y'(1)&=-\frac{1}{2\sqrt{3}},
\end{aligned}$$

pa jednadžba tražene tangente glasi

$y=-\frac{1}{2\sqrt{3}}(x-1)+\frac{1}{2\sqrt{3}}.$
"

# ╔═╡ 0cec93f0-3867-11eb-24ca-457b3b98b3fe
begin
	plot(sqrt(1-x^2/4),-3,3,aspect_ratio=1,label="Elipsa")
	plot!((-1/(2*sqrt(3)))*(x-1)+sqrt(3)/2,-3,3,label="Tangenta")
end

# ╔═╡ 0caf8290-3875-11eb-3655-edd38e61e14b
md"
__Zadatak.__ Nađimo jednadžbe tangente i normale na krivulju 
$y=\sqrt[3]{\sin(\ln x)}$ u točki $x=e^{\pi/6}$.

Koristimo konstantu $e$. Za računanje funkcije $\sqrt[3]{x}$ na čitavoj domeni koristimo naredbu `real_root(x,3)`.
"

# ╔═╡ 07bf0e32-3876-11eb-2c36-c7678874f2da
e

# ╔═╡ f4bce000-3875-11eb-189d-5ff380c98ab7
x₁=e^(π/6)

# ╔═╡ b4162a60-3876-11eb-35cf-7b9f19aa5dee
f₁(x)=sin(log(x))^(1//3)

# ╔═╡ e40cf580-3891-11eb-18f5-91f5f4fde6aa
md"
 $f'(x)$ je 

$\frac{\cos{\left(\log{\left(x \right)} \right)}}{3 x \sin^{\frac{2}{3}}{\left(\log{\left(x \right)} \right)}}$
"

# ╔═╡ 0a888a34-9202-11eb-1140-ed3b2e3ee76d
f₁'

# ╔═╡ cd251cf0-3876-11eb-117b-19ac57df203c
begin
	# Crtanje
	plot(f₁,1,3,label="Funkcija")
	plot!(tangenta(f₁,x₁),1,3,label="Tangenta")
	plot!(normala(f₁,x₁),1,3,label="Normala",ylim=(0,2),aspect_ratio=1)
end

# ╔═╡ Cell order:
# ╟─aa073e00-323c-11eb-0297-83e3db12248d
# ╠═cc9d0080-323c-11eb-3a85-c90ff746ef6d
# ╠═4ed0642a-0e3b-4f66-99ed-69c4a80bd39f
# ╠═ebd34e00-3813-11eb-1679-ab5dd54dd0e0
# ╠═2ab1a092-323d-11eb-18f9-a360e9c13c31
# ╠═78797d12-91ff-11eb-3630-e1cbf90810e6
# ╠═607227e2-323d-11eb-3a5f-2d5d34130b84
# ╠═e07f69c0-3814-11eb-180f-351a75f67a3b
# ╠═8b7bb0e0-3815-11eb-3511-dbbf3e026bc3
# ╠═a0e3d7fe-3814-11eb-2b06-2746249700e1
# ╟─47854920-3818-11eb-0c5c-3564f8022020
# ╟─bca6e1e0-3873-11eb-2bc9-95d05556c02a
# ╠═0cec93f0-3867-11eb-24ca-457b3b98b3fe
# ╟─0caf8290-3875-11eb-3655-edd38e61e14b
# ╠═8ad18300-3869-11eb-251b-1faf2f0e4d6e
# ╠═07bf0e32-3876-11eb-2c36-c7678874f2da
# ╠═f4bce000-3875-11eb-189d-5ff380c98ab7
# ╠═b4162a60-3876-11eb-35cf-7b9f19aa5dee
# ╟─e40cf580-3891-11eb-18f5-91f5f4fde6aa
# ╠═0a888a34-9202-11eb-1140-ed3b2e3ee76d
# ╠═cd251cf0-3876-11eb-117b-19ac57df203c

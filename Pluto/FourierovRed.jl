### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 32829acf-f80e-4b42-93da-97dedaea24ac
# Na vašem računalu isključite ovu čeliju ...
begin
	import Pkg
    Pkg.activate(mktempdir())
    Pkg.add([
		Pkg.PackageSpec(name="PlutoUI"),
        Pkg.PackageSpec(name="Plots"),
		Pkg.PackageSpec(name="SymPy"),
		Pkg.PackageSpec(name="QuadGK")
    ])
end

# ╔═╡ 527b68b7-f9d4-427d-bb19-94cafcb3e951
using SymPy, Plots, PlutoUI, QuadGK

# ╔═╡ dd8735d3-d41c-4656-aec4-c85f1f3055c9
plotly()

# ╔═╡ 10db8aa7-257b-4b8c-8139-ea8c358309bc
TableOfContents(title="📚 Sadržaj", aside=true)

# ╔═╡ 4c7c1b5c-c925-497c-947f-11556419289f
md"""
# Fourierov red

## Teorem o konvergenciji 

Neka je $f$ po djelovima glatka periodična funkcija s periodom $T=x_1-x_0$ koja na intervalu $[x_0,x_1]$ zadovoljava __Dirichletove uvjete:__

*  $f$ je po djelovima neprekidna i njezini prekidi su prve vrste,
*  $f$ je ili monotona ili ima konačno strogih ekstrema.

Tada Fourierov red

$$S(x)=\frac{a_0}{2}+\sum_{n=1}^\infty a_n \cos \frac{2 n \pi}{T}x + b_n \sin \frac{2 n \pi}{T}x,$$

gdje je

$$\begin{aligned}a_0&=\frac{2}{T} \int_{x_0}^{x_1} f(x) \, dx, \\
a_n&=\frac{2}{T} \int_{x_0}^{x_1} f(x) \cos \frac{2 n \pi}{T}x \,dx,\\
b_n&=\frac{2}{T} \int_{x_0}^{x_1} f(x) \sin \frac{2 n \pi}{T}x \,dx,
\end{aligned}$$

konvergira u svakoj točki $x\in [x_0,x_1]$ i vrijedi 

$$S(x)=\begin{cases}
     f(x), \textrm{ ako je } f \textrm{ neprekidna u točki } x,\\
     \frac{1}{2} [f(x-0)+f(x+0)], \textrm{ inače.}
     \end{cases}$$
"""

# ╔═╡ f01ffb1c-0448-4ec4-aae7-448103d69137
md"""
# Simboličko računanje 
`SymPy` je paket za simboličko računanje preuzet iz `Python`-a, a `Plots` je jedan od paketa za crtanje.
"""

# ╔═╡ f3a6889c-ca75-4d1e-ad58-60fe349f7f95
md"""
Definirajmo simboličku varijablu $x$ i simboličku cjelobrojnu (integer) varijablu $n$.
"""

# ╔═╡ 5f91a1a3-6bcb-4d94-8ee9-664242a0d4f9
begin
	x=symbols("x",real=true)
	n=symbols("n",integer=true)
end

# ╔═╡ f923b766-dc5f-4ba3-84d9-c4cf2f8bcfdc
md"""
## Definiranje koeficijenata
"""

# ╔═╡ f3bf7cfa-70fd-42bf-8529-fc4abbdbf6cf
md"""
## Zadavanje funkcije i granica intervala

Potrebno je koristiti predefiniranu simboličku varijablu `PI` za razliku od varijabli `pi` ili $\pi$
kojima je definirana `Float64` vrijednost.
"""

# ╔═╡ 16a3e529-5396-403d-999a-3f35efe05372
PI

# ╔═╡ 2aa0173d-a7e8-4c3f-a080-108f2c766cc1
begin
	f(x)=x
	x₀=-PI
	x₁=PI
	T=x₁-x₀
end

# ╔═╡ 08d2984f-f753-44ac-a23f-9e59b54fad51
begin
	a(n)=2*integrate(f(x)*cos(2*PI*n*x/T),(x,x₀,x₁))/T
	b(n)=2*integrate(f(x)*sin(2*PI*n*x/T),(x,x₀,x₁))/T
end

# ╔═╡ 7e10946e-ab57-4f2b-a0fe-1553a1260fc5
a(1)

# ╔═╡ e8ba1f2f-222f-4714-9ecb-34f7431c5b32
[a(n) for n=0:10]

# ╔═╡ 28ec9015-8cab-411c-bee6-8ec99ba63d9f
[b(n) for n=0:10]

# ╔═╡ 63ab0a30-1b0d-4901-a839-ecaed6277209
md"""
## Računanje reda i crtanje sume
"""

# ╔═╡ 64b48ad8-ef62-4421-9b0c-49fd668134c2
begin
	K=10
	S=a(0)/2+sum([a(n)*cos(2*PI*n*x/T)+b(n)*sin(2*PI*n*x/T) for n=1:K])
	g(x)=S(x)
	title="Funkcija i "*string(K)*" članova reda"
	plot(f,x₀,x₁,label="funkcija",legend=:bottomright)
	plot!(g,x₀,x₁,title=title,label="Fourierov red")
end

# ╔═╡ 358940b5-f97d-416a-b95d-35def021600e
S

# ╔═╡ 391259b2-2c71-4048-abad-2f4f616f5c7d
md"""
# Korištenje funkcije `fourier_series()`

Prvo pogledajmo simboličko računanje razvoja u Taylor-ov red.
"""

# ╔═╡ 224245e6-ec6b-4c9a-9728-223b671d7ae2
G₁=series(sin(x),x,0,7)

# ╔═╡ 4c40b1b7-937a-4cc1-bcf4-5b92b23248e0
G₂=series(cos(x),x,0,7)

# ╔═╡ ac79f9fa-eb1f-4607-8bad-cc774fd712e2
G₃=simplify(G₁*G₂)

# ╔═╡ 37886d49-447f-4efc-830b-d26c3320fae8
G₃.removeO()

# ╔═╡ f5889e8e-03f2-42c8-86c2-e80c957fba86
md"""
Sada razvoj u Fourier-ov red
"""

# ╔═╡ 524c30fd-8ac1-48fb-89ec-fb0b21316e93
# Ovo učitava funkcije za Fourierovu analizu i Laplaceovu transformaciju
import_from(sympy)

# ╔═╡ 100127fd-94e7-4294-9171-9ff65358549b
c=fourier_series(x^2,(x,x₀,x₁)).truncate(K)

# ╔═╡ 598864da-8d3e-4225-8d6d-1efe13c96f03
# Numerička vrijednost u točki x=1
Float64(c(1))

# ╔═╡ 668afdd8-fac5-40ad-989c-5f1f445a3feb
md"""
## Računanje aproksimacije i crtanje
"""

# ╔═╡ 8d15e233-08d5-41f1-bd5d-d3104926b070
begin
    # Float64 je poterban radi brzine
	X = range(Float64(x₀),Float64(x₁),length=100)
	cs=[c(x) for x in X]
	plot(x->x^2,x₀,x₁,label="funkcija",legend=:bottomright)
	plot!(X,cs,title=title,label="Fourierov red")
end

# ╔═╡ d13171b2-7606-409d-97db-3b6dbe28dc20
begin
	K₁=20
	c₁=fourier_series(x,(x,x₀,x₁)).truncate(K₁)
	cs₁=[c₁(x) for x in X]
	title₁="Funkcija i "*string(K₁)*" članova reda"
	plot(x->x,x₀,x₁,label="funkcija",legend=:bottomright)
	plot!(X,cs₁,title=title₁,label="Fourierov red")
end

# ╔═╡ 97bd2f95-7b50-48e2-ace1-f91c998d91d0
md"""
# Numerička integracija
Fourierove koeficijente čemo izračunati _numeričkom integracijom_ (vidi [Numeričko integriranje](http://www.fesb.hr/mat2/)) koristeći Julia naredbu [quadgk](http://docs.julialang.org/en/latest/stdlib/math/?highlight=quadgk#Base.quadgk).

Ovaj dio je izrađen prema bilježnici [lecture-2.ipynb](http://nbviewer.ipython.org/url/math.mit.edu/~stevenj/18.303/lecture-2.ipynb) [Stevena Johnsona](http://math.mit.edu/~stevenj/) izrađenoj za predmet [18.303](http://math.mit.edu/~stevenj/18.303/).

Definirajmo funkcije `sinecoef` i `coscoef` koje numerički računaju koeficijente. Parametar `abstol` je toleranca numeričke integracije: želimo da je greška mala u odnosu na $\sqrt{\int_{x_0}^{x_1} |f(x)|^2 dx}$.
"""

# ╔═╡ 92fca3af-ee77-4367-8901-7ab2ed9a5441
#?quadgk

# ╔═╡ e324535b-822b-4149-815e-c6074352da70
begin
	sinecoef(f, m, x0, x1) = 2 * quadgk(x -> f(x) * sin(2*m*π*x/(x1-x0))/(x1-x0), x0,x1)[1]
	coscoef(f, m, x0, x1) = 2 * quadgk(x -> f(x) * cos(2*m*π*x/(x1-x0))/(x1-x0), x0,x1)[1]
	# i druga funkcija koja računa na vektoru prirodnih brojeva
	sinecoef(f, M::AbstractVector,x0,x1) = [sinecoef(f,m,x0,x1) for m in M]
	coscoef(f, M::AbstractVector,x0,x1) = [coscoef(f,m,x0,x1) for m in M]
end

# ╔═╡ 927b3b56-c7f1-4843-9973-3be826440e1f
# First, define a function to evaluate N terms of the series, given the  
# coefficients a and b
function fouriersum(a, b, x, T)
	f = a[1]/2
	for n = 1:length(b)
	    f += a[n+1]* cos(2*n*π*x/T) + b[n] * sin(2*n*π*x/T)
	end
	return f
end

# ╔═╡ a5aae9b2-8115-11eb-3789-1b9d3dff66b7
fouriersum(a, b, X::AbstractVector, T) = [fouriersum(a, b,x,T) for x in X]

# ╔═╡ d7435370-81cb-11eb-0489-93c34a3d2cb9
function Fourier(f::Function, n::Int, x₀, x₁) where T
	X=range(x₀,x₁,length=1000)
	a=coscoef(f, 0:n, x₀, x₁)
	b=sinecoef(f, 1:n, x₀, x₁)
	plot(f,x₀,x₁,label="funkcija",legend=:bottomright)
	title=("Funkcija i "*string(n)*" članova reda")
	plot!(X,fouriersum(a, b, X, x₁-x₀),title=title,label="Fourierov red")
end

# ╔═╡ 563c1abe-3d92-4e6d-98bd-e2fdbee9ab81
md"""
## Primjeri
"""

# ╔═╡ 50dc52e0-81cc-11eb-22bd-8d0651f27151
Fourier(x->x,15,-π,π)

# ╔═╡ 9fa90640-81cf-11eb-1006-870690f4e937
Fourier(x->x^2,15,-1,1)

# ╔═╡ dfc81fde-81cf-11eb-3972-4994239f7731
Fourier(x->x<0 ? 0 : x,15,-1,1)

# ╔═╡ Cell order:
# ╠═32829acf-f80e-4b42-93da-97dedaea24ac
# ╠═527b68b7-f9d4-427d-bb19-94cafcb3e951
# ╠═dd8735d3-d41c-4656-aec4-c85f1f3055c9
# ╠═10db8aa7-257b-4b8c-8139-ea8c358309bc
# ╟─4c7c1b5c-c925-497c-947f-11556419289f
# ╟─f01ffb1c-0448-4ec4-aae7-448103d69137
# ╟─f3a6889c-ca75-4d1e-ad58-60fe349f7f95
# ╠═5f91a1a3-6bcb-4d94-8ee9-664242a0d4f9
# ╟─f923b766-dc5f-4ba3-84d9-c4cf2f8bcfdc
# ╠═08d2984f-f753-44ac-a23f-9e59b54fad51
# ╟─f3bf7cfa-70fd-42bf-8529-fc4abbdbf6cf
# ╠═16a3e529-5396-403d-999a-3f35efe05372
# ╠═2aa0173d-a7e8-4c3f-a080-108f2c766cc1
# ╠═7e10946e-ab57-4f2b-a0fe-1553a1260fc5
# ╠═e8ba1f2f-222f-4714-9ecb-34f7431c5b32
# ╠═28ec9015-8cab-411c-bee6-8ec99ba63d9f
# ╟─63ab0a30-1b0d-4901-a839-ecaed6277209
# ╠═64b48ad8-ef62-4421-9b0c-49fd668134c2
# ╠═358940b5-f97d-416a-b95d-35def021600e
# ╟─391259b2-2c71-4048-abad-2f4f616f5c7d
# ╠═224245e6-ec6b-4c9a-9728-223b671d7ae2
# ╠═4c40b1b7-937a-4cc1-bcf4-5b92b23248e0
# ╠═ac79f9fa-eb1f-4607-8bad-cc774fd712e2
# ╠═37886d49-447f-4efc-830b-d26c3320fae8
# ╟─f5889e8e-03f2-42c8-86c2-e80c957fba86
# ╠═524c30fd-8ac1-48fb-89ec-fb0b21316e93
# ╠═100127fd-94e7-4294-9171-9ff65358549b
# ╠═598864da-8d3e-4225-8d6d-1efe13c96f03
# ╟─668afdd8-fac5-40ad-989c-5f1f445a3feb
# ╠═8d15e233-08d5-41f1-bd5d-d3104926b070
# ╠═d13171b2-7606-409d-97db-3b6dbe28dc20
# ╟─97bd2f95-7b50-48e2-ace1-f91c998d91d0
# ╠═92fca3af-ee77-4367-8901-7ab2ed9a5441
# ╠═e324535b-822b-4149-815e-c6074352da70
# ╠═927b3b56-c7f1-4843-9973-3be826440e1f
# ╠═a5aae9b2-8115-11eb-3789-1b9d3dff66b7
# ╠═d7435370-81cb-11eb-0489-93c34a3d2cb9
# ╟─563c1abe-3d92-4e6d-98bd-e2fdbee9ab81
# ╠═50dc52e0-81cc-11eb-22bd-8d0651f27151
# ╠═9fa90640-81cf-11eb-1006-870690f4e937
# ╠═dfc81fde-81cf-11eb-3972-4994239f7731

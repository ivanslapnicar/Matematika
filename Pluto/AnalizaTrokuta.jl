### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ adfa1406-1cf2-11eb-18c9-a58b9f9064c8
begin
	using Plots
	using LinearAlgebra
	plotly()
end

# ╔═╡ be21625e-1cf1-11eb-2efb-0b857e0bbd1e
md"
# Analiza trokuta

Zadan je trokut $\triangle ABC$. Kutove uz vrhove $A$, $B$ i $C$ označavamo s $\alpha$, $\beta$ i $\gamma$, redom.

Za zadani trokut automatski se računaju:

* opseg,
* površina,
* kutovi u stupnjevima,
* težišnice i težište,
* visine i sjecište visina,
* simetrale stranica, središte i radijus opisane kružnice, i
* simetrale kuteva, središte i radijus upisane kružnice,

te nacrtaju pripadne slike.



__Napomena__: Točke definiramo kao `Tuple()`, na primjer `T=(x,y,z)`. Radi računanja vektorskog produkta porebno je `Tuple()` konvertirati u tip `Vector{}` što se radi s naredbom `collect()`.
"

# ╔═╡ b40e846c-1cf2-11eb-0375-cd3f3e221358
# Zadajmo trokut ABC
begin
	A=(1,2,5)
	B=(-2,0,3)
	C=(2,1,-1)
end

# ╔═╡ 9bcc7de0-1d3e-11eb-1f26-49ae5603bd60
begin
	# Definicije za baratanje s točkama
	import Base.+
	+(A::Tuple, B::Tuple)=A.+B
	import Base.-
	-(A::Tuple, B::Tuple)=A.-B
	import Base./
	/(A::Tuple, B::Number)=A./B
	import LinearAlgebra.×
	×(A::Tuple,B::Tuple)=×(collect(A),collect(B))
	×(A::Array,B::Tuple)=×(A,collect(B))
end

# ╔═╡ 1bed9df2-1cf3-11eb-3da5-0ff167b35323
begin
	# Plots.markersizes=2
	mesh3d([A,B,C],legend=false, title="Trokut",color=:lightgray)
	scatter!([A,B,C],ms=2) # ms = markersize
	plot!(xlabel="x",ylabel="y",zlabel="z",aspect_ratio=:equal)
end

# ╔═╡ 52805212-1cf6-11eb-148c-b118898c3bd1
md"
## Opseg trokuta

__Opseg__ je zbroj duljina stranica.
"

# ╔═╡ 5e303fa0-1cf6-11eb-24f7-3b5da0b2957d
function opseg(A,B,C)
	return norm(B-A)+norm(C-A)+norm(C-B)
end

# ╔═╡ 7ce59f58-1cf6-11eb-138d-2fd2931a68ac
O=opseg(A,B,C)

# ╔═╡ 82a6f1a8-1cf6-11eb-0ead-71c9821841fe
md"
## Površina

$P=\frac{1}{2} | \overrightarrow{AB}\times \overrightarrow{AC}|$
"

# ╔═╡ 8c8bedb8-1cf6-11eb-28e0-d93fec161bb0
function površina(A,B,C)
	return norm((B-A)×(C-A))/2
end

# ╔═╡ b6a484e8-1cf6-11eb-2824-619bc952261c
P=površina(A,B,C)

# ╔═╡ 526b20c0-1d25-11eb-3167-934f431a9db8
md"
## Kutovi 

$\alpha=\arccos \frac{\overrightarrow{AB}\cdot\overrightarrow{AC}}{|\overrightarrow{AB}||\overrightarrow{AC}|},\quad
\beta=\arccos \frac{\overrightarrow{BA}\cdot\overrightarrow{BC}}{|\overrightarrow{BA}||\overrightarrow{BC}|},\quad
\gamma=\arccos \frac{\overrightarrow{CA}\cdot\overrightarrow{CB}}{|\overrightarrow{CA}||\overrightarrow{CB}|}$
"

# ╔═╡ 229190e0-1d26-11eb-06ad-f31d46ff5432
function kutovi(A,B,C)
	# Funkcija računa kuteve u stupnjevima
	α=acosd((B-A)⋅(C-A)/(norm(B-A)*norm(C-A)))
	β=acosd((A-B)⋅(C-B)/(norm(A-B)*norm(C-B)))
	γ=acosd((A-C)⋅(B-C)/(norm(A-C)*norm(B-C)))
	return α,β,γ
end

# ╔═╡ 4719fba0-1d26-11eb-2267-b361bf7918e9
α,β,γ=kutovi(A,B,C)

# ╔═╡ 9d83b7b0-1d26-11eb-1210-f5da77878fde
# Provjera
α+β+γ

# ╔═╡ cabb2658-1cf6-11eb-2ffd-2dc8e7df8a46
md"
## Težište

__Težište__ je presjek težišnica, a __težišnica__ je spojnica vrha sa središtem nasuprotne stranice. Središte stranice nasuprot vrhu $A$ označavamo s $A_1$, itd. 

Trebamo definirati strukturu `pravac` kao i funkciju koja računa presjek dvaju pravaca.
"

# ╔═╡ f8887980-1d43-11eb-248e-43e8c5a15c57
struct pravac
	T::Tuple # Točka
    s::Vector # vektor smjera
end

# ╔═╡ 549c4080-1d44-11eb-0ca9-cb31ea57b04c
function presjek(p::pravac,q::pravac)
	t=[p.s -q.s]\collect(q.T-p.T)
	return p.T+t[1].*Tuple(p.s)
end

# ╔═╡ 30cb1f98-1cf7-11eb-08d4-9b12985dacfd
function težište(A,B,C)
	A₁=(B+C)/2
	B₁=(A+C)/2
	C₁=(A+B)/2
	# Definirajmo težišnice iz vrhova A i B
	tA=pravac(A,collect(A₁-A))
	tB=pravac(B,collect(B₁-B))
	# Težište je presjek težišnica
	T=presjek(tA,tB)
	return A₁,B₁,C₁,T
end

# ╔═╡ 8590bc18-1cf7-11eb-302d-155630460d84
A₁,B₁,C₁,T=težište(A,B,C)

# ╔═╡ 996e3846-1cf7-11eb-11dc-dfd833157463
# Nacrtajmo polovišta nasuprotnih stranica i spojnice, te težište
begin
	mesh3d([A,B,C],legend=false, title="Težište",color=:lightgray)
	scatter!([A₁,B₁,C₁],ms=2)
	plot!([A,A₁])
	plot!([B,B₁])
	plot!([C,C₁],aspect_ratio=:equal)
	scatter!(T,color=:black,ms=2)
end

# ╔═╡ 6095a900-1d42-11eb-0f78-c79765cb47dc
md"
## Sjecište visina

__Sjecište visina__ ili __ortocentar__ je sjecište visina, a __visina__ je okomica iz vrha na suprotnu stranicu.
"

# ╔═╡ a56e2c00-1d42-11eb-292c-55752ce03ea6
function ortocentar(A,B,C)
	# Visina iz vrha A
	vA=pravac(A,((C-B)×(A-B))×(C-B))
	# Pravac kroz točke B i C
	pBC=pravac(B,collect(C-B))
	# Točka A₁ u kojoj visina iz vrha A siječe nasuprotnu stranicu
	A₁=presjek(vA,pBC)
	
	# Visina iz vrha B
	vB=pravac(B,((C-A)×(C-B))×(C-A))
	# Pravac kroz točke A i C
	pAC=pravac(A,collect(C-A))
	# Točka B₁ u kojoj visina iz vrha A siječe nasuprotnu stranicu
	B₁=presjek(vB,pAC)
	
	# Visina iz vrha C
	vC=pravac(C,((B-A)×(C-A))×(B-A))
	# Pravac kroz točke A i B
	pAB=pravac(A,collect(B-A))
	# Točka C₁ u kojoj visina iz vrha A siječe nasuprotnu stranicu
	C₁=presjek(vC,pAB)

	# Ortocentar
	O=presjek(vA,vB)
	return A₁,B₁,C₁,O
end

# ╔═╡ 85db7380-1d46-11eb-215a-41b96fe29cee
A₂,B₂,C₂,Oc=ortocentar(A,B,C)

# ╔═╡ 8e7d8590-1d42-11eb-031e-6d3fa68ae707
begin
	mesh3d([A,B,C],legend=false, title="Sjecište visina",color=:lightgray )
	scatter!([A,B,C],ms=2)
	scatter!([A₂,B₂,C₂],ms=2)
	scatter!(Oc,color=:black,ms=2)
	plot!(xlabel="x",ylabel="y",zlabel="z")
	# Provjera sijeku li se visine u istoj točki
	plot!([A,A₂])
	plot!([B,B₂])
	plot!([C,C₂])
	# Provjera ako je ortocentar izvan trokuta
	plot!([A,Oc])
	plot!([B,Oc])
	plot!([C,Oc],aspect_ratio=:equal)
end

# ╔═╡ dd7c1700-1d48-11eb-3cd8-07985f0d50c5
md"
## Opisana kružnica

Središte $S$ __opisane kružnice__ je sjecište __simetrala stranica__, a radijus $r$ je udaljenost od središta do bilo kojeg vrha.

Vektor smjera simetrale stranice se računa pomoću vektorsko-vektorskog produkta.
"

# ╔═╡ 184d7680-1d49-11eb-2505-b95fc1316ea0
function opisana_kružnica(A,B,C)
	# Simetrala stranice BC
	sBC=pravac((B+C)/2,((C-B)×(A-B))×(C-B))
	# Simetrala stranice AC
	sAC=pravac((A+C)/2,((C-A)×(C-B))×(C-A))
	# Simetrala stranice AB
	sAB=pravac((A+B)/2,((B-A)×(C-A))×(B-A))
	# Središte opisane kružnice
	S=presjek(sBC,sAC)
	# Radijus opisane kružnice
	r=norm(S-A)
	return S,r
end

# ╔═╡ dce70d80-1d49-11eb-2287-097c591556b3
S,r=opisana_kružnica(A,B,C)

# ╔═╡ 3066e240-1e09-11eb-3960-cf7fcafd4afb
md"
### Kružnica u prostoru

Točke na kružnici sa središtem u točki $S=(s_x,s_y,s_z)$ radijusa $r$ koja leži u ravnini $\mathcal{R}$ računaju su formulom 

$$
\begin{pmatrix}x \\ y \\z \end{pmatrix}=\begin{pmatrix}s_x \\ s_y \\s_z \end{pmatrix} + (r\cos\phi)  \vec{u}_0 +(r \sin\phi )\vec{v}_0, \quad \phi\in[0,2\pi],$$

gdje su $\vec{u}_0$ i $\vec{v}_0$ međusobno okomiti jedinični vektori paralelni s ravninom $\mathcal{R}$.
"

# ╔═╡ 7cecba42-1e09-11eb-2c71-19ca6bb64aa1
function kružnica(A,B,C,S,r)
	u=collect(B-A)
	v=((B-A)×(C-A))×(B-A)
	u₀=u/norm(u)
	v₀=v/norm(v)
	Φ=range(0,stop=2*pi,length=201)
	return [S+r*cos(ϕ).*Tuple(u₀)+r*sin(ϕ).*Tuple(v₀) for ϕ in Φ]
end

# ╔═╡ ea65cb90-1d49-11eb-2743-0d5882b43328
begin
	mesh3d([A,B,C],legend=false, title="Opisana kružnica",color=:lightgray )
	scatter!([A,B,C],ms=2)
	scatter!(S,color=:black,ms=2)
	scatter!([(A+B)/2,(A+C)/2,(B+C)/2],ms=2)
	plot!(xlabel="x",ylabel="y",zlabel="z")
	# Vizualna provjera sijeku li se simetrale u istoj točki
	plot!([(A+B)/2,S])
	plot!([(A+C)/2,S])
	plot!([(B+C)/2,S])
	# Crtanje kružnice
    Cir=kružnica(A,B,C,S,r)
	plot!(Cir,aspect_ratio=:equal)
end

# ╔═╡ 8ff034e0-1df1-11eb-35b4-9b9e3178bef9
md"
## Upisana kružnica

Središte $S$ __upisane kružnice__ je sjecište __simetrala kutova__, a radijus $r$ je udaljenost od središta do bilo koje stranice.

Vektor smjera simetrale kuta se računa kao zbroj jediničnih vektora priležnih stranica (dijagonala romba raspolavlja kut).  
"

# ╔═╡ af840200-1df1-11eb-2079-6f31dab59923
function upisana_kružnica(A,B,C)
	# Simetrala kuta α
	sα=pravac(A,collect((B-A)/norm(B-A)+(C-A)/norm(C-A)))
	# Simetrala kuta β
	sβ=pravac(B,collect((A-B)/norm(A-B)+(C-B)/norm(C-B)))
	# Simetrala kuta γ
	sγ=pravac(C,collect((C-A)/norm(C-A)+(C-B)/norm(C-B)))

	# Središte upisane kružnice
	S=presjek(sα,sβ)
	# Radijus upisane kružnice
	# Okomica na stranicu AB kroz središte S
	oAB=pravac(S,((B-A)×(C-A))×(B-A))
	# Pravac kroz stranicu AB
	pAB=pravac(A,collect(B-A))
	# Sjecište okomice i stranice AB
	T=presjek(oAB,pAB)
	r=norm(S-T)
	return S,r
end

# ╔═╡ 37382cf0-1dfa-11eb-0ff7-e16314375ea7
Su,ru=upisana_kružnica(A,B,C)

# ╔═╡ bc84dd80-1df1-11eb-30fd-45ff1ebe64d1
begin
	mesh3d([A,B,C],legend=false, title="Upisana kružnica",color=:lightgray )
	scatter!([A,B,C],ms=2)
	scatter!(Su,color=:black,ms=2)
	plot!(xlabel="x",ylabel="y",zlabel="z")
	# Vizualna provjera sijeku li se simetrale u istoj točki
	plot!([A,Su])
	plot!([B,Su])
	plot!([C,Su])
	# Crtanje kružnice
	Cir₁=kružnica(A,B,C,Su,ru)
	plot!(Cir₁,aspect_ratio=:equal)
end

# ╔═╡ Cell order:
# ╟─be21625e-1cf1-11eb-2efb-0b857e0bbd1e
# ╠═b40e846c-1cf2-11eb-0375-cd3f3e221358
# ╠═adfa1406-1cf2-11eb-18c9-a58b9f9064c8
# ╠═9bcc7de0-1d3e-11eb-1f26-49ae5603bd60
# ╠═1bed9df2-1cf3-11eb-3da5-0ff167b35323
# ╟─52805212-1cf6-11eb-148c-b118898c3bd1
# ╠═5e303fa0-1cf6-11eb-24f7-3b5da0b2957d
# ╠═7ce59f58-1cf6-11eb-138d-2fd2931a68ac
# ╟─82a6f1a8-1cf6-11eb-0ead-71c9821841fe
# ╠═8c8bedb8-1cf6-11eb-28e0-d93fec161bb0
# ╠═b6a484e8-1cf6-11eb-2824-619bc952261c
# ╟─526b20c0-1d25-11eb-3167-934f431a9db8
# ╠═229190e0-1d26-11eb-06ad-f31d46ff5432
# ╠═4719fba0-1d26-11eb-2267-b361bf7918e9
# ╠═9d83b7b0-1d26-11eb-1210-f5da77878fde
# ╟─cabb2658-1cf6-11eb-2ffd-2dc8e7df8a46
# ╠═f8887980-1d43-11eb-248e-43e8c5a15c57
# ╠═549c4080-1d44-11eb-0ca9-cb31ea57b04c
# ╠═30cb1f98-1cf7-11eb-08d4-9b12985dacfd
# ╠═8590bc18-1cf7-11eb-302d-155630460d84
# ╠═996e3846-1cf7-11eb-11dc-dfd833157463
# ╟─6095a900-1d42-11eb-0f78-c79765cb47dc
# ╠═a56e2c00-1d42-11eb-292c-55752ce03ea6
# ╠═85db7380-1d46-11eb-215a-41b96fe29cee
# ╠═8e7d8590-1d42-11eb-031e-6d3fa68ae707
# ╟─dd7c1700-1d48-11eb-3cd8-07985f0d50c5
# ╠═184d7680-1d49-11eb-2505-b95fc1316ea0
# ╠═dce70d80-1d49-11eb-2287-097c591556b3
# ╟─3066e240-1e09-11eb-3960-cf7fcafd4afb
# ╠═7cecba42-1e09-11eb-2c71-19ca6bb64aa1
# ╠═ea65cb90-1d49-11eb-2743-0d5882b43328
# ╟─8ff034e0-1df1-11eb-35b4-9b9e3178bef9
# ╠═af840200-1df1-11eb-2079-6f31dab59923
# ╠═37382cf0-1dfa-11eb-0ff7-e16314375ea7
# ╠═bc84dd80-1df1-11eb-30fd-45ff1ebe64d1

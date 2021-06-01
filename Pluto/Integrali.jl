### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 63c21e5b-c943-46de-bac3-8b9d98ad5a58
# Na vašem računalu isključite ovu čeliju ...
begin
	import Pkg
    Pkg.activate(mktempdir())
    Pkg.add("SymPy")
end

# ╔═╡ 5bb6cf00-9b75-4e74-bc75-6a059bc1b32d
# Učita se paket SymPy
using SymPy

# ╔═╡ efc1cf20-8276-11eb-39ba-bd62a4342e68
md"
# Integrali racionalnih funkcija
"

# ╔═╡ d52c1d09-9bee-4359-8e2c-a969a2f32ea3
# Ova naredba daje popis svih djelova paketa, uglavnom su to funkcije. 
# varinfo(SymPy)

# ╔═╡ 8153dabd-5be6-4308-b7c5-1f4ed54722ab
begin
	# Izračunajmo nekoliko integrala.
	x=Sym("x")
	integrate(x^2*sin(x))
end

# ╔═╡ 10b872ad-f070-404c-9ec8-19f0bc2032c5
integrate(exp(-x^2))

# ╔═╡ 056c397f-7303-464e-9ec6-8cf893bbc98c
# Primjer rekurzivne formule. Ovo traje malo duže
integrate(1/(1+x^2)^13)

# ╔═╡ b29b5f68-8978-4b4b-9b29-4840a4097978
# Kraća rekurzivna formula
integrate(1/(1+x^2)^3)

# ╔═╡ 232dcad5-1984-4421-9c1a-001406096217
methods(diff)

# ╔═╡ a2819cd4-d0b3-476a-ab8c-40838db72d54
# Derivacija
diff(x^2*exp(sin(1/x)))

# ╔═╡ 74af42dd-9768-4e91-aa3b-b26c69d6fb68
# Racionalna funkcija trigonometrijskih funkcija (univerzalna trigonometrijska supstitucija)
integrate(1/((2+cos(x))*sin(x)))

# ╔═╡ de024987-9c44-4199-9085-b259980e94a5
md"""
#### Zadatak 1.5.e)
"""

# ╔═╡ 62c5d76c-9eef-40a9-b8c9-446720733f80
integrate(1/(4*sin(x)+3*cos(x)+5))

# ╔═╡ 379bc6e9-7a38-4f3e-8e4a-2ff80917880b
integrate(1/(sin(x)*(2+cos(x)-2*sin(x))))

# ╔═╡ 28dd8649-ed7c-47e5-b7ab-69e99dc0ce86
# Ovo traje beskonačno?
# integrate(cos(x)^3/(sin(x)^2+sin(x)))

# ╔═╡ 12904f05-67c3-4d8a-aefd-e9645e6ef0eb
# Ovo je isti zadatak kao gore, ali traje kratko. Koristi se jednostavnija supstitucija. 
integrate((1-sin(x)^2)*cos(x)/(sin(x)^2+sin(x)))

# ╔═╡ bf1829c9-b2fb-4e3b-b92d-38a93513678b
# Ovo traje jako dugo i ne uspije izračunati nego vrati polazni integral
# integrate( (2*tan(x)+3)/(sin(x)^2+2*cos(x)^2))

# ╔═╡ 3732f5f7-ed44-4254-8b16-d9d860d2c04f
md"""
Uz supstituciju $t=\tan(x)$ integral postaje jednostavan: 
"""

# ╔═╡ 232927bc-ac81-4225-801f-9da5e5842d6d
begin
	t=Sym("t")
	I₁=integrate( (2*t+3)/(t^2+2))
end

# ╔═╡ 13e53f50-8c7d-403c-85c5-848bf2ccbe94
begin
	# Vratimo supstituciju natrag
	I₂=convert(Function,I₁)
	I₂(tan(x))
end

# ╔═╡ d9ada9db-2651-4895-876b-704e4ed05bcb
md"""
#### Zadatak 1.6
"""

# ╔═╡ f2eb749b-51d6-4875-8e14-1e0f688cdfc7
# Ovo traje beskonačno!
# I₄=integrate((1+sinh(x))/((2+cosh(x))*(3+sinh(x))),x)
# Program treba našu pomoć!!!

# ╔═╡ 244208a5-b153-424b-8305-5b6002fd8186
md"""
__Univerzalna hiperbolna supstitucija__

$$\begin{aligned}
t&=\tanh(\frac{x}{2}), \quad x=2\mathop{\mathrm{atanh}}(t),\quad  dx=\displaystyle\frac{2}{1-t^2}dt,\\ 
\sinh(x)&=\displaystyle\frac{2t}{1-t^2}, \quad \cosh(x)=\displaystyle\frac{1+t^2}{1-t^2}.\end{aligned}$$

"""

# ╔═╡ 78acc71b-b314-4799-b633-4ab5b7958496
I₄=(1+sinh(x))/((2+cosh(x))*(3+sinh(x)))

# ╔═╡ 463c1ac7-e503-4507-8aca-d671acf04d36
# supstitucija za sinh(x)
I₅=subs(I₄,sinh(x),(2*t)/(1-t^2))

# ╔═╡ 1b47139d-6c06-4227-91d2-1556d2f3a9d2
# Supstitucija za cosh(x)
I₆=subs(I₅,cosh(x),(1+t^2)/(1-t^2))

# ╔═╡ 646c21be-c589-43b6-b648-3d0dea8353db
# Pomnožimo s dx
I₇=I₆*2/(1-t^2)

# ╔═╡ 34320cf9-d978-46ca-ace2-ea638cc602d7
# Integriramo racionalnu funkciju 
I₈=integrate(I₇,t)

# ╔═╡ 6e0e6146-fefa-4967-938e-1755a0a04607
# Vratimo supstituciju natrag
I₉=subs(I₈,t,tanh(x/2))

# ╔═╡ a817a9d1-f9d2-4fb9-ad16-2477a0a6dea6


# ╔═╡ Cell order:
# ╟─efc1cf20-8276-11eb-39ba-bd62a4342e68
# ╠═63c21e5b-c943-46de-bac3-8b9d98ad5a58
# ╠═5bb6cf00-9b75-4e74-bc75-6a059bc1b32d
# ╠═d52c1d09-9bee-4359-8e2c-a969a2f32ea3
# ╠═8153dabd-5be6-4308-b7c5-1f4ed54722ab
# ╠═10b872ad-f070-404c-9ec8-19f0bc2032c5
# ╠═056c397f-7303-464e-9ec6-8cf893bbc98c
# ╠═b29b5f68-8978-4b4b-9b29-4840a4097978
# ╠═232dcad5-1984-4421-9c1a-001406096217
# ╠═a2819cd4-d0b3-476a-ab8c-40838db72d54
# ╠═74af42dd-9768-4e91-aa3b-b26c69d6fb68
# ╟─de024987-9c44-4199-9085-b259980e94a5
# ╠═62c5d76c-9eef-40a9-b8c9-446720733f80
# ╠═379bc6e9-7a38-4f3e-8e4a-2ff80917880b
# ╠═28dd8649-ed7c-47e5-b7ab-69e99dc0ce86
# ╠═12904f05-67c3-4d8a-aefd-e9645e6ef0eb
# ╠═bf1829c9-b2fb-4e3b-b92d-38a93513678b
# ╟─3732f5f7-ed44-4254-8b16-d9d860d2c04f
# ╠═232927bc-ac81-4225-801f-9da5e5842d6d
# ╠═13e53f50-8c7d-403c-85c5-848bf2ccbe94
# ╟─d9ada9db-2651-4895-876b-704e4ed05bcb
# ╠═f2eb749b-51d6-4875-8e14-1e0f688cdfc7
# ╟─244208a5-b153-424b-8305-5b6002fd8186
# ╠═78acc71b-b314-4799-b633-4ab5b7958496
# ╠═463c1ac7-e503-4507-8aca-d671acf04d36
# ╠═1b47139d-6c06-4227-91d2-1556d2f3a9d2
# ╠═646c21be-c589-43b6-b648-3d0dea8353db
# ╠═34320cf9-d978-46ca-ace2-ea638cc602d7
# ╠═6e0e6146-fefa-4967-938e-1755a0a04607
# ╠═a817a9d1-f9d2-4fb9-ad16-2477a0a6dea6

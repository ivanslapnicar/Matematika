### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ d613968d-7549-401a-9f25-8169660f121f
using SymPy, PlutoUI

# ╔═╡ a5797465-247a-4e33-b733-46ad9a58ad00
TableOfContents(title="📚 Sadržaj", aside=true)

# ╔═╡ 71bf3e90-8277-11eb-188f-0f6601464f27
md"
# Integrali iracionalnih funkcija
"

# ╔═╡ 90465d99-b8e8-4ed3-9943-64aec908d6f7
md"""
## Eulerove i trigonometrijske supstitucije
"""

# ╔═╡ 37981771-05ce-40b5-a2a9-8031d41cdb6b
x=symbols("x",real=true)

# ╔═╡ 1dee94b6-fa66-462e-bbb3-0c941a59dd8e
# Ne može izračunati
integrate(1/(x+√(x^2+6*x+10)),x)

# ╔═╡ cc61e680-8110-11eb-2211-1d212f28c36d
t=symbols("t",real=true)

# ╔═╡ dacfbf80-8110-11eb-2981-4d7c579c8e48
I₀=1/(x+√(x^2+6x+10))

# ╔═╡ 2835b6ea-9c18-4259-82b9-f3eefea58772
I₁=simplify(subs(I₀,x,t-3))

# ╔═╡ 4b0bc7e5-c399-483b-8a4a-c3b4b35fc543
z=symbols("z",real=true)

# ╔═╡ a31fc5bd-cf3b-4248-8994-ce8adb4dd02f
# Eulerova supstitucija
I₂=subs(I₁,√(t^2+1),t+z)

# ╔═╡ 6594a67e-8111-11eb-29a5-eb1fd173be05
I₃=subs(I₂,t,(1-z^2)/(2*z))

# ╔═╡ d7184d11-2e04-434a-bb68-3231aa4a59e2
# Množi s dx
I₄=simplify(I₃*(-1)*(1+z^2)/(2*z^2))

# ╔═╡ f9ec108c-b5dd-46ef-b4ac-b6d97bbc2162
# Integriramo
I₅=integrate(I₄,z)

# ╔═╡ dc3b1f9b-5dde-41f5-9dda-07eb70b460dd
# Vratimo supstitucije
I₆=subs(I₅,z,√(t^2+1)-t)

# ╔═╡ 2bc4c1bf-d574-43f1-8788-3dcecdfd8218
I₇=subs(I₆,t,x+3)

# ╔═╡ 777be0b5-8d94-4347-b61c-d0827a0bf774
# Primjer 1.12
integrate(x^2*sqrt(4*x^2+9))

# ╔═╡ 08e1571e-3f23-456b-9eea-6f228c44980c
md"""
## Binomni integral
"""

# ╔═╡ 098a9b62-9ea4-4547-b6fb-f4fb6d1ee6cf
# Primjer 1.13
I₈=((3*x-x*x*x)^(1//3))

# ╔═╡ 94c8f287-8031-4cd3-a67a-186a5eebf09e
integrate(I₈,x)

# ╔═╡ 0cbc9b1a-7282-4075-a0a2-2b92595bc7c3
md"""
## Integriranje razvoja u red potencija
"""

# ╔═╡ ecf4a097-2e3f-496c-8e65-004e7f0740d1
s₁=series(exp(x),x)

# ╔═╡ 4ddece7e-33ee-4586-b08d-33cd39bb1e30
s₂=series(exp(x),x,0,10)

# ╔═╡ 30f2cb1b-5bb3-4db8-9239-bcde4ec2962f
md"""
Razvoj u red funkcije $f(x)=e^{-x^2}$
"""

# ╔═╡ 4b02de9e-ae81-4324-92e3-20f4b882a8d4
s₃=subs(s₂,x,(-x^2))

# ╔═╡ da968a92-6a56-4dff-97f6-5e87616d4291
s₄=integrate(s₃,x)

# ╔═╡ e8bcf956-422d-4829-9ab6-fda047805a5b
# Uklonimo član O(x^21)
s₆=s₄.removeO()

# ╔═╡ 58468833-ef55-4983-b637-cadd7bcdf9f3
# Izračunajmo vrijednost u točki x=0.1
subs(s₆,x,0.1)

# ╔═╡ 2ac4782d-6c74-4402-b6eb-17554ef27d03
md"""
###  Primjer 1.14 b)
"""

# ╔═╡ 17c63bc5-611b-4cfc-a916-c0018dd71ecb
# Maclaurin-ov red za sin(x)
T₁=series(sin(x),x,0,10)

# ╔═╡ 4375ec68-a2d1-4cf8-a2ab-88bb69717406
# Razvoj u red za sin(x)/x
T₂=simplify(s₁/x)

# ╔═╡ b9b5d733-931d-4f69-8f44-6bde41f7458b
# Ukonimo O() clan
T₃=s₂.removeO()

# ╔═╡ 85a68267-73a0-4c16-ae9f-db1d3ceac7bb
# Integrirajmo
T₄=integrate(s₃,x)

# ╔═╡ 3e684e89-3216-4ed3-a60c-782ab7234fcf


# ╔═╡ Cell order:
# ╠═74ee49bd-d9fe-437d-8098-cf3606b18560
# ╠═d613968d-7549-401a-9f25-8169660f121f
# ╠═a5797465-247a-4e33-b733-46ad9a58ad00
# ╟─71bf3e90-8277-11eb-188f-0f6601464f27
# ╟─90465d99-b8e8-4ed3-9943-64aec908d6f7
# ╠═37981771-05ce-40b5-a2a9-8031d41cdb6b
# ╠═1dee94b6-fa66-462e-bbb3-0c941a59dd8e
# ╠═cc61e680-8110-11eb-2211-1d212f28c36d
# ╠═dacfbf80-8110-11eb-2981-4d7c579c8e48
# ╠═2835b6ea-9c18-4259-82b9-f3eefea58772
# ╠═4b0bc7e5-c399-483b-8a4a-c3b4b35fc543
# ╠═a31fc5bd-cf3b-4248-8994-ce8adb4dd02f
# ╠═6594a67e-8111-11eb-29a5-eb1fd173be05
# ╠═d7184d11-2e04-434a-bb68-3231aa4a59e2
# ╠═f9ec108c-b5dd-46ef-b4ac-b6d97bbc2162
# ╠═dc3b1f9b-5dde-41f5-9dda-07eb70b460dd
# ╠═2bc4c1bf-d574-43f1-8788-3dcecdfd8218
# ╠═777be0b5-8d94-4347-b61c-d0827a0bf774
# ╟─08e1571e-3f23-456b-9eea-6f228c44980c
# ╠═098a9b62-9ea4-4547-b6fb-f4fb6d1ee6cf
# ╠═94c8f287-8031-4cd3-a67a-186a5eebf09e
# ╟─0cbc9b1a-7282-4075-a0a2-2b92595bc7c3
# ╠═ecf4a097-2e3f-496c-8e65-004e7f0740d1
# ╠═4ddece7e-33ee-4586-b08d-33cd39bb1e30
# ╟─30f2cb1b-5bb3-4db8-9239-bcde4ec2962f
# ╠═4b02de9e-ae81-4324-92e3-20f4b882a8d4
# ╠═da968a92-6a56-4dff-97f6-5e87616d4291
# ╠═e8bcf956-422d-4829-9ab6-fda047805a5b
# ╠═58468833-ef55-4983-b637-cadd7bcdf9f3
# ╟─2ac4782d-6c74-4402-b6eb-17554ef27d03
# ╠═17c63bc5-611b-4cfc-a916-c0018dd71ecb
# ╠═4375ec68-a2d1-4cf8-a2ab-88bb69717406
# ╠═b9b5d733-931d-4f69-8f44-6bde41f7458b
# ╠═85a68267-73a0-4c16-ae9f-db1d3ceac7bb
# ╠═3e684e89-3216-4ed3-a60c-782ab7234fcf

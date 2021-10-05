### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

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


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
SymPy = "~1.0.52"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "a325370b9dd0e6bf5656a6f1a7ae80755f8ccc46"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.7.2"

[[CommonEq]]
git-tree-sha1 = "d1beba82ceee6dc0fce8cb6b80bf600bbde66381"
uuid = "3709ef60-1bee-4518-9f2f-acd86f176c50"
version = "0.2.0"

[[CommonSolve]]
git-tree-sha1 = "68a0743f578349ada8bc911a5cbd5a2ef6ed6d1f"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "31d0151f5716b655421d9d75b7fa74cc4e744df2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.39.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Conda]]
deps = ["JSON", "VersionParsing"]
git-tree-sha1 = "299304989a5e6473d985212c28928899c74e9421"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.5.2"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IrrationalConstants]]
git-tree-sha1 = "f76424439413893a832026ca355fe273e93bce94"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "34dc30f868e368f8a17b728a1238f3fcda43931a"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.3"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "5a5bc6bf062f0f95e62d0fe0a2d99699fed82dd9"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.8"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "a8709b968a1ea6abc2dc1967cb1db6ac9a00dfb6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.5"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "169bb8ea6b1b143c5cf57df6d34d022a7b60c6db"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.92.3"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RecipesBase]]
git-tree-sha1 = "44a75aa7a527910ee3d1751d1f0e4148698add9e"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "793793f1df98e3d7d554b65a107e9c9a6399a6ed"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.7.0"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[SymPy]]
deps = ["CommonEq", "CommonSolve", "LinearAlgebra", "Markdown", "PyCall", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "1ef257ecbcab8058595a68ca36a6844b41babcbd"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "1.0.52"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[VersionParsing]]
git-tree-sha1 = "80229be1f670524750d905f8fc8148e5a8c4537f"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.2.0"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─efc1cf20-8276-11eb-39ba-bd62a4342e68
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
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

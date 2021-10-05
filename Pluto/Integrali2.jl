### A Pluto.jl notebook ###
# v0.16.0

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


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
PlutoUI = "~0.7.14"
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

[[HypertextLiteral]]
git-tree-sha1 = "72053798e1be56026b81d4e2682dbe58922e5ec9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.0"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

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

[[PlutoUI]]
deps = ["Base64", "Dates", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "d1fb76655a95bf6ea4348d7197b22e889a4375f4"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.14"

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

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

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
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

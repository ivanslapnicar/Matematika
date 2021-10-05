### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 0bdd0fc6-9203-11eb-1ea3-9fe58aca7da0
using SymPy, LinearAlgebra

# ╔═╡ aa073e00-323c-11eb-0297-83e3db12248d
md"
# Gradijent, divergencija i rotacija

__Nabla__ ili __Hamiltonov operator__  je

$$\nabla = \frac{\partial}{\partial x} \vec{\imath}+\frac{\partial}{\partial y} \vec{\jmath} +\frac{\partial}{\partial z} \vec{k}.$$

Nabla ima svojstva derivacije i vektora.

__Gradijent__ skalarnog polja $f(x,y,z)$ je

$\mathop{\mathrm{grad}} f = \nabla \cdot f=\frac{\partial f}{\partial x} \vec{\imath}+\frac{\partial f}{\partial y} \vec{\jmath} +\frac{\partial f}{\partial z} \vec{k}.$

__Divergencija__ vektorskog polja

$\vec{w}(x,y,z)=w_x(x,y,z)\vec{\imath} + w_y(x,y,z) \vec{\jmath} + w_z(x,y,z)\vec{k}$

je

$\mathop{\mathrm{div}} \vec{w} = \nabla \cdot \vec{w}= \frac{\partial w_x}{\partial x} +\frac{\partial w_y}{\partial y} +\frac{\partial w_z}{\partial z}.$

__Rotacija__ vektorskog polja $\vec{w}(x,y,z)$ je

$\mathop{\mathrm{rot}} \vec{w} = \nabla \times \vec{w}= \begin{vmatrix} \vec{\imath} & \vec{\jmath} & \vec{k} \\ \frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z} \\ w_x & w_y &w_z \end{vmatrix}.$

__Usmjerena derivacija__ skalarnog polja $f(x,y,z)$ u smjeru vektora $\vec a$ je

$$\frac{\partial f}{\partial \vec a}(x,y,z)=\vec a_0 \cdot \mathop{\mathrm{grad}} f(x,y,z).$$

__Usmjerena derivacija__ vektorskog polja $\vec w(x,y,z)$ u smjeru vektora $\vec a$ je

$$\frac{\partial \vec w}{\partial \vec a}(x,y,z)=(\vec a_0 ∇) \vec w(x,y,z).$$
"

# ╔═╡ c75d36c0-923c-11eb-0477-c3101e21f880
x,y,z=symbols(:x),symbols(:y),symbols(:z)

# ╔═╡ 1b261092-923a-11eb-01d6-7f705b30d46e
begin
	∂x(f::Sym) = diff(f,x)
	∂y(f::Sym) = diff(f,y)
	∂z(f::Sym) = diff(f,z)
	∇=[∂x,∂y,∂z]
end

# ╔═╡ 1ca28980-925d-11eb-2be1-815a5df595ff
begin
	import Base.*
	*(∂x::typeof(∂x),f::Sym)=∂x(f)
	*(∂y::typeof(∂y),f::Sym)=∂y(f)
	*(∂z::typeof(∂z),f::Sym)=∂z(f)
	*(∇::Function,f::Sym)=∇(f)
	grad(f)=∇*f
	rot(u)=∇×u
	import LinearAlgebra.⋅
	⋅(∇::Array{Function,1},w::Array{Sym,1})=∇[1]*w[1]+∇[2]*w[2]+∇[3]*w[3]
	div(u)=∇⋅u
	⋅(a::Vector,∇::Array{Function,1})=a[1]*∇[1]+a[2]*∇[2]+a[3]*∇[3]
end

# ╔═╡ c2a476e6-e948-485f-9b2e-b6f821504263
# Izvedeni operator a∇
begin
	a∂x(a::Vector,f::Sym) = a[1]*diff(f,x)
	a∂y(a::Vector,f::Sym) = a[2]*diff(f,y)
	a∂z(a::Vector,f::Sym) = a[3]*diff(f,z)
	a∇(a::Vector,f::Sym)=a∂x(a,f)+a∂y(a,f)+a∂z(a,f)
	a∇(a::Vector,w::Array{Sym,1})=[a∇(a,w[1]),a∇(a,w[2]),a∇(a,w[3])]
end

# ╔═╡ bd70ec2e-ad07-4526-aa70-5f25c86b444e
md"
## Primjeri
"

# ╔═╡ fd3305b2-923a-11eb-15c4-5b79db40bf46
begin
	# Skalarna polja
	f=x^2+3*y*z+5
	g=x*y*z
	# Vektorska polja
	w=[y*z,z*x,x*y]
	u=[x^2*y,x*y,z/x]
	# Vektor
	a=[1,1,-2]
	# Točka
	T=(1,-1/2,2)
end

# ╔═╡ 2b00c286-0807-4fa0-a9c2-6b1d56ae3716
f

# ╔═╡ 66b9df0a-06c4-409c-9ae4-79b3cc3833b5
∂x(f)

# ╔═╡ 9b816a31-675a-4dea-83e7-67430eeb741e
∂x*f

# ╔═╡ ec770eca-54d2-4394-b359-ad5e47218e92
a∇(a,f)

# ╔═╡ 3577e5e0-8fa8-4938-9119-b7c14f31e5be
a∇(a,u)

# ╔═╡ 2a47ed85-0691-4cb2-84b5-52facb4eda0b
# Gradijent
∇*f

# ╔═╡ 26292a50-9627-40a3-bacc-034de0882ac2
grad(f)

# ╔═╡ 8d4a98d1-414e-4714-9c94-6b6426388bc0
# Gradijent u zadanoj točki
subs.(∇*f,x=>T[1],y=>T[2],z=>T[3])

# ╔═╡ c62f2abe-b330-4e5b-8a73-c2ac5fe32284
# Divergencija
∇⋅u

# ╔═╡ f141e418-574d-4a0f-903c-35ad8d3e6883
div(u)

# ╔═╡ 0e012c70-afc3-410f-a73c-978783948cc3
# Divergencija u zadanoj točki
subs(∇⋅u,x=>T[1],y=>T[2],z=>T[2])

# ╔═╡ faea848e-f4d7-4476-993f-d9db5c6ca2ee
# Rotor
∇×u

# ╔═╡ e3c9e5d1-8542-4940-8dd2-c60849b152c3
rot(u)

# ╔═╡ 0496ef19-9e5c-4f5b-aa4b-22d98cfcf9a0
# Rotor u zadanoj točki
subs.(∇×u,x=>T[1],y=>T[2],z=>T[3])

# ╔═╡ ad3b7955-cd19-4aaf-8a98-b4727bafe572
# Primjer svojstva
rot(f*grad(g))

# ╔═╡ 93446240-2427-4964-9e3a-75f2de6b67e6
grad(f)×grad(g)

# ╔═╡ 44c1a521-657b-43c4-ac59-7a8e24bf25cc
# Drugi primjer svojstva
rot(w×u)

# ╔═╡ 54692583-1661-4b04-8f2c-94689630cff8
expand.(w*div(u)-u*div(w)+a∇(u,w)-a∇(w,u))

# ╔═╡ fadb40e2-6c5e-48b2-a45f-88ea4f8cc4e5
# Usmjerena derivacija skalarnog polja
a/norm(a)⋅grad(f)

# ╔═╡ 180512f7-c8e8-4aee-9872-0057d6fe9c5d
# Usmjerena derivacija skalarnog polja u točki
subs(a/norm(a)⋅grad(f),x=>T[1],y=>T[2],z=>T[3])

# ╔═╡ 258fbdc7-7c24-4ecf-bc5a-468069f5c482
# Skalarno polje najbrže raste u smjeru gradijenta
subs(grad(f)/norm(grad(f))⋅grad(f),x=>T[1],y=>T[2],z=>T[3])

# ╔═╡ eeb8e757-668e-48c1-b560-076b3f47b5bf
# Usmjerena derivacija vektorskog polja
a∇(a/norm(a),u)

# ╔═╡ 694962cc-cca2-4a4d-939d-7eb329de9917
# Usmjerena derivacija vektorskog polja u točki
subs.(a∇(a/norm(a),u),x=>T[1],y=>T[2],z=>T[3])

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
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
# ╟─aa073e00-323c-11eb-0297-83e3db12248d
# ╠═0bdd0fc6-9203-11eb-1ea3-9fe58aca7da0
# ╠═c75d36c0-923c-11eb-0477-c3101e21f880
# ╠═1b261092-923a-11eb-01d6-7f705b30d46e
# ╠═1ca28980-925d-11eb-2be1-815a5df595ff
# ╠═c2a476e6-e948-485f-9b2e-b6f821504263
# ╟─bd70ec2e-ad07-4526-aa70-5f25c86b444e
# ╠═fd3305b2-923a-11eb-15c4-5b79db40bf46
# ╠═2b00c286-0807-4fa0-a9c2-6b1d56ae3716
# ╠═66b9df0a-06c4-409c-9ae4-79b3cc3833b5
# ╠═9b816a31-675a-4dea-83e7-67430eeb741e
# ╠═ec770eca-54d2-4394-b359-ad5e47218e92
# ╠═3577e5e0-8fa8-4938-9119-b7c14f31e5be
# ╠═2a47ed85-0691-4cb2-84b5-52facb4eda0b
# ╠═26292a50-9627-40a3-bacc-034de0882ac2
# ╠═8d4a98d1-414e-4714-9c94-6b6426388bc0
# ╠═c62f2abe-b330-4e5b-8a73-c2ac5fe32284
# ╠═f141e418-574d-4a0f-903c-35ad8d3e6883
# ╠═0e012c70-afc3-410f-a73c-978783948cc3
# ╠═faea848e-f4d7-4476-993f-d9db5c6ca2ee
# ╠═e3c9e5d1-8542-4940-8dd2-c60849b152c3
# ╠═0496ef19-9e5c-4f5b-aa4b-22d98cfcf9a0
# ╠═ad3b7955-cd19-4aaf-8a98-b4727bafe572
# ╠═93446240-2427-4964-9e3a-75f2de6b67e6
# ╠═44c1a521-657b-43c4-ac59-7a8e24bf25cc
# ╠═54692583-1661-4b04-8f2c-94689630cff8
# ╠═fadb40e2-6c5e-48b2-a45f-88ea4f8cc4e5
# ╠═180512f7-c8e8-4aee-9872-0057d6fe9c5d
# ╠═258fbdc7-7c24-4ecf-bc5a-468069f5c482
# ╠═eeb8e757-668e-48c1-b560-076b3f47b5bf
# ╠═694962cc-cca2-4a4d-939d-7eb329de9917
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

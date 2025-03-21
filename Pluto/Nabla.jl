### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 0bdd0fc6-9203-11eb-1ea3-9fe58aca7da0
using PythonCall, SymPyPythonCall, LinearAlgebra

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
x,y,z=symbols("x"),symbols("y"),symbols("z")

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
	⋅(∇::Vector{Function},w::Array{Sym{PythonCall.Core.Py}, 1})=∇[1]*w[1]+∇[2]*w[2]+∇[3]*w[3]
	div(u)=∇⋅u
	⋅(a::Vector,∇::Array{Function,1})=a[1]*∇[1]+a[2]*∇[2]+a[3]*∇[3]
end

# ╔═╡ 56b1c1df-a2af-43a7-8d04-0ded0940ca6e
typeof(∇)

# ╔═╡ c2a476e6-e948-485f-9b2e-b6f821504263
# Izvedeni operator a∇
begin
	a∂x(a::Vector,f::Sym) = a[1]*diff(f,x)
	a∂y(a::Vector,f::Sym) = a[2]*diff(f,y)
	a∂z(a::Vector,f::Sym) = a[3]*diff(f,z)
	a∇(a::Vector,f::Sym)=a∂x(a,f)+a∂y(a,f)+a∂z(a,f)
	a∇(a::Vector,w::Array{Sym{PythonCall.Core.Py}, 1})=[a∇(a,w[1]),a∇(a,w[2]),a∇(a,w[3])]
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

# ╔═╡ 9ea53523-ad8d-436b-9ae6-2e85273c2af2
div(u)

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
subs(∇⋅u,x=>T[1],y=>T[2],z=>T[3])

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
PythonCall = "6099a3de-0909-46bc-b1f4-468b9a2dfc0d"
SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"

[compat]
PythonCall = "~0.9.19"
SymPyPythonCall = "~0.2.5"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.4"
manifest_format = "2.0"
project_hash = "12ec7dcc2e2e644163d9e74524facee463893a7e"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CommonEq]]
git-tree-sha1 = "6b0f0354b8eb954cdba708fb262ef00ee7274468"
uuid = "3709ef60-1bee-4518-9f2f-acd86f176c50"
version = "0.2.1"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.CondaPkg]]
deps = ["JSON3", "Markdown", "MicroMamba", "Pidfile", "Pkg", "Preferences", "TOML"]
git-tree-sha1 = "e81c4263c7ef4eca4d645ef612814d72e9255b41"
uuid = "992eb4ea-22a4-4c89-a5bb-47a3300528ab"
version = "0.2.22"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "a007feb38b422fbdab534406aeca1b86823cb4d6"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.0"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "PrecompileTools", "StructTypes", "UUIDs"]
git-tree-sha1 = "1d322381ef7b087548321d3f878cb4c9bd8f8f9b"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.14.1"

    [deps.JSON3.extensions]
    JSON3ArrowExt = ["ArrowTypes"]

    [deps.JSON3.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MacroTools]]
git-tree-sha1 = "72aebe0b5051e5143a079a4685a46da330a40472"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.15"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.MicroMamba]]
deps = ["Pkg", "Scratch", "micromamba_jll"]
git-tree-sha1 = "011cab361eae7bcd7d278f0a7a00ff9c69000c51"
uuid = "0b3b1443-0f03-428d-bdfb-f27f9c1191ea"
version = "0.1.14"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+4"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pidfile]]
deps = ["FileWatching", "Test"]
git-tree-sha1 = "2d8aaf8ee10df53d0dfb9b8ee44ae7c04ced2b03"
uuid = "fa939f87-e72e-5be4-a000-7fc836dbe307"
version = "1.3.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PythonCall]]
deps = ["CondaPkg", "Dates", "Libdl", "MacroTools", "Markdown", "Pkg", "REPL", "Requires", "Serialization", "Tables", "UnsafePointers"]
git-tree-sha1 = "0fe6664f742903eab8929586af78e10a51b33577"
uuid = "6099a3de-0909-46bc-b1f4-468b9a2dfc0d"
version = "0.9.19"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "159331b30e94d7b11379037feeb9b690950cace8"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.11.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SymPyCore]]
deps = ["CommonEq", "CommonSolve", "Latexify", "LinearAlgebra", "Markdown", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "4c5a53625f0e53ce1e726a6dab1c870017303728"
uuid = "458b697b-88f0-4a86-b56b-78b75cfb3531"
version = "0.1.16"

    [deps.SymPyCore.extensions]
    SymPyCoreSymbolicUtilsExt = "SymbolicUtils"

    [deps.SymPyCore.weakdeps]
    SymbolicUtils = "d1185830-fcd6-423d-90d6-eec64667417b"

[[deps.SymPyPythonCall]]
deps = ["CommonEq", "CommonSolve", "CondaPkg", "LinearAlgebra", "PythonCall", "SpecialFunctions", "SymPyCore"]
git-tree-sha1 = "1948385c5c0f0659ca3abcdea214318d691b1770"
uuid = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"
version = "0.2.5"

    [deps.SymPyPythonCall.extensions]
    SymPyPythonCallSymbolicsExt = "Symbolics"

    [deps.SymPyPythonCall.weakdeps]
    Symbolics = "0c5d862f-8b57-4792-8d23-62f2024744c7"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnsafePointers]]
git-tree-sha1 = "c81331b3b2e60a982be57c046ec91f599ede674a"
uuid = "e17b2a0c-0bdf-430a-bd0c-3a23cae4ff39"
version = "1.0.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.micromamba_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "66d07957bcf7e4930d933195aed484078dd8cbb5"
uuid = "f8abcde7-e9b7-5caa-b8af-a437887ae8e4"
version = "1.4.9+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─aa073e00-323c-11eb-0297-83e3db12248d
# ╠═0bdd0fc6-9203-11eb-1ea3-9fe58aca7da0
# ╠═c75d36c0-923c-11eb-0477-c3101e21f880
# ╠═1b261092-923a-11eb-01d6-7f705b30d46e
# ╠═1ca28980-925d-11eb-2be1-815a5df595ff
# ╠═56b1c1df-a2af-43a7-8d04-0ded0940ca6e
# ╠═9ea53523-ad8d-436b-9ae6-2e85273c2af2
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

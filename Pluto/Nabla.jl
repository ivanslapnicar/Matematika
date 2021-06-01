### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ a3b7752b-4157-4a62-93cb-0920bd3b0059
# Na vašem računalu isključite ovu čeliju ...
begin
	import Pkg
    Pkg.activate(mktempdir())
    Pkg.add("SymPy")
end

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

# ╔═╡ Cell order:
# ╠═a3b7752b-4157-4a62-93cb-0920bd3b0059
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

### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ 14900210-d014-4485-9e6a-2bb97cafefd1
begin
	using PortAudio, SampledSignals
	import LibSndFile
	using FileIO: load, save, loadstreaming, savestreaming, query
	# using QuadGK
end

# ╔═╡ 123494fb-da41-40b3-a6da-d2dd3956bbcf
# Pogledajmo signal
using Plots

# ╔═╡ 4cda92ed-f045-4347-8a01-7d8326beeb24
md"""
# Fourierov integral

Primjer snimanja signala, numeričkog računanja Fourierovog integrala, i rekonstrukcije 
signala nakon rezanja frekvencija.
"""

# ╔═╡ 36e78570-81d2-11eb-2124-0189bee238eb
# pkg> add https://github.com/JuliaAudio/PortAudio.jl.git

# ╔═╡ 5807a089-0963-47bf-b31c-9f6cb673a29a
PortAudio.devices()

# ╔═╡ 83d73bd5-adc6-4e05-8490-41cbe52d285d
md"""
Nakon što ste pronašli vaše uređaje, možete otkomentirati sljedeću 
ćeliju u kojoj se ulaz s mikrofona direktno prenosi na zvučnik. 
Nakon toga treba ponovo pokrenuti jezgru. 
"""

# ╔═╡ 71da3573-43e1-4ddf-baaa-f00c6635506d
#=
stream = PortAudioStream(2, 2)
try
    # cancel with Ctrl-C
    write(stream, stream)
finally
    close(stream)
end
=#

# ╔═╡ 949fb68b-bde5-4f8e-8303-d941b00bd8c0
md"""
Ukoliko želite snimiti svoj tekst, zamijenite mikrofon i izlaz s vašim uređajima, i izvedite sljedeće četiri čelije.
"""

# ╔═╡ a5c7fcc5-5c53-471b-a5ee-482c6e81c17b
# stream = PortAudioStream("Microphone (BRIO 4K Stream Edit","Microsoft Sound Mapper - Output")

# ╔═╡ 16383cd6-bfd9-4b7c-9ada-90f0a06e2b00
# Namjestite duljinu snimke (nemojte pretjerivati)
# buf = read(stream, 3s)

# ╔═╡ da37b3c9-45eb-4731-b05d-dcb49a669fb7
# Zatvorite stream
# close(stream)

# ╔═╡ 33589e1a-6034-4039-b3e6-b7baca5373da
# Spremite vašu snimku
# save("myvoice.ogg", buf)

# ╔═╡ 00909270-823e-11eb-209e-516ff567c9d2
glas=load("myvoice.ogg")

# ╔═╡ 38c5b377-2c9e-4f2c-a4b1-e172e474da7d
length(glas)

# ╔═╡ 7ff572d4-1248-431c-a3f8-a4cdf3feeab2
glas.samplerate

# ╔═╡ 37431d3c-80b0-41e5-b181-b4e2121ea2f2
typeof(glas)

# ╔═╡ 75f49ac0-823e-11eb-38a5-5b86cc07e9ad
glas.data

# ╔═╡ d728dfd5-c51c-4008-8a0c-33a1ff7622c5
# Napravimo mono snimku
glas_mono=similar(glas);

# ╔═╡ cc609b6c-5f95-4c52-939b-46f1ea142641
begin
	glas_mono.data=sum(glas.data,dims=2)
	glas_mono.samplerate=glas.samplerate
end

# ╔═╡ 457e98b3-a7c6-4aa1-916c-dbdf9e587ec8
save("myvoice_mono.ogg", glas_mono)

# ╔═╡ cf1fdcf6-acfd-494f-a545-c5935700b4b6
glas_mono.data

# ╔═╡ 12b84c10-8273-11eb-3f9b-0db8fcf7fd75
glas_mono

# ╔═╡ e3660516-58d8-4cd2-99c2-e999d6dd7dc7
begin
	S=glas_mono.data
	plot(S,label="Originalni signal")
end

# ╔═╡ 01ebedfb-66c3-4fc0-b967-69a67af812ad
# Vrijeme
T=range(0,3,length=length(S))

# ╔═╡ ccff6cf5-d60f-4294-8396-b894c1b0e673
begin
	# Trapezna formula, približno. Računamo kosinusni i sinusni spektar
	using LinearAlgebra
	A(λ::Float64)=(cos.(λ*T)⋅S)*((T[end]-T[1])/(length(T)*π))
	B(λ::Float64)=(sin.(λ*T)⋅S)*((T[end]-T[1])/(length(T)*π))
end

# ╔═╡ d588d827-a9c1-45ff-972a-30580055b38c
# Plot u vremenu
plot(T,S,xlabel="t (sec)",label="Originalni signal")

# ╔═╡ 2eff8044-d700-4a5f-9d46-9009a9e280eb
# Nacrtajmo kosinusni i sinusni spektar i odlučimo koje frekvencije ćemo zadržati
plot([A B],300,5000,layout=(2,1),label=["Kosinusni spektar" "Sinusni spektar"])

# ╔═╡ d636f56b-ffad-4ff8-8590-c6d0772438cf
begin
	# Ograničimo spektar, opet koristimo približnu formulu
	λ₀=600.0
	λ₁=4500.0
	step=0.5
	Λ=range(λ₀,λ₁,step=step)
	# Ovo traje cca 1 minutu, ali se računa samo jednom
	Aλ=A.(Λ)
	Bλ=B.(Λ)
end

# ╔═╡ dec5475f-8064-42fe-934f-b7519920b508
# Rekonstruirajmo signal s odrezanim frekvencijama
g(x::Float64)=(Aλ⋅cos.(x*Λ)+Bλ⋅sin.(x*Λ))*step

# ╔═╡ 45fb4bd1-eccf-4307-aec2-0b52353dc0db
G=g.(T)

# ╔═╡ ef9657d8-4290-4d73-bc95-f1fba9c91000
# Usporedimo grafički
plot(T,[S G],layout=(2,1),label=["Originalni mono signal" "Odrezani mono signal"])

# ╔═╡ f3f5f234-bb67-4cfe-822d-6148593c6554
begin
	# Spremimo signal s odrezanim frekvencijama i poslušajmo
	glas_mono_odrezan=deepcopy(glas_mono)
	glas_mono_odrezan.data[:,1]=map(Float32,G)
	save("myvoice_odrezan.ogg", glas_mono_odrezan)
end

# ╔═╡ 9d4dc1ae-ab06-48e1-92df-b0973f8552bd
glas_mono_odrezan

# ╔═╡ e7a96973-2dda-49f5-a4c9-014fafc6e44c


# ╔═╡ Cell order:
# ╟─4cda92ed-f045-4347-8a01-7d8326beeb24
# ╠═14900210-d014-4485-9e6a-2bb97cafefd1
# ╠═36e78570-81d2-11eb-2124-0189bee238eb
# ╠═5807a089-0963-47bf-b31c-9f6cb673a29a
# ╟─83d73bd5-adc6-4e05-8490-41cbe52d285d
# ╠═71da3573-43e1-4ddf-baaa-f00c6635506d
# ╟─949fb68b-bde5-4f8e-8303-d941b00bd8c0
# ╠═a5c7fcc5-5c53-471b-a5ee-482c6e81c17b
# ╠═16383cd6-bfd9-4b7c-9ada-90f0a06e2b00
# ╠═da37b3c9-45eb-4731-b05d-dcb49a669fb7
# ╠═33589e1a-6034-4039-b3e6-b7baca5373da
# ╠═00909270-823e-11eb-209e-516ff567c9d2
# ╠═38c5b377-2c9e-4f2c-a4b1-e172e474da7d
# ╠═7ff572d4-1248-431c-a3f8-a4cdf3feeab2
# ╠═37431d3c-80b0-41e5-b181-b4e2121ea2f2
# ╠═75f49ac0-823e-11eb-38a5-5b86cc07e9ad
# ╠═d728dfd5-c51c-4008-8a0c-33a1ff7622c5
# ╠═cc609b6c-5f95-4c52-939b-46f1ea142641
# ╠═457e98b3-a7c6-4aa1-916c-dbdf9e587ec8
# ╠═cf1fdcf6-acfd-494f-a545-c5935700b4b6
# ╠═12b84c10-8273-11eb-3f9b-0db8fcf7fd75
# ╠═123494fb-da41-40b3-a6da-d2dd3956bbcf
# ╠═e3660516-58d8-4cd2-99c2-e999d6dd7dc7
# ╠═01ebedfb-66c3-4fc0-b967-69a67af812ad
# ╠═d588d827-a9c1-45ff-972a-30580055b38c
# ╠═ccff6cf5-d60f-4294-8396-b894c1b0e673
# ╠═2eff8044-d700-4a5f-9d46-9009a9e280eb
# ╠═d636f56b-ffad-4ff8-8590-c6d0772438cf
# ╠═dec5475f-8064-42fe-934f-b7519920b508
# ╠═45fb4bd1-eccf-4307-aec2-0b52353dc0db
# ╠═ef9657d8-4290-4d73-bc95-f1fba9c91000
# ╠═f3f5f234-bb67-4cfe-822d-6148593c6554
# ╠═9d4dc1ae-ab06-48e1-92df-b0973f8552bd
# ╠═e7a96973-2dda-49f5-a4c9-014fafc6e44c

# Matematika

Matematičke reaktivne bilježnice pisane koristeći [Pluto.jl](https://github.com/fonsp/Pluto.jl). Bilježnice su pisane u programskom jeziku [Julia](https://julialang.org).

## Korištenje

* Preuzmite bilježnice (repozitorij) korištenjem `git` naredbe:
```
git clone https://github.com/ivanslapnicar/Matematika.git
```
Ako niste upoznati s `git` alatom možete pogledati GitHubove [stranice za pomoć](https://help.github.com/articles/set-up-git/) ili direktno preuzeti bilježnice (repozitorij) kao zip datoteku.
HTML verzije bilježnica nalaze se u driektoriju `Matematika/docs`

* Instalirajte [Julia-u](https://julialang.org/downloads/). U Julia terminalu izvedite naredbe
```
> using Pkg
> Pkg.add("Pluto")
> Pkg.add("Plots")
```
Prethodne naredbe je potrebno izvršiti samo jednom.
* Server Pluto bilježnica se pokreće pomoću naredbi
```
> using Pluto
> Pluto.run()
```
Sada možete izvoditi bilježnice koje se nalaze u direktoriju `Matematika/Pluto`.

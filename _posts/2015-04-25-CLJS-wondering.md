---
layout: post
title: CLJS Wondering
---

# Comment j'en suis arrivé là (((

Dans les dernières semaines, [@fxg](https://twitter.com/FXGuillemette) et moi nous sommes intéressés 
à lister les manières d'écrire du code asynchrone dans node/le browser.
Nous sommes ressortis de cet exercice avec un dépôt: [Async-comparison](https://github.com/fxg42/async-comparison).

En chemin je suis tombé sur le concept de [CSP](http://fr.wikipedia.org/wiki/Communicating_sequential_processes). 
Les deux implémentations qui font le plus parlé ces temps sont sont celles de 
Go et celle Clojure.

J'ai donc vu pas mal de Clojure en chemin. Comme le sujet n'est pas intarissable,
j'ai fini par regarder un peu autour, en touriste.

Il me semble que l'écosystème Clojure et ClojureScript est très riche, très très riche.
Je ne vais pas me lancer dans un listing exhaustif, 
des ressources le font mieux que moi: 

* [Article wikipedia de Clojure](http://fr.wikipedia.org/wiki/Clojure)
* [Documentation de Clojure](http://clojure.org/documentation)
* [Github de Clojurescript](https://github.com/clojure/clojurescript)

# ))))
J'ai l'impression qu'il y a de belles choses à aller chercher dans
l'écosystème Clojure. Mais je ne suis pas assez sûr d'aimer travailler avec
un Lisp pour passer plus de temps à fouiller l'environnement de Clojure/Clojurescript.

#GET TO THE POINT

J'ai donc fait un petit projet juste pour voir ce que ça donne de 
travailler avec Clojure/Clojurescript.

J'ai donc monté un [2048](http://gabrielecirulli.github.io/2048/) en clojurescript.
Pour la présentation, j'ai utilisé une Reagent.
Reagent c'est une couche sur react qui simplifie/clojurifie les choses.

* Live Demo: [ici](/pages/2048) 
* Souce: [2048@github](https://github.com/benzen/2048)

#Pis à date comment c'est ?

##Le fun

Jouer avec des structures de données immuables c'est très agréable.
Le fait que toute la librairie core soit orientée sur cette idée permet 
de ne pas se poser la question sur la manière dont on devrait faire les choses.
Une donnée c'est quelque chose de fixe, point à la ligne.
La valeur associée à un nom peut changer. Mais quand on travaille sur une référence,
les choses sont toujours claires (suffixe de nom de méthode !).

Je ne sais pas pourquoi, mais avec les langages purement fonctionnels, 
j'ai toujours l'impression de construire une logique, un domaine.
Avec les langages à saveur plus impérative, j'ai plus le sentiment de relier des choses
ensemble, sans jamais changer de niveau compréhension.

Reagent simplifie de beaucoup la création de composants React.
J'ai vu rapidement qu'il était possible de consommer des composants React standard
ainsi que de "Reactrifier" ses composants Reagent.
Évidemment on ne peut pas complètement ignorer le fonctionnement de React.
On réduit le boiler-plate au strict minimum.
Reageant utilise Hipcup pour construire les structures de dom qui seront utilisées pour le dom
virtuel. La syntaxe choisie par Hipcup donne presque l'impression d'écrire des template
de Jade.

Les maudits outils de buid. Quand on a utilisé Maven, Grunt ou Gulp on ne supporte plus
les descripteurs de build complexe. Leinigen semble nettement plus simple.
Tout comme gradle simplifie les choses pour les tâches simples comme builder avec un
watch, faire des source-map, minifier etc.

##Sauf que...

Ce qui m'a donné le plus de fil à retordre c'est la modélisation des données
et trouver une bonne façon de traiter un tour de jeu.
À chaque fois que j'ai travaillé dans un environnement/langage purement fonctionnel,
j'ai le même problème. Sauf qu'au final les solutions sont toujours bien plus simples.
J'imagine qu'avec un peut plus d'entrainement ce problème ce résoudrais.

#One more thing

Je suis me suis amusé à faire une utilisation de clojurescript dans Node/express.
Vraiement basique comme exemple, juste pour ouvrir l'esprit sur l'interopérabilité js/cjjs.
[cljs-toying](https://github.com/benzen/cljs-toying/tree/master)


---
title: Highland.js
layout: post
tags: js library trial stream promise callback
---

 Ne pas faire ce que l'on veux, des fois c'est cool
=======


Je suis un fan de conférence, que je regarde la plus part du temps sur
[InfoQ](http://www.infoq.com/presentations/).

L'autre jour j'ai vu une conférence conjointe entre un gars de
Microsoft et un autre de Netflix
([Reactive programming](http://www.infoq.com/presentations/reactive-programming-netflix)).
Ils presentaient un framework qui permet de traiter tout les types d'évenements
de la même manière. Que ce soit des clique de souris, des touche de clavier,
des requêtes asynchrone ou de la traversé de liste, ils proposent de travailler
ces évènements avec des opérateurs que l'on est habitué de voir sur des listes.

Pour ce fait on wrap nos source d'évènements avec les objet de l'api pour standardisé
l'api avec laquelle on va consomer ces évènements. D'après ce qui est dis dans la
présentation, en arrière l'api crée un mix entre les patterns
[observateur](http://fr.wikipedia.org/wiki/Observateur_(patron_de_conception) et
 [iterateur](http://fr.wikipedia.org/wiki/It%C3%A9rateur). C'est ce qu'ils
 appelent le [Functional Reactive Programming](http://en.wikipedia.org/wiki/Functional_reactive_programming).

Ils ont mis en place ces idée dans une librarie. Puis cette librairie à été porté
dans différent language, comme en atteste [leur compte github](https://github.com/Reactive-Extensions).
Comme c'est Microsoft qui est
en arrière de ce projet l'api qui est proposé utilisent des nom à la
[LINQ](http://fr.wikipedia.org/wiki/Language_Integrated_Query).

J'ai commencé à lire la [documentation](http://reactive-extensions.github.io/RxJS/)
disponible pour le portage JS de cette librarie. Puis j'ai cherché d'autres
source d'info plus détailéé. Et je suis tombé sur [Higland.js](http://highlandjs.org/).

Il s'agit d'un projet de [@caolan](https://twitter.com/caolan) qui est
aussi l'auteur de [Async.js](https://github.com/caolan/async).

Grossièrement l'idée est la même que pour RxJs. Sauf qu'il y arrive par une logique
de réunification. De ce fait la, Highland.js propose une api qui supporte plein de source d'évènement.

Les sources supporté sont:
* Promesses ES6 / jQuery
* Callback node style
* Event Emitter / element jquerifié
* Stream Node

Parmi les sources d'inspiration [@caolan](https://twitter.com/caolan) mentionne
[lowdash](https://github.com/lodash/lodash) et [underscore](https://github.com/jashkenas/underscore).

J'avais un feeling plus agreable avec Highland.js qu'avec Rx.js. Alors j'ai changé
d'idée et j'ai commencé à jouer avec Highland.

Sur les terres des Highland
===========================

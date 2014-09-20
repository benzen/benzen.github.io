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

On comprend toujours mieux avec les mains dans le camboui. Alors je me suis fait
un projet jouet [ici](https://github.com/benzen/demo-highland).

Le layout, très simple. Un mini script bash pour:
 * installer les dependences bower
 * compiler les [jade](http://jade-lang.com/)
 * placer les choses au bon endroit
 * lancer un [http-server](https://github.com/nodeapps/http-server)

Premier coup d'épée
------------------

Droit au but, jettez un oeil à [ceci](https://github.com/benzen/demo-highland/blob/8580234102c287b94a5493db4f881593c5146f90/src/index.jade)

``` javascript
 highland('keyup',$('#fld'))
  .debounce(1000)
  .latest()
  .map(function(event){ return encodeURIComponent($('#fld').val()); })
  .map(function(encodedSearchTerms){ return highland($.ajax("search.html?param="+encodedSearchTerms)); })
  .merge()
  .errors(function(err, push){ push(null, {}); })
  .each(function(result){ $('#content').html(result) })
```

Le processus est super simple, une fois que l'on a compris le principe.
Il y a trois type d'opérateur avec highland:

* des sources typiquement `highland(whatEver)`
* des aspirateurs de valeurs comme `.each(function(){})``
* des tuyaux comme `.map()`

Chaque appel chainé va ajouter une opération au pipeline, sauf le dernier.
Comme le dernier appel est un _apirateur_, il va aspirer des valeur immédiatement.
Les opérations intermédiaires sont _lazy_.


Donc ce que l'on fait dans ce bloc de code:

1. défini une source basé sur les évènement `keyup` du champs `#fld`
1. quand une nouvelle valeur arrive, on attend 1000ms avant de la pousser dans le pipe,
si une autre valeur arrive entre temps, on la discate et on prend la nouvelle valeur à sa place.
1. seul la dernière est conservé
1. grosse surprise, on applique on fonction sur chaque value, on retourne le tout dans le stream
1. avec chaque valeur, on crée un nouveau stream qui prend sa source dans
une requête ajax vers le backend
1. en cas d'erreur quelque pars dans le pipe on s'arrête
1. on fusionne toute les stream dans le stream en un seul stream
1. finalement pour chaque valeur du stream (qui vont être des résultat de call AJAX), on prend le résultat
et on l'affiche dans un div de la page

Écrire cela la première fois est loin d'être facile.
Par contre je trouve le résultat plutôt agréable.
De plus j'ai choisit de faire mes test avec du js juste pour simplifier
la loop de feedback. Mais avec une syntaxe coffeescript ca devient fou:

```coffeescript
highland 'keyup',$('#fld')
 .debounce 1000
 .latest()
 .map (event)-> encodeURIComponent($('#fld').val())
 .map (encodedSearchTerms)-> highland($.ajax("search.html?param="+encodedSearchTerms))
 .merge()
 .errors (err, push)-> push(null, {})
 .each (result)-> $('#content').html(result)

```

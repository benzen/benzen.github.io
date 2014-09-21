---
title: Polymer.js
layout: post
tags: js polymer.js trial
---

Quand j'ai commencé à jouer avec Angular.js, un des slogan c'était
que l'on utilisais les technique de demain aujourd'hui. Il était question
de `data-binding` et de templating natif.

Et puis j'ai commencé à entendre parler de
(web-components)[http://en.wikipedia.org/wiki/HTML_Components].
Il s'agit d'un ensemble d'api qui permettent de crée de nouveaux éléments
html. L'api se décompose en:

* _custom-elements_: comment faire de nouveau éléments html
* _html imports_: comment apporter nos nouveaux éléments dans un site
* _templates_: rendu dynamique coté client simplifié et natif
* _shadow dom_: comment crée un sous-
[dom](http://fr.wikipedia.org/wiki/Document_Object_Model) juste pour chaque mouvel élément customs

Comme les spec de html 5 ne sont pas encore au stade final, tout les
navigateurs n'offrent pas encore les api de web components. Donc
Google à sorti [Polymer](http://www.polymer-project.org/), Mozilla à sorti
[x-tag](http://x-tags.org/).

Le but de ces deux librairies est simplement d'apporter des polyfill pour
les navigateurs qui ne supportent pas encores les api nécessaires.


Évidement ils y a eu tout une série de présentation sur Polymer lors du dernier
google I/O:

* [Componentize the Web](https://www.google.com/events/io/io14videos/1b173063-d0b9-e311-b297-00155d5066d7)
* [Polymer and Web Components change everything you know about Web development](https://www.google.com/events/io/io14videos/b71bb839-35bc-e311-b297-00155d5066d7)
* [Unlock the next era of UI development with Polymer](https://www.google.com/events/io/io14videos/492aed57-d7b9-e311-b297-00155d5066d7)
* [How we built Chrome Dev Editor with the Chrome platform](https://www.google.com/events/io/io14videos/3888155e-32b6-e311-8491-00155d5066d7)
* [Polymer: making Web Components accessible](https://www.google.com/events/io/io14videos/d96291b8-d7b9-e311-b297-00155d5066d7)
* [Polymer: Interacting with Google Services using nothing but HTML](https://www.google.com/events/io/io14videos/5e952876-d0b9-e311-b297-00155d5066d7)
* [Polymer: Creating responsive UIs](https://www.google.com/events/io/io14videos/ba7e1bfe-3cbc-e311-b297-00155d5066d7)
* [Polymer and the Web Components revolution](https://www.google.com/events/io/io14videos/de22e147-07b6-e311-8491-00155d5066d7)

Dommage que le site de google I/O ne permette pas de donner des url avec des recherches.


Rien de mieux q'un projet jouet pour comprendre un nouvel outil. Voici le mien,
[Runner](https://github.com/benzen/runner).
Rien de bien compliqué c'est une appli qui permet de conserver ses informations de courses à pieds.


Un setup un peu long
===================

Comme c'une techno front end, j'ai commencé par là.
Une petite page d'acceuille toute simple avec un menu menu sur la gauche.

En théorie il suffit de deux ligne dans notre `head`
pour bootstrapper notre environnement.

``` jade
  script(src="dep/platform/platform.js")
  link(rel="import", href="dep/polymer/polymer.html")
```

Ce qu'on remarque ici c'est la nouvelle valeur de l'attribut `rel`.
Il s'agit de l'import `html`. C'est comme ca que l'on apporte la définition
de nos éléments custom dans notre page.

Dans les fait j'ai eu besoin de rajouter pas mal de dépendances html.

``` jade
  link(rel="import", href="dep/core-menu/core-menu.html")
  link(rel="import", href="dep/core-item/core-item.html")
  link(rel="import", href="dep/core-icons/core-icons.html")
  link(rel="import", href="dep/core-scaffold/core-scaffold.html")
  link(rel="import", href="dep/core-header-panel/core-header-panel.html")
  link(rel="import", href="dep/core-pages/core-pages.html")
  link(rel="import", href="dep/paper-shadow/paper-shadow.html")
  link(rel="import", href="dep/app-router/app-router.html")
```

Je ne suis pas certain si j'aurrais pu en enlever certain grace à leur dépendances.
Je me suis rendu avec cette liste en suivant ce que je voulais ajotuer et les
messages d'erreur que j'ai eu dans la console.


Mon petit avis
================

Parmis des choses qui m'ont le plus marquer c'est le fait que l'on se retrouve
parfois avec des erreur qui ne sont pas évidenent à débugé. C'est comme avec du
html de base. Sauf que quand il s'agit d'un élément non visuel, il n'est pas
toujours évident de comprendre ce qui se passe.

---
title: Polymer.js
layout: post
tags: js polymer.js trial
---

Quand j'ai commencé à jouer avec Angular.js, un des slogans c'était
que l'on utilisait les techniques de demain aujourd'hui. Il était question
de `data-binding` et de templating natif.

Et puis j'ai commencé à entendre parler de
[web-components](http://en.wikipedia.org/wiki/HTML_Components).
Il s'agit d'un ensemble d'API qui permettent de créer de nouveaux éléments
HTML. L'api se décompose en:

* _custom-elements_: comment faire de nouveaux éléments HTML
* _html imports_: comment apporter nos nouveaux éléments dans un site
* _templates_: rendu dynamique côté client simplifié et natif
* _shadow dom_: comment crée un sous-[dom](http://fr.wikipedia.org/wiki/Document_Object_Model) juste pour chaque nouvel élément customs

Comme les specs de HTML 5 ne sont pas encore au stade final, tous les
navigateurs n'offrent pas encore les API de web components. Donc
Google à sorti [Polymer](http://www.polymer-project.org/), Mozilla a créé
[x-tag](http://x-tags.org/).

Le but de ces deux librairies est simplement d'apporter des polyfill pour
les navigateurs qui ne supportent pas encores les api nécessaires.


Évidemment il y a eu toute une série de présentation sur Polymer lors du dernier
Google I/O:

* [Componentize the Web](https://www.google.com/events/io/io14videos/1b173063-d0b9-e311-b297-00155d5066d7)
* [Polymer and Web Components change everything you know about Web development](https://www.google.com/events/io/io14videos/b71bb839-35bc-e311-b297-00155d5066d7)
* [Unlock the next era of UI development with Polymer](https://www.google.com/events/io/io14videos/492aed57-d7b9-e311-b297-00155d5066d7)
* [How we built Chrome Dev Editor with the Chrome platform](https://www.google.com/events/io/io14videos/3888155e-32b6-e311-8491-00155d5066d7)
* [Polymer: making Web Components accessible](https://www.google.com/events/io/io14videos/d96291b8-d7b9-e311-b297-00155d5066d7)
* [Polymer: Interacting with Google Services using nothing but HTML](https://www.google.com/events/io/io14videos/5e952876-d0b9-e311-b297-00155d5066d7)
* [Polymer: Creating responsive UIs](https://www.google.com/events/io/io14videos/ba7e1bfe-3cbc-e311-b297-00155d5066d7)
* [Polymer and the Web Components revolution](https://www.google.com/events/io/io14videos/de22e147-07b6-e311-8491-00155d5066d7)

Dommage que le site de Google I/O ne permette pas de donner des url avec des recherches.


Rien de mieux qu'un projet jouet pour comprendre un nouvel outil. Voici le mien
[Runner](https://github.com/benzen/runner).
Rien de bien compliqué c'est une appli qui permet de conserver ses informations de courses à pied.

Un setup un peu long
===================

Comme c’est une techno front end, j'ai commencé par là.
Une petite page d'accueil toute simple avec un menu menu sur la gauche.

En théorie il suffit de deux lignes dans notre `head`
pour bootstrapper notre environnement.

``` jade
  script(src="dep/platform/platform.js")
  link(rel="import", href="dep/polymer/polymer.html")
```

Ce qu'on remarque ici c'est la nouvelle valeur de l'attribut `rel`.
Il s'agit de l'import `html`. C'est comme ça que l'on apporte la définition
de nos éléments custom dans notre page.

Dans les faits j'ai eu besoin de rajouter pas mal de dépendances HTML.

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

Je ne suis pas certain si j'avais pu en enlever certains grâce à leurs dépendances.
Je me suis rendu avec cette liste en suivant ce que je voulais ajouter et les
messages d'erreur que j'ai eue dans la console.


Mon premier élément
===================

Créer un élément avec polymer c'est super facile.

```jade
polymer-element(name="mon-premier-element",\attributes="prop1 prop2 prop3")
  template
    h1 Mon titre avec une propriété {{prop1}}, {{prop2}}, {{prop3}}
  script.
    Polymer({
        ready:function(){
          console.log(" un tout petit message" )
        }
    })
```

L'élément `polymer-element` permet de déclarer le nouvel élément `mon-premier-element`.
L'attribut `attributes` permet de définir quelles propriétés de notre nouvel
élément seront rendues publiques.

En dessous on trouve deux éléments `template` et `script`.
Dans l'élément `template` contient le template pour notre nouvel élément.
Quand on utilise notre nouvel élément, c'est une copie de notre template qui
sera injecté dans le DOM. L'élément template supporte l'expansion de variable
avec des moustaches. Si l’on veut avoir un peut de logique tout ça est possible
avec d'autres balises template. Elle supporte par exemple un attribut `repeat` avec
comme valeur une expression comme `value in values`.

L'élément `script` permet de donner un peu de logique pour notre élément.
Ce n'est pas nécessaire, mais ça peut être utile.
On passe une map, au constructeur Polymer. Il faut vraiment voir cela comme un
prototype/une définition de classe pour notre élément.
Dans cette map, certaines clés sont réservées.
Par exemple, la clé `ready` est associée à une fonction qui sera exécutée quand
l'élément sera inséré dans le DOM, un peut comme `$.ready`, mais à l'échelle de
cet élément seulement.


La communauté à l'oeuvre
=========================

En travaillant dans l'application, j'ai eu envie d'avoir un petit graphique
pour afficher l'évolution des différentes valeurs.
Dans mon temps, on ajoutait une dépendance JavaScript.
On se tapait la documentation. Puis on essayait de survivre avec le fait que
tous nos plug-ins se marchent sur les pieds dans le scope global.

Les jeunes aujourd'hui ils font plus ça de même. Ils importent un élément comme
[chart-elements](https://github.com/robdodson/chart-elements) de
[@robdodson](http://robdodson.me/). Ils font ce qu'ils ont besoin de faire .
Puis ils font d'autres choses. C'est-tu assez fou.

Autre bel exemple. Je voulais avoir un petit routeur pour diriger les utilisateurs
entre les différentes pages de mon app. Rien de plus simple.
Une petite recherche sur [bower](bower.io), puis on trouve
[app-router](https://github.com/erikringsmuth/app-router) de
[@erikringsmuth](https://github.com/erikringsmuth).

Pour moi c'est la première fois que je vois un système de module qui à du sens
pour le navigateur. C'est ce qui favorise la production d'éléments/modules
super simple qui fournissent une seule fonctionnalité, mais qui le fait bien.
Je trouve que c'est un très bon signe pour l'avenir du dev front-end.

Une librairie qui fait encore de l'acné
=========================================

En travaillant sur ce petit projet, je me suis aperçu que certains
points manquaient encore de polish. Le plus marquant reste l'élément
`core-ajax` qui fait partie de la distribution de base de Polymer.
Cet élément à pour but de faire une requête ajax et d'appeler une fonction
lorsque le résultat est revenu.

Pour donner des paramètres à notre requête, on a la possibilité de lui passer
un objet. Si notre objet à un seul niveau tout va bien, par contre si on
a eu la mauvaise idée de faire une requête avec un objet à deux niveaux de
profondeur, on se retrouve avec une query string mal encodé genre:

```
query?param=[Object: object]
```

Ce n'est pas bien grave c'est le genre de chose qui se corrige vite.
D'après ce qui s'est passé sur le
[bug tracker](https://github.com/polymer/core-ajax/issues) de cet élément, on
peut voir qu'il y a d'autres petits soucis. Mais la communauté à déjà proposé
des PR pour ces bug. C'est plutôt encourageant pour le support de la communauté.

J'ai eu un autre pépin, en faisant mon premier élément j'ai eu le malheur
d'inverser les éléments script et template. Dans ce cas la, pas d'erreur, rien.
Même pas un petit message flou dans la console.
À titre personnel, j'aurais voulu avoir une forme de validation des éléments
lors de leurs imports/lecture. Je l'ai proposé, mais étant donné que tous les
exemples sont présentés dans le bon ordre, on préfère ne rien rajouter.

Il faut donc laisser un peut de temps à Polymer de passer son adolessance en le
regardant du coin de l'oeil.


Mon petit avis
================

Parmi des choses qui m'ont le plus marqué, c'est le fait que l'on se retrouve
parfois avec des erreurs qui ne sont pas évidentes à débugé. C'est comme avec du
HTML de base. Sauf que quand il s'agit d'un élément non visuel, il n'est pas
toujours évident de comprendre ce qui se passe.

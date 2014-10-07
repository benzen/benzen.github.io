---
tags: sql mentoring @pascal
title: Le cas SQL case when
layout: post
---

Je ne suis pas un pro de [SQL](http://fr.wikipedia.org/wiki/Structured_Query_Language),
 loin de la. Du coup, j'ignore totalement des fonctionnalités qui sont disponibles,
  même si cela fait très longtemps. En travaillant
avec [@PascalChouinard](https://twitter.com/PascalChouinard), qui lui est pas
 mal solide sur le sujet SQL, j'ai appris l'existence de `case when`. Ce post
 vise à documenter son utilisation.

Personnellement j'utilise uniquement [Postgres](http://www.postgresql.org/) comme SGDB.
Certainement que les autres offre quelque chose de similaire, mais je n'ai pas cherché
dans ce sens-là.

À quoi ça ressemble
=================

````sql
    CASE WHEN condition THEN result
         [WHEN ...]
         [ELSE result]
    END
````

* `condition` est une expression qui retourne un booléen
* `result` est une expression

Comment ça marche
================
`Case` est une expression qui s'emploie comme un `switch case` classique.
Une fois qu'une condition est vraie, on ne cherche pas à exécuter les suivantes.
Si aucune condition n'est vraie, alors on exécute le `else`, s’il est présent.
Si aucune condition n'est vraie et que `else` n'est pas présent, alors `case`
retourne `null`.

Utilisation
===========

Voilà le genre de chose que l'on peut faire avec ce *nouvel opérateur*.

````sql
select
  id, first_name, last_name,
  case
    when average_bill < 100 and nb_visit > 4 then 'good customer'
    when nb_visit < 2 then 'new customer'
    else 'pretty average customer'
  end as customer_type;
````

Références
=============
[Doc postgres de `case`](http://www.postgresql.org/docs/9.3/static/functions-conditional.html)

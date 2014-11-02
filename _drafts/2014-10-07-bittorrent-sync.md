---
tags: bittorrent dropbox google-drive
title: Alternative à Dropbox
layout: post
draft: true
---

En fouillant le web, des fois,
 on trouve des trucs incroyable. L'autre jour je suis tombé sur [Bittorrent Sync](sync.bitorrent.com).
En lisant la description sur leur site, j'ai trouvé que l'on pourrait facilement
remplacé un compte DropBox avec ce produit.


Comment ça marche
================

Je ne ferais pas une description étape par étape, le site de Bittorrent
le fais très bien. Rapidement chaque client Bittorrent Sync, correspond à un client Bittorrent
et le groupe de client constitue un équivalent de Tracker distribué.

En plus de cela les morceaux de ficher qui sont envoyé sont encrypté avec une clée
AES 128 bits. Ce qui est sensé assurer la confidentialité des fichiers échangés.

Lorsqu'on fait une modification dans un des fichiers, cela crée une nouvelle
version du fichier qui est ensuite partagé dans le groupe.

Différence avec Dropbox
=======================

Dans son fonctionnement basique, si deux client se partagent un dossier, mais qu'ils
ne sont pas connecté de manière synchrone. Ils ne pourront pas se partager de fichiers.
En effet, la compagnie Bittorrent ne conserve pas de serveur pour héberger nos fichiers
comme le fait Dropbox.

Certain vois cela comme un défaut, pour d'autres c'est un avantages. Si on cherche à remplacer Dropbox,
alors il y a une alternative simple. Un serveur Bittorrent Sync.  

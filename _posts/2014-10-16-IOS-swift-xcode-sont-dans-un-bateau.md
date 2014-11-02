---
title: Ios, Swift et XCode sont dans un bateau
tags: ios swift xcode mobile natif
layout: post
repository: https://github.com/benzen/mimetionnaire-tuto
pathToImages: /images/2014-10-16-ios-swift-xcode-sont-dans-un-bateau
pathToVideos: /videos/2014-10-16-ios-swift-xcode-sont-dans-un-bateau
---

Malgré les gros progrès que HTML5 fait depuis quelques années, la tendance à faire des applications natives ne se dément pas. Que ce soit du côté de la plateforme IOS ou Android. Certaines raisons pour choisir les solutions natives sont assez évidentes, aspect beaucoup plus intégré, les assets sont déjà là au démarrage, réactivité.
Mais le fait de devoir recommencer son application pour supporter les deux platformes est un point de blocage majeur. De plus, Apple et Google prennent une part non négligeable sur chaque vente.
J'ai voulu voir ce que Apple avait à offrir en échange de son 30% de vente.
Pour ce faire j'ai fait un projet jouet. Ce post vise à retracer les différentes étapes pour créer mon appli et vous donner un feeling de ce à quoi correspond l'expérience de dev.


Présentation du projet
-----------------------

Mon ami [@Stephan](https://www.facebook.com/stephane.seners) est un peu étrange. Il lui arrive souvent de perdre ses mots.
Mais quand ça lui arrive il a une technique très _personelle_. Pour s'en sortir.
Il mime le mot qu'il cherche. Sauf que les mimes qu'il fait n'ont rien à voir avec
ce que l'on est habitué de voir. Par exemple, pour téléphone cellulaire ça donne ceci, en plus c'est lui sur la vidéo:

<center>
  <video width="400px" controls>
  <source src="{{page.pathToVideos}}/mime-telephone.mp4" type="video/mp4"/>
  SI tu avais un navigateur à jour, tu verrais une belle video.
  <video>
</center>

En voyant cela, on se dit tous que ça n'a aucun sens. Mais, là où ça devient intéressant,
c'est que ces mimes bizarres, il les réutilise. À chaque fois, qu'il veut dire téléphone
cellulaire, il refait le même signe. Du coup, ça devient intéressant d'avoir un
dictionnaire pour décoder ses mimes. Et pour garder une trace des mimes connus.

Xcode cette bête étrange
-------------------------

Xcode c'est l'[IDE](http://fr.wikipedia.org/wiki/Environnement_de_d%C3%A9veloppement)
qui ne vient pas avec OSX, mais que tout développeur aura installé sur son poste
pour pouvoir travaillé avec ses outils habituels, peut-être sans jamais
se servir de l'IDE [en tant que tel](https://www.youtube.com/watch?v=tSQDGOEWvqM).

Première chose, oubliez vos préjugés d'un IDE [lent et laid](https://www.eclipse.org/).
Xcode est l'IDE le plus rapide que j'ai vu.
Évidemment, il offre toute la panoplie de features que l'on peut attendre d'un IDE.

* Coloration syntaxique (WAHOOUU)
* Recherche dans le projet (quand même)
* Validation de syntaxe et de type
* autocomplétion
* Documentation des fonctions
* Saut à la définition d'un type ou d'une fonction

Une fois dans un nouveau projet on peut voir 4 catégories de fichier.

* les fichiers de code
* Le fichier de slash screen `LaunchScreen.xib`
* Des assets regroupés dans un fichier `images.xcassets`
* Le story-board dans `Main.storyboard`

Le premier n'a pas besoin d'explications. Les deux suivantes, je n'y ai presque pas touché. Le troisième est assez cool, et va avoir besoin de pas mal d'attention.

Le story-board c'est un builder visuel d'interface. Personne ne nous force à l'utiliser, on peut aussi construire l'interface avec du code. Je suppose que, comme tous les builders, en travaillant un peut plus avec, on va avoir une période de lune de miel. Puis, quand on est assez familier avec, on finit par ne plus vouloir l'utiliser. Mais, la première approche semble prometteuse.

Dans le story-board, on va créer des écrans (des views controller ) en les remplissant de widgets. Le view controller est la fonctionnalité de base de l'écran, les widgets rajout un petit plus particulier au contexte.

On pige nos views controller et nos widgets dans cette liste, en bas à droite:

<center>
  ![Liste de widget]({{page.pathToImages}}/list-widget.png)
</center>

Dans cette liste on retrouve un peu de tout.

* Labels
* boutons
* text field
* slider
* stepper
* progress bar
* table (qui est en fait une liste)
* collection view
* date-picker
* carte
* vue web
* contrôles de navigation
* bar de recherche

Une fois que l'on a assemblé à créer une vue qui nous plaît, on peut la lier à une deuxième avec
des `Segue`. Ce sont les `Segue` qui vont définir les mouvements possibles pour l'utilisateur.

Chaque ViewController à une série de propriétés que l'on peut manipuler via le story-board.

<center>
  ![Liste de propiété d'un view controller]({{page.pathToImages}}/propriete-view-controller.png)
</center>

Simulateur
------------

Quand on a fini d'assembler notre vue, ou ajouter une fonctionnalité, on a envie de l'essayer pour voir si tout fonctionne encore. Si le comportement est bien celui que l'on imagine. Pour faire ça on peut soit devenir IOS developper, payer un 100 $ à Apple et pouvoir déployer sur des vrais téléphones. Ou bien lancer le simulateur qui vient avec XCode.

Une icône play et une icône stop sont en haut à gauche à côté des boutons pour réduire la fenêtre et fermer l'application. Si on clique sur play, un build part, j'imagine que si j'avais eu des tests il serait parti ensuite, et une interface de iPhone (ou de iPad) est présentée quand l'application est prête à être lancée.

Une fois que c'est fait, on peut faire à peu près tout ce que l'on veut dans le téléphone simulé. Aller dans la pellicule, lancer notre appli, en sortir, la relancer. Ajouter des images, des vidéos.

Bref c'est pratique et on va s'en servir en masse.

Étape par Étape
---------------
On va y aller un objectif à la fois. Pour chacune des étapes, il va y avoir un tag dans le dépôt qui correspond à l'étape que vous êtes en train de lire. Cela vous permettra de voir par vous même les différents éléments se mettre en place.

Le projet est [ici]({{page.repository}}).

Une petite note avant d'aller plus loin. Ici on va tout faire avec le storyboard, parceque c'est plus simple pour commencer.

Première vue
-------------

C'est parti. On crée le projet. Xcode propose plusieurs templates d'application IOS et OSX.
On va au plus simple, `IOS single page app`. On choisit un nom, un name space, un langage (Swift)
et le device sur lequel on veut déployer notre application. J'ai pris juste le iPhone pour ne
pas avoir à gérer les différences de taille d'écran. Ensuite, on peut choisir un sens dans lequel
l'application va fonctionner. Pour faire ça simple, on prend juste `Portait`.
Toujours pour la même raison, on va rendre notre application uniquement compatible avec une version
précise de iPhone.
Dans le story-board, on va décocher la cache `size classes`.


On souhaite aussi que les déplacements dans l'application soient contrôlés. Pour cela,
on va inclure notre application dans un `Navigation Controller`.
Pour faire cela, il faut:

1. Sélectionner notre unique `View Controller`
1. Cliquer sur le menu `Editor`
1. Cliquer sur le sous-menu `Embed in`
1. Puis sur `Navigation Controller`

Une nouvelle vue sera ajoutée à gauche de celle que l'on avait avant. Et toutes les vues qui seront liées directement ou indirectement au Navigation Controller auront une toolbar qui donnera des outils (p.ex. un bouton back) pour naviguer entre les différentes vues.


<center>
  ![Notre première vue]({{page.pathToImages}}/premier-etape.png)
</center>


TAG: [step-1]({{page.repository}}/tree/step-1)


Vue dynamique
------------

Avoir une vue c'est bien, mais si elle ne fait rien notre appli n'est pas très utile.
On va l'étoffer avec un peu pour la rendre plus intéressante.

Cette première vue va être notre liste de mime. On  va aussi avoir une barre de menu pour mettre
un bouton `Add` pour aller vers la vue qui sera responsable de la création d'un nouveau mime.
Je suppose aussi que la liste va devenir longue et que nos utilisateurs ne veulent pas scroller la liste indéfiniment.
Donc on ajoutera une barre de recherche aussi.

L'ordre dans lequel on ajoute les choses ne devrait pas être important.
Toutefois, j'ai remarqué que c'est plus facile de faire les choses de haut en bas.

Lorsque l'on déplace un widget, on remarque que des guides apaisent pour
aider à place le widget de manière relative à d'autre élément.

On va ajouter un bouton à notre `Navigation Bar`.  Les boutons qui vont dans les barres de menu sont les
`Bar Button Item`, on en glisse un sur le côté droit de la barre.
Par défaut le bouton affiche un texte, on va changer cela.
Un certain nombre de boutons sont standard, par exemple pour
une action de type ajout, on peut se contenter de changer le rôle du bouton, ce qui
induit que l'icône va changer.

<center>
  ![Changement de rôle de bouton]({{page.pathToImages}}/change-button-type.png)
</center>

On va changer la valeur du champ `identifier` pour `add`.


Ensuite, on ajoute le widget `table view` dans notre view controller, collé en dessous de la
 toolbar en utilisant tout l'espace disponible dans notre view controller.

Puis on va chercher une barre de recherche. En fouillant la liste de widgets, on peut voir qu'il y a deux widgets avec search dans leur nom.

<center>
  ![Liste de widget de recherche]({{page.pathToImages}}/search-widget.png)
</center>

* `SearchBar` donne uniquement la barre de recherche.
* `SearchBar and SearchDisplay` donne la barre et une zone pour afficher les résultats de la recherche.

Comme on affiche déjà une liste en dessous, je ne vois pas pourquoi on s'embêterait à avoir de la logique
d'affichage pour les résultats de recherches, qui de toute manière serait proche de notre logique d'affichage des items
de la liste des mimes.

On place notre boîte de recherche en haut de la `tableView`. Avant de la lâcher, on fait bien attention d'avoir une ligne bleue
en haut de la `tableView`. De cette manière, on va placer notre `SearchBar` dans le `header` de la `tableView`.
Ansi les autres éléments de la liste (les cellules qui contiendront nos mimes), vont être affiché en dessous.
Si on n'y prête pas attention, la `SearchBar` se retrouvera après les mimes.

On va ensuite ajouter une cellule prototype à notre `tableView`. Ce prototype va nous permettre de configurer ce qui
sera affiché comme texte/ bouton/ comportement sur chacun des items de la liste.

On a maintenant tous les morceaux qui sont en place pour mettre de donner tout le comportement que l'on veux
à notre vue.

<center>
  ![Étape deux]({{page.pathToImages}}/etape-deux.png)
</center>

TAG: [step-2]({{page.repository}}/tree/step-2)

Formulaire
-----------

On va ajouter une seconde vue dans notre `story-board`, la vue pour ajouter un nouveau mime. Ça sera un simple formulaire avec un champ de texte pour le nom du mime et un bouton pour choisir une vidéo dans la pellicule du téléphone.

Les `ViewController` sont affichés comme des widgets dans la liste en bas à droite de l'écran. Donc, il suffit de les droppers dans le story-board. On va prendre un view controller basique.

La suite se passe de commentaire. On glisse des labels, un champ texte, un bouton.

Voilà à quoi ressemble ma vue:

<center>
  ![Formulaire d'ajout]({{page.pathToImages}}/etape-trois.png)
</center>

TAG: [step-3]({{page.repository}}/tree/step-3)

Lien entre deux vues
------------------

Pour faire un lien entre deux vues, il suffit de tendre un `Segue` entre deux View Controller.
Dans notre cas, on va sélectionner le bouton d'ajout. Dans la partie en haut à droite de Xcode,
on retrouve le menu suivant:

<center>
  ![Création de segue]({{page.pathToImages}}/segue.png)
</center>

Avec un drag-and-drop, depuis `Triguered Segue Action` on va aller pointer notre seconde vue.
Un petit menu apparait et nous propose plusieurs types de transitions.
Prenons `show`. L'animation va déclarer la vue courante vers la gauche et la nouvelle arrivera depuis la droite.
Comme les dossiers dans OSX.

Si on lance le simulateur, on va pouvoir cliquer sur notre bouton `Add` ce qui va nous faire
changer de vue. Une fois dans la vue d'ajout on est capable de revenir en arrière avec un bouton back

<center>
  ![Premier segue]({{page.pathToImages}}/etape-quatre.png)
</center>

TAG: [step-4]({{page.repository}}/tree/step-4)


VideoPicker
---------------

Dans la vue de création de mimes, on a un bouton pour sélectionner une vidéo.
Mais ce bouton ne fait rien jusqu'a maintenant.

Pour faire ça on va avoir besoin de faire un peu de code (ENFIN).
On va se créer une class Swift, que l'on va appeler `AjouterMimeViewController`.

```Swift

import UIKit
import MobileCoreServices

class AjouterMimeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

}
```

Notre class hérite de UIViewController qui est la classe de base pour ce qui est de la gestion
d'une vue.
Le UIImagePickerControllerDelegate permet d'ajouter un certain nombre de comportements relatifs aux choix d'image, en implémentant un mimumum de méthodes.
le UINavigationControllerDelegate permet quant à lui d'avoir le comportement qui permet ne naviguer entre les vues sans trop s'en soucier.

Ensuite, on va ajouter une méthode pour sélectionner une vidéo dans la pellicule.

````swift
func selectVideo(){
    var ipController = UIImagePickerController()
    ipController.delegate = self
    ipController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
    ipController.mediaTypes = NSArray(object: kUTTypeMovie)
    ipController.allowsEditing = false

    self.presentViewController(ipController, animated: true, completion: nil)
}
````

Dans cette méthode, on désigne la classe qui servira de delegate pour ceci, la classe courante.
On précise aussi où seront pris les médias, dans la pellicule.
On prendra aussi uniquement des vidéos, parce qu'on pourrait aussi prendre des photos.
En mettant AllowsEditing à true on aurait la possibilité de sélectionner des sous-clips de nos vidéos.

Maintenant, on sait quoi faire lorsque l'on à un click sur notre bouton.
Mais, on n'a pas de lien entre l'évènement de click et cette fonction.
Pour cela, on va ajouter l'annotation `@IBAction` sur la fonction `selectVideo()`.
Ceci va permettre de rendre visible la fonction au story-board et ainsi permettre de tracer un segue entre la fonction et le bouton.
Seules les fonctions qui appartiennent à la classe qui gère une vue et qui est annotée avec `@IBAction` sont accessibles dans le story-board.

On va donc connecter la vue et la classe `AjouterMimeViewController`. Il suffit d'aller dans le story-board,
de cliquer sur la partie haute de la vue, puis de cliquer sur l'icône jaune à gauche.
<center>
![Icone configuration de vue]( {{page.pathToImages}}/configuration-vue.png )
</center>

Cela va ouvrir la configuration de la vue en au à droite dans XCode. En mettant le nom de la classe de controller de cette vue dans le champ `class`, on établit le lien.
<center>
![Lien view/controller]( {{page.pathToImages}}/class-vue.png )
</center>

Maintenant, si on lance l'application, on peut voir qu'on peut aller dans la liste de vidéo du téléphone. Mais, il ne se passe rien si on en sélectionne une.
Pour cela, on va ajouter une fonction dans notre controller.

```Swift
func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!){
    var url = info.objectForKey(UIImagePickerControllerReferenceURL) as NSURL
    var urlAsString = url.absoluteString!
    self.dismissViewControllerAnimated(true, completion: nil)
}
```

Cette méthode est définie dans le delegate `UIImagePickerControllerDelegate`. Elle est optionnelle, mais lorsqu'elle est présente, elle est appelée avec le picker (dans notre cas il s'agit du view controller courant) et une map d'info relative au fichier (p.ex. taille, format, URL...). Dans notre cas on va récupérer l'url de la vidéo sous forme d'une String pour la sauvegarder facilement et la réutiliser plus tard. Pour l'instant, cette fonction ne fait rien d'utile, mais quand on aura commencé à regarder la persistance, on la bonifiera.

Pouvoir sélectionner des vidéos c'est bien, mais par défaut le simulateur n'a pas de vidéo. On va en ajouter une. Trouver ça quelque part. Par exemple la vidéo qui est en haut de cet article (sous forme plus facile à télécharger [ici]({{page.pathToVideos}}/mime-telephone.mp4) ). Ensuite il suffit de dropper le fichier sur le simulateur pendant qu'il tourne pour que la vidéo ouverte dans  dans le simulateur. Avec les contrôles qui sont disponibles dans le nouvel écran, on peut sauvegarder la vidéo dans la pellicule. Pour sortir du player/navigateur qui s'est ouvert, on cliquerait sur le bouton home, dans le simulateur on fait un
`cmd+shift+h`. Si on relance l'application, Là, on peut sélectionner notre vidéo.

On n'a pas encore donné de comportement pour le bouton `Ajouter`, on va le faire
dans la prochaine section.

TAG: [step-4]({{page.repository}}/tree/step-4)

Persistence
------------

Avant de chercher à persister nos mimes, on va commencer par choisir qu'est ce que c'est un mime? On va se faire une petite classe `Model`/`Domain` appeler ça comme vous voulez bref une structure nommée pour standardiser les mimes.

```Swift
class MimeModel{
    var nom = ""
    var videoUrl = ""
}
```
Rien de très excitant.

On va aussi se faire un store, qui va conserver les mimes une fois définis.
Partons d'une définition simpliste.

```Swift
class MimeStore {
    var store: Array<MimeModel>

    init(){
        self.store =  []
    }

    func addMime(m :MimeModel){
        self.store.append(m)
    }
    func listMime() -> Array<MimeModel>{
        return self.store
    }
    func removeMime(nom :String){
        self.store = self.store.filter({ $0.nom != nom})
    }
    func getMime(nom :String) -> MimeModel{
        var models = self.store.filter({ $0.nom == nom})
        return models[0]
    }
}
```

En faisant cela, on a défini l'api de cette classe et on a un comportement basique. Évidemment, après un redémarrage, on aura perdu notre liste. On va donc persister de manière un peu plus durable.

Plusieurs choix s'offrent à nous de manière native sur la plateforme. Pour des raisons que j'explique dans la section _Choix technologique_ j'ai choisit Sqlite, et plus particulièrement le module [SQliteDB](https://github.com/FahimF/SQLiteDB) de [@FahimF](https://github.com/FahimF).

Pour utiliser SQliteDB, il faut copier les sources du projet dans notre projet, il semble qu'il n'y est pas vraiment de système de gestion de dépendances dans l'univers Swift Cocoa. Ce faisant, on remarquera qu'il y a un fichier `Bridging-Header.h`. Ce fichier permet de faire le lien entre les modules cocoa de notre application (SQliteDB) et les modules Swift (tout le reste). Pour qu'il soit utilisé dans le projet, il aller dans le `Build Settings`, on y accède en cliquant sur le nom du projet en haut de l'explorateur de fichier dans XCode.
On modifiera la valeur de `Objective-C briding header`, utiliser la recherche pour le trouver.

Pendant que l'on est dans les `Build Settings`, on va aller dans les `Build phases`, le menu d'accoté. Et, on va ajouter un lien vers une librairie. `libsqlite3.0.dylib` en l'occurrence. SQLiteDb permet de donner une interface Swift à SQlite, mais on a quand même besoin de SQLite.

Malheureusement, SQliteDB ne permet pas de créer une base programativement. On a donc besoin de créer cette base avec notre unique table ainsi.

```
$ sqlite3 data.db
sqlite> CREATE TABLE mime (nom text, videoUrl text);
sqlite>.q
```

On a maintenant un fichier `data.db` que l'on va placer dans les sources de notre projet. On a besoin également de le déclarer dans Xcode pour qu'elle soit copiée lorsque l'on lancera le simulateur. Ça se passera dans ``Build Phases` sous `Copy bundle ressources`.

Pour pouvoir faire des requêtes, il suffit de faire ceci

```Swift
let db = SQLiteDB.sharedInstance()
let rs = db.query("SELECT * FROM mime")
```

On a tout les éléments pour réimplémenter notre store.

```Swift

class MimeStore{
    let insert = "INSERT INTO mime (nom, videoUrl) VALUES (?, ?);"
    let list = "SELECT nom, videoUrl FROM mime;"
    let delete = "DELETE FROM mime where nom=? and videoURL=?;"
    let find = "SELECT nom, videoUrl FROM mime WHERE nom like ?;";
    let db = SQLiteDB.sharedInstance()

    func addMime(mime: MimeModel){
        let err = db.execute(insert, parameters: [mime.nom, mime.videoUrl])
        if (err == 0){
            NSLog("ERROR during save of mime\n\(err)")
        }
    }

    func listMime(query: String?) -> Array<MimeModel> {
        let resultSet =  query!.isEmpty ? db.query(list) : db.query(find, parameters:["\(query!)%"])

        return resultSet.map {
            (row:SQLRow) -> MimeModel in
            let nom = row["nom"]!.asString()
            let videoUrl = row["videoUrl"]!.asString()
            return MimeModel(nom:nom, videoUrl:videoUrl)
        }
    }
    func delete(mime: MimeModel){
        let err = db.execute(delete, parameters: [mime.nom, mime.videoUrl])
        if(err == 0){
            NSLog("ERROR during deleting mime")
        }
    }
}
```

Pas plus compliqué que cela. On a maintenant un module de persitence fonctionnel.
Pour valider qu'il fonctionne, on va ajouter le comportement du bouton OK, dans le formulaire d'ajout de mime.

Pour cela on va définir des propriété `model` et `store` dans notre ViewController. On va aussi ajouter une propriété qui va représenter notre champ de texte.

```Swift
let model: MimeModel =  MimeModel()
let store: MimeStore = MimeStore()
@IBOutlet
var nomField: UITextField!
```

La déclaration du champs `nomField` a deux particularités. Il est annoté `IBOutlet`
et son type est suivi d'un !. L'annotation est la pour la même raison que les annotations  `IBAction` que l'on a vues un peut plus tôt, pour permettre de tracer des segues depuis et vers ce morceau de code. Le point d'exclamation est présent à cause du type imposé par IBOutlet. IBOutlet impose que le type de la variable annoté soit un type optionnel. Car la variable va être injectée, donc on ne sait pas quand elle sera définie et il se peut que l'on exécutât du code qui veuille accéder à cette variable avant cela.

En Swift, les types optionnels sont notés de deux façons. `:type?` où `:type!`.
Le typage avec ? Démontre que le type est optionnel et que l'on peut obtenir
une valeur vide ou une vraie valeur si l'on va chercher cette valeur. Par contre, si l'on va chercher une valeur avec ! le programme peut s'arrêter de manière inattendue.

On va aussi ajouter deux fonctions, une qui sera exécutée quand le texte du champ nom sera changé, et une qui sera exécutée quand le bouton ajouter sera cliqué.

```Swift
@IBAction
func onTextChange(){
    model.nom = nomField.text
}

@IBAction
func ajouterMime(){
    store.addMime(model)
    self.navigationController?.popToRootViewControllerAnimated(true)
}
```

Pour que tout cela fonctionne, il reste à placer des segues entre onTextChange et le champ de texte, xcode va proposé plusieurs évènements on choisira `editing did end`. On placera aussi un segue entre `ajouterMime` et le bouton `Ajouter` et un dernier entre `nomField` et le champ de texte.

La dernière ligne de `ajouterMime` semble un peu spécial. Elle permet de retourner vers la vue précédente. Oui, par ce que notre application utilise une navigation contrôler (et aussi parceque cette classe adhère au protocol `UINavigationControllerDelegate`)et que depuis la liste on a fait un `push` de la vue `AjouterMimeView`, donc la on demande au `NavigationController` de dépiler son historique.


TAG: [step-5]({{page.repository}}/tree/step-5)

Liste
----------

Jusqu'ici, on a une liste avec un prototype de cellule, mais one ne fait rien avec tout ça. Un peu poche.

Pour corriger cela, très simple. On va ajouter deux mixins à notre classe `ListerMimeViewController`.

```Swift
class ListerMimeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
```
`UITableViewDelegate` permet de gérer le comportement de la liste. `UITableViewDataSource` permet quand à lui de donner du contenu à notre liste.


`UITableViewDataSource` nous force à implémenter deux méthodes, il y en a d'autres qui sont optionnels.

```Swift
func tableView( tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = self.tableView!.dequeueReusableCellWithIdentifier("cell") as UITableViewCell

        let model = self.store.listMime("")[indexPath.row]
        cell.textLabel.text = model.nom
        return cell

}
func tableView( tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int{
        return store.listMime("").count
}
```
On ajoute aussi deux membres à notre classe pour pouvoir manipuler les éléments de cette vue. On fera aussi le lien entre le membre tableView et le widget dans la vue avec le Storyboard.


```Swift
@IBOutlet
var tableView: UITableView!
let store = MimeStore()
```

On a aussi besoin de pluguer les membres dataStore et delegate du tableView sur notre `ListerMimeViewController`. On va modifier notre méthode `viewDidLoad` pour faire ce branchement.

```Swift
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.tableView.delegate = self
    self.tableView.dataSource = self
}
```

Et voilà, notre liste est prête à recevoir les mimes du store.
On peut le valider en créant des mimes.

TAG: [step-6]({{page.repository}}/tree/step-6)

Recherche
-------------

Avoir une belle grande liste de mime c'est cool. Mais moi, _personnellement_ je n'aime pas ça scroller pendant 1 minute. La barre de recherche à déjà été ajoutée avant. Donc, il ne nous reste plus qu'a la brancher sur un mécanisme de recherche.

Avec ce que l'on a mis en place dans les étapes précédentes on s'est facilité la vie.

On va ajouter une référence vers la barre de recherche dans la `ListerMimeViewController`. Et on fera un lien avec le widget dans le story-board.

```Swift
@IBOutlet
var searchBar: UISearchBar!
```

Puis, on modifie les méthodes de gestion de la liste pour se baser sur un sous ensemble de mime dont le nom match le texte dans la barre de recherche.

```Swift
func tableView( tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = self.tableView!.dequeueReusableCellWithIdentifier("cell") as UITableViewCell

        let model = self.store.listMime(searchBar.text)[indexPath.row]
        cell.textLabel.text = model.nom
        return cell

}

func tableView( tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int{
        return store.listMime(searchBar.text).count
}
```

Avec ceci, la liste contiendra uniquement les mimes dont le nom match le continue de la barre de recherche. Mais, si le contenu de la barre change, il ne se passe rien. Pour cela, on va ajouter le delegate `UISearchBarDelegate`
Ce delegate nous permet d'ajouter des méthodes qui seront appelées lors d'évènement spécifiques.

```Swift
func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
      self.tableView.reloadData()
}
```
Pour que la barre de recherche utilise, notre view controller comme delegate, on va lui demandé de le faire en ajoutant ceci dans la méthode `viewDidLoad()`.

```Swift
self.searchBar.delegate = self
```

TAG: [step-7]({{page.repository}}/tree/step-7)

Player vidéo
--------------

Bon, maintenant on a une vraie liste de mimes. Mais, une fois que l'on ajoute un mime, avec sa vidéo, on ne peut pas la revoir. Ça, c'est dommage. On va corriger ça.

Pour cela, on va ajouter une nouvelle vue dans notre Story-board, un `AVKitPlayerViewController`. Ensuite, on va tracer un segue depuis la cellule prototype de la liste, avec le triggered Segue `Selection` (pour que le lien se fasse lors d'une sélection de cellules) vers le Player vidéo. J'ai choisi le mode de transition modal, ça c'est celui qui donne le meilleur effet dans ce cas-ci.

La transition peut maintenant se faire, mais le ployer ne sait pas quoi jouer quand on veut l'afficher. Pour cela, il faut lui fournir l'url de notre vidéo. Pour faire ça, on va ajouter les deux méthodes suivantes.

```Swift
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    self.performSegueWithIdentifier("playVideo", sender: self)
}

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if (segue.identifier == "playVideo") {
        let indexPath = tableView?.indexPathForSelectedRow()
        let model = self.store.listMime(searchBar?.text)[indexPath!.row] as MimeModel
        let url = NSURL(string: model.videoUrl)
        if let subVC = segue.destinationViewController as? AVPlayerViewController {
            subVC.player = AVPlayer(URL: url)
            subVC.player.play()
        }
    }
}
```

Le compilateur va se plaindre qu'il ne connaît pas les class `AVPlayerViewController` et `AVPlayer`. Ajouter donc ceci dans vos imports.

```Swift
import AVKit
import AVFoundation
```

Si vous avez porté attention vous aurez remarqué qu'on parle d'identifiant de segue dans le code que l'on vient d'introduire.
Mais, on a jamais défini d'identifiant de segue. On va utiliser `playVideo` pour le segue entre la liste et le player. À cause d'un bug dans la plateforme, on va devoir en définir aussi sur les autres segue, même si ce sont des chaines vides, il faut en ajouter, et le supprimer sur tous les segues, pas de pleurnichage on a juste un segue à nommer et dénommer.

Et voilà, on à une liste avec un player relié.

TAG: [step-8]({{page.repository}}/tree/step-8)

Supprimer des mimes
-------------------

On a tous vu des actions sur une liste, ou on fait glisser la cellule vers la droite ou la gauche. Il s'avère que c'est simple à implémenter, alors c'est comme cela qu'on va faire la suppression de mime.

```Swift
func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }

func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
    if (editingStyle == UITableViewCellEditingStyle.Delete) {
        // handle delete (by removing the data from your array and updating the tableview)
        let model = store.listMime(searchBar.text)[indexPath.row]
        store.delete(model)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
}
```

That's it, c'est cool quand même.

TAG: [step-9]({{page.repository}}/tree/step-9)

Cacher la barre de recherche
---------------------------

Ici, c'est un petit nice to have que je veux ajouter.
Je veux que la barre de recherche soit cachée par défaut et qu'il faille tirer la liste vers le bas pour l'afficher. C'est là, que l'on peut comprendre la raison pour laquelle j'ai insisté sur le positionnement de la barre de recherche, TOUT en haut. On a placé la barre dans le header du tableView pour que sa position soit fixe et donc plus facile à cacher.

Voilà la méthode qui va permettre de cacher notre barre.

```Swift
func hideSearchBar(){
    var frame = self.tableView.frame
    let isSearchBarVisible = CGRectIntersectsRect(frame, searchBar.frame)
    if isSearchBarVisible {
        let y = self.tableView.contentOffset.y + self.searchBar.frame.height
        let newContentOffset = CGPoint(x:0, y: y)
        self.tableView?.setContentOffset( newContentOffset, animated:true)
    }
}
```
Ensuite, il suffit d'ajouter un appel à cette méthode au bon endroit. Par exemple, lors que l'on parcoure le segue `playVideo` ou lorsque l'on va cliquer sur le bouton `cancel` de la barre de recherche ou encore quand la vue va apparaitre.

```Swift
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    hideSearchBar()
    if (segue.identifier == "playVideo") {
        ...
```
```Swift
func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    hideSearchBar()
    searchBar.text = ""
    tableView.reloadData()
}
```
```Swift
override func viewDidLoad() {
    ...
    hideSearchBar()
}

```

Et voilà, l'application faite tout ce que je voulais.

Choix technologique
======================

Persistence (UserPreferences, core-data, sqlite)
------------------

Vu la faible complexité de mon modèle de données, j'ai recherché le plus simple
moyen de sauvegarder mes données. Comme j'étais en processus d'apprendre
IOS j'ai orienté mes recherches uniquement sur les modules de persistance natifs.

D'après mes premières recherches, le plus simple est le module UserPrefererences.
Il s'agit d'un équivalent de LocalStorage. Une grosse map dans laquelle on peut mettre des
types natifs et des objets au bout d'une clé. D'après le nom on se doute à
quoi ça doit servir. J'imagine qu'il existe des limitations assez basses sur la quantité de données que l'on peut insérer avec ce module. J'ai commencé à travailler avec et
tout semblait bien aller.
Quand j'ai arrêté mon simulateur, mes données étaient effacées. Je suppose qu'il
existe un moyen de confirmer que l'on veut persister nos données après un arrêt
de l'application, mais je ne l'ai pas trouvé. J'ai cherché autre chose.

Le second module qui est ressorti tout de suite après, c'est CoreData.
La lune de miel a été très courte. Le temps de comprendre qu'il s'agit d'un
ORM a l’hibernante. J'ai vomi, je suis allé voir plus loin.

Le troisième module qui est disponible nativement SQLite.
Rien de très complexe ici, on connait tous SQL. SQLite est juste une base qui
est tenue dans un fichier, idéal pour une base embarquée. Le seul point spécial
c'est qu'il n'y a pas de module natif en Swift pour ça.
Donc, tout le monde a construit sa petite lib pour ne pas avoir à travailler
tous les jours avec cocoa. J'ai essayé les modules suivants:

* SwiftData
* SQLiteDB

Ils font tous un peut la même chose. J'ai fini avec SQLiteDB, car c'est le seul que j'ai réussi à installer. Ah oui, by the way, avec Swift il n'y a pas encore de système de gestion de dépendances, c'est pas mal triste en 2014. Du coup, on revient à ce que l'on faisait dans *l'ancien temps*. On copie les dépendances dans notre projet, dans un dossier appart si on veut être un poil propre. On peut le faire avec un submodule git pour faciliter la mise à jour des dépendances.

Langage(Swift/Objective-C)
-------------------

J'ai plus rejeté Objective-C que choisit Swift. La gestion de mémoire, la vie avec des pointeurs et les appels de fonction par passage de message. Pour tout cela je suis d'avis que l'ont à _maintenant_ des solutions qui correspondent bien à la plupart des cas d'usage. Donc à moins d'avoir un besoin particulier, je pense que tout cela on est mieux de s'en tenir loin.

Avant de me lancer dans l'écriture de ce projet j'ai lu la description du langage, pas en entier et en diagonale. Dans le fond, je l'ai lu jusqu'au point de me dire:

_Ahh je connais tout ça .. Presque..._

Après coup, je me rends compte que certains points sont moins évident ne sont pas aussi
habituels qu'il n'y parait. Si vous voulez sauter dans Swift, regardez attentivement ces points
dans la doc du langage.

1-La manière de déclarer des signatures me fait penser à OCaml. Mais ce n'est pas tout le monde qui
a travaillé avec des langages académico-weirdo.
2-Les différents opérateurs pour les types optionnels (`type?` et `type!`)


Avis
======

Xcode
------
Même si ça reste un IDE, qui ne sera jamais capable de traiter avec des langages dynamiques comme Swift. Il me réconcilie avec l'idée d'une IDE (l'IDÉe :).
C'est rapide, ça aide vraiment, surtout pour ce qui est du story-board.

Swift
------
Le langage bien que pas particulièrement brillant pour des fonctionnalités particulières offre tout de même les blocs qui sont maintenant requis pour un langage de base, fonction anonyme entre autres. J'avoue ne pas avoir passé beaucoup de temps sur le langage. Pour moi, ce que ce langage apporte c'est surtout de pouvoir faire des applis IOS sans saigner des yeux avec de l'objective C.

La plateforme IOS
-------------------

Contrairement à ce que je pensais en commençant, la plateforme est très agréable à travailler. La communauté est grosse et dynamique, donc on trouve facilement le support dont on a besoin pour terminer une tâche.
J'ai pris beaucoup de plaisir à faire cette petite application jouet. Sûrement que j'en ferrais d'autres.

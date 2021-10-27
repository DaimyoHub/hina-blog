# Un système constitué d'un ensemble de composantes

## *Sommaire*

* Qu'est-ce qu'une composante ?
* Pourquoi ce modèle plutôt qu'un autre ?
* Quels sont les inconvénients du modèle ?
* Comment gérer les composantes ?
* Conclusion.

## Qu'est-ce qu'une composante ?

Posons les bases, éclaircissons les termes qui parraissent flous. Hina est une
**infrastructure**, c'est à dire qu'elle regroupe un **ensemble d'outils** liés aux
domaines de l'informatique mis en jeu dans les infrastructures de compilation et
les machines virtuelles.

Étant donc développée sous la forme d'une infrastructure, il semble cohérent de
construire chacun des **outils qui la composent de façon indépendante**. Et c'est ici
que la notion de *composante* intervient:

Pour synthétiser le concept, je dirais qu'une composante est **un service précis
qui répond à un et un seul besoin précis**, en fournissant une interface qui expose
une API minimaliste. Mais ça n'est pas tout. En effet, exposer ma conception
d'une composante est une maigre affaire, mais elle se complexifie lorsque
de dois aborder la thématique de **dépendance à d'autres composantes** et l'**organisation**
de celles-ci dans une architecture bien définie. Pour expliquer en quoi cette
thématique conciste, je vous fournis cette liste simplifiée. Je suis convaincu
qu'elle suffira à ce que vous compreniez l'essentiel de l'organisation de mon
infrastructure.

On peut imaginer les **relations entre composantes** comme un **arbre**.
Les **noeuds** sont des composantes, les **liens** entre deux noeuds sont des relations
de dépendance.
* Soient A, B et C, trois noeuds respectivement liés:
  * A ne dépend de rien
  * B dépend de A
  * C dépend de B qui dépend de A. Relation de Chasles: C dépend aussi de A
  * A est une composante généraliste: elle fournit une interface générale
  * C est une composante spécialiste: elle fournit une interface spéciale

![Arbre simple](../pics/arbre_composantes.png)

On trouverait aussi un cas différent: lorsqu'un arbre n'est composé que d'un seul
noeud. Dans ce cas-ci, le seul noeud présent ne serait ni généraliste, ni spécialiste,
ni dépendant. C'est une simple composante.

## Pourquoi ce modèle plutôt qu'un autre ?

Comme expliqué antérieurement, le système de composantes me permet de maintenir une
grande flexibilité lors du développement d'Hina. Cependant, cette flexibilité ne
sera possible que si les dépendances entre composantes sont proprement gérées.
Par exemple, il serait tout à fait injustifié de créer un fil de dépendance
très long, puisque chaque modification d'une dépendance entraine la modification
des composantes qui en dépendent. Cet aspect du design sera approfondi dans les
prochains paragraphes.

Le système de composantes permet, comme vous l'aurez compris, de limiter les
dépendances entre chaque outil, ou du moins, de me permettre de réfléchir 
précisément sur l'organisation de mes outils et de leur façon de dépendre entre
eux.

Le système de composantes permet aussi de généraliser la gestion des outils qui
composent Hina. Plutôt que de mettre en place chaque composante sous forme de 
dossier contenant les sources, les headers, les tests, etc., une à une, le concept
de composante en lui même me permet de baser la compilation d'Hina sur une même
interface pour différents outils. Autrement dit, au lieu de gérer la compilation
au cas par cas, je peux la gérer de façon générique, puisque le modèle de compilation
de mes composantes est le même partout.

## Quels sont les inconvénients de ce modèle ?

Le souci du modèle a été exposé dans les paragraphe du dessus: Qui dit dépendances
dit responsabilité de leur gestion, et non des moindres. En effet, l'enjeu du design
est de modéliser une infrastructure qui ne devienne pas par la suite impossible
à maintenir.

C'est pour cette raison que je limiterai probablement la chaine de dépendance d'une suite
de composantes à un nombre que je déterminerai lorsque j'aurais un minimum expérimenté
le design.

## Comment gérer les composantes ?

En terme de gestion, j'ai décidé qu'il serait utile de développer une bibliothèque
entièrement dédiée à la gestion des composantes d'Hina. Le fonctionnement est simple:
L'interface est utilisable sur terminal, sous forme textuelle. L'application
est composée de commandes principales servant à construire, créer, détruire, modifier
des composantes, et ces commandes principales viennent avec des flags secondaires
pour paramétrer le tout.

Sur Hina, une composante est une bibliothèque. Un dossier dans lequel se trouve
des fichiers source, des headers, des tests unitaires, des exemples, etc. Schématiquement,
on représente le dossier d'une composante de la sorte:

```
comp/
├── docs/
│   └── follow_up.md
├── examples/
├── include/
│   ├── comp/
│   └── detail/
├── src/
├── tests/
├── src/
│
├── LICENCE
├── README.md
└── xmake.lua
```

| noeud                   | utilité                                                                  |
|:------------------------|:-------------------------------------------------------------------------|
| **`docs`**              | Les documents liés à l'architecture et le développement de la composante |
| **`examples`**          | Divers exemples d'utilisation de l'API                                   |
| **`include/comp`**      | Les fichiers en-tête de l'API                                            |
| **`include/detail`**    | Les fichiers en-tête des détails d'implémentation de l'API               |
| **`src`**               | Les fichiers source de l'API                                             |
| **`LICENCE`**           | Les termes de la licence de la composante                                |
| **`README.md`**         | La description générale de la composante                                 |
| **`xmake.lua`**         | Le fichier de configuration pour la construction de la composante        |
| **`docs/follow_up.md`** | Le fichier de suivi du développement de la composante (cf. en bas)       |

Le fichier `docs/follow_up.md` contient le suivi de développement de la composante.
* Ce suivi est défini par
  * Des notes de changement datés (style changelog)
  * Des observations:
    * Ce qui a été fait. Ce que ça a apporté.
    * Ce qui pourrait être fait. Ce que ça apporterait.
  * La description de fonctionnalités achevées

## Conclusion

Finalement, le système de composantes est un modèle de design qui permettrait 
de mieux responsabiliser les outils qui composent Hina, mais aussi de modulariser
l'infrastructure. Ce modèle comporte certaines failles, telles que le risque
de construire une chaine de dépendance entre plusieurs composantes, qui réduit
l'efficacité du développement d'Hina. Chaque composante est décrite par un dossier
organisé de la même façon qu'une bibliothèque traditionelle en C++, qu'on
peut documenter précisément, notamment grâce aux exemples qu'on fournirait et
à la documentation (`docs/follow_up.md`...).

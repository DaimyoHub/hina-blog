# Un système constitué d'un ensemble de composantes

## *Sommaire*

* Qu'est-ce qu'une composante ?
* Pourquoi ce modèle plutôt qu'un autre ?
* Quels sont les avantages du modèle ?
* Quels sont les inconvénients du modèle ?
* Comment gérer les composantes ?

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

> *Dernière modification le 26 octobre 2021.*

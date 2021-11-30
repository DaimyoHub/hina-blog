## Gestion mémoire

### La page

L'utilisateur travaille sur une page mémoire, cela implique le fait que le seul
lien qu'il partage directement avec le système de gestion de mémoire est l'interface
d'une page. Une page est une partie allouée de mémoire concrètement définie 
par le périphérique mémoire, dédiée à un processus.

### Le périphérique mémoire

Le périphérique mémoire forme la base du système de gestion mémoire. Il peut être
vu comme un simple composant qui représenterait la mémoire de travail (cf. architecture
de Von Neumann), qui n'a pas d'utilité abstraite. Ce périphérique doit, de la même
façon que tout les autres périphériques, respecter la spécification de l'ID
d'un périphérique. Il est lié à un allocateur.

### L'allocateur

Pour lier le noyau du système au système de gestion mémoire, il faut utiliser
l'allocateur. Le nom donné à ce composant n'est pas assez explicite: l'allocateur
en lui même ne se charge pas d'allouer de la mémoire dans le périphérique, mais
il permet de communiquer avec le noyau pour gérer toute requête qu'on lui confie.
Par exemple, si un utilisateur a besoin de plus de mémoire pour le bon fonctionnement
de son processus, le besoin est envoyé au périphérique, qui le relaiera à l'allocateur.
Celui-ci se charge de récupérer toutes les informations lui permettant de
composer une requête complète (ID du périphérique, nature de la requête, besoin,
etc.), et il l'envoie à la section de gestion des requêtes située dans le noyau.

Voici, ci-dessous, un schéma qui permet de représenter ce processus du transfer
d'une requête:
* Si l'utilisateur doit effectuer une action liée à la gestion mémoire
  * Il appelle une API système:
    * Cet appel sera transmis au périphérique mémoire
    * Le périphérique mémoire relaie le besoin à l'allocateur
    * L'allocateur formule puis envoie la requête au centre de gestion des
    requêtes.

## Interface et gestionnaire du noyau

### Le gestionnaire de requêtes

Cette composante permet à tous les périphériques de communiquer avec le noyau.
Cela veut dire que chaque action effectuée par le machine passe forcément par ce
gestionnaire, sans exception. Pour effectuer une requête, un composant doit
respecter la spécification du format d'une requête. La requête sera en premier
temps stockée dans une file, puis elle sera gérée tel que voulu par les développeurs
du pilote. Un résultat sera renvoyé à l'envoyeur de la requête, il contiendra 
l'essentiel des informations utiles à propos du traitement de la requête.

### L'interface d'un périphérique

Tous les périphérique de cette machine sont basés sur cette interface. Ils ont
donc tous une chose en commun, un ID défini tel qu'il contient:
  * Une *classe de périphérique*, par exemple, un périphérique mémoire est
  associé à la class `vm::DeviceKind::MEMORY`.
  * Un identifiant numérique unique pour identifier chaque périphérique d'une
  classe donnée. (note: cet identifiant est défini sur [1;16])
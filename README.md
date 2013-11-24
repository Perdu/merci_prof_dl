merci_prof_dl
=============

Simple Perl script for downloading videos of the “Merci, Professeur !” french TV show. If you don't speak French, you're probably not interested in this script.

--

Ce petit script Perl permet de télécharger toutes les vidéos de l'émission « Merci, professeur ! » depuis le site de TV5 monde [1]. Il est fonctionnel à la date du 24/11/2013. Si ce n'est plus le cas à l'heure où vous lisez ces lignes, n'hésitez pas à m'envoyer un email.

Le site de TV5 monde renvoie une vidéo aléatoirement quelle que soit la valeur du paramètre « episode ». Il ne semble pas y avoir de moyen simple d'y remédier, à part en parsant le code JavaScript. Le script actuel boucle donc un grand nombre de fois en passant les vidéos déjà téléchargées, en espérant réussir à obtenir toutes les vidéos au final.

[1] : http://www.tv5.org/cms/chaine-francophone/lf/Merci-Professeur/p-17081-Vision.htm?episode=0

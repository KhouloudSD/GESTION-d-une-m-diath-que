/* donner les fims sortis entre 1970 et 2000*/

select a.matricule , a.prenom 
from FILM f, ARTISTE a 
where f.matricule_real=a.matricule and f.annee >1970 and f.annee<2000;

/* donner les ARTSITES QUI ONT LE MEME NOM ET PRENOM*/

select DISTINCT a1.nom, a1.prenom from artiste a1
where exists (select * from artiste a2 
where a1.nom =a2.nom and a1.prenom = a2.prenom 
and a1.matricule <> a2.matricule );

/* donner l'auteur le plus vieux*/

Select a1.nom , a1.prenom, a1.date_naissance from auteur a1
where a1.date_naissance < all (select a2.date_naissance from auteur a2 where a1.matricule <> a2.matricule );

/* donner les fims qui n'ont pas utilisé aucun album*/

select distinct f.code_f ,f.titre 
from film_album l,film f, album b
where l.codealb=b.codealb and f.code_f not in (select a.code_f from film_album a);


/* Supprimer les adherents francais*/

delete from adherent 
where upper (nationalite)='FRANCE';

/* afficher pour chaque auteur  le titre de son dernier livre publié */

select a1.matricule ,a1.nom, a1.prenom , l.titre
from auteur a1, livre l
where a1.matricule =l.matricule_aut
and l.date_sortie = (select max(date_sortie) from livre ll
where l.matricule_aut = ll.matricule_aut )
order by matricule_aut;

/*donner le nombre des œuvres pour chaque rayon*/

select r.num_rayon ,count(*) "nombre oeuvres" from rayon r , oeuvre o, etagere e
where e.num_etagere =o.id_etagere and r.num_rayon= e.num_rayon 
group by r.num_rayon;


/* afficher code film, titre_film ,titre_album, nom_musicien qui ont adapté la musique d’un album solo*/

select f.code_f , album.titre , f.titre , musicien.prenom 
from album_solo a , film f, film_album f1 , album , musicien 
where a.codealb = f1.codealb and f.code_f = f1.code_f and album.codealb =a.codealb and musicien.matricule_mus = a.matricule_mus;


/*afficher par categorie tout les oeuvres presents dans les etageres  du rayon numero ‘1’*/

select e.categorie , o.code
from etagere e ,oeuvre o
where e.num_rayon =1 and o.id_etagere = e.num_etagere ;

/*afficher les numéro d’etageres ,qui ont un nombre d’oeuvres dépassant la moyenne des nombre  d’œuvres et leurs catégorie =’DRAMA ’*/

select num_etagere , categorie 
from etagere 
where upper (categorie) = 'DRAMA' and nbre_oeuvre >(select (avg(nbre_oeuvre)) from etagere );

/*donner la moyenne des ages des adherents qui sont intressés par Comedy */

select avg (to_char (sysdate,'yyyy') - to_char(date_naiss_ad , 'yyyy')) la_moyenne_des_ages
from adherent a , emprunt e , oeuvre o , etagere ee
where a.matricule_adh = e.matricule_adh and e.code=o.code and ee.num_etagere = o.id_etagere and upper (ee.categorie)='COMEDY';

/*afficher l’historique d’emprunt de l’adherent ayant la matrucule num 15*/

select a.matricule_adh , e.code , e.Date_debut, e.date_fin
from emprunt e , adherent a
where a.matricule_adh=15 and e.matricule_adh =a.matricule_adh;



/*supprimer les adherents dont leurs abonnements sont expirées (date_fin adh> date_aujourd’hui=20/06/2021 )*/

delete from adherent 
where to_char(sysdate)>to_char(date_finadh);

/* supprimer les adherents de  nationalite russe*/

delete from adherent 
where upper(nationalite)='RUSSIA';


/*ajouter dans la table film_adapte_livre le film “48 minutes pour vivre”*/

insert into film_adapte_livre select 
f.code_f , l.code from livre l , film f 
where f.titre ='48 minutes pour vivre' and l.titre ='48 minutes pour vivre';







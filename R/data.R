#' Données de trajets vélos - Vacances de Toussaint 2025
#'
#' Jeu de données issu de Nantes Métropole contenant les comptages
#' de vélos enregistrés pendant les vacances de Toussaint 2025.
#'
#' @format Un data.frame avec les colonnes suivantes :
#' \describe{
#'   \item{Jour}{Date du comptage}
#'   \item{Jour de la semaine}{Numéro du jour (1 = lundi, 7 = dimanche)}
#'   \item{Boucle de comptage}{Nom de la boucle}
#'   \item{Numéro de boucle}{Identifiant numérique de la boucle}
#'   \item{Total}{Nombre total de passages}
#'   \item{Probabilité de présence d'anomalies}{Indicateur d'anomalie}
#' }
#' @source \url{https://data.nantesmetropole.fr}
"df_velo"

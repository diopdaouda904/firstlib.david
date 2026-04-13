utils::globalVariables(c(
  "Jour de la semaine",
  "Total",
  "Numéro de boucle",
  "Probabilité de présence d'anomalies",
  "Boucle de comptage",
  "Jour",
  "jour",
  "trajets"
))



#' Filtrer les anomalies du jeu de données
#'
#' @param trajet Un data.frame contenant les trajets vélos
#' @return Un data.frame sans les lignes anormales
#' @export
#' @importFrom dplyr filter
filtre_anomalie <- function(trajet){
  trajet |>
    filter(
      is.na(`Probabilité de présence d'anomalies`),
      Total < 10000,
      Total > 0
    )
}

#' Compter le nombre total de trajets
#'
#' @param trajet Un data.frame contenant les trajets vélos
#' @return Un entier : la somme de tous les passages
#' @export
#' @importFrom dplyr pull
compter_nombre_trajets <- function(trajet){
  trajet |>
    pull(Total) |>
    sum()
}

#' Compter le nombre de boucles distinctes
#'
#' @param trajet Un data.frame contenant les trajets vélos
#' @return Un entier : le nombre de boucles uniques
#' @export
#' @importFrom dplyr pull n_distinct
compter_nombre_boucle <- function(trajet){
  trajet |>
    pull(`Numéro de boucle`) |>
    n_distinct()
}

#' Trouver la paire boucle-jour avec le maximum de passages
#'
#' @param trajet Un data.frame contenant les trajets vélos
#' @return Un data.frame avec la boucle, le jour, le total et les moyennes
#' @export
#' @importFrom dplyr filter slice_max select pull
trouver_trajet_max <- function(trajet){
  trajet_max <- trajet |>
    filtre_anomalie() |>
    slice_max(Total) |>
    select(`Boucle de comptage`, Jour, Total)

  trajet_max$moyenne_jour_identique <- trajet |>
    filter(Jour == trajet_max$Jour) |>
    pull(Total) |>
    mean()

  trajet_max$moyenne_boucle_identique <- trajet |>
    filter(`Boucle de comptage` == trajet_max$`Boucle de comptage`) |>
    pull(Total) |>
    mean()

  return(trajet_max)
}

#' Calculer la distribution des trajets par jour de la semaine
#'
#' @param trajet Un data.frame contenant les trajets vélos
#' @return Un data.frame avec le nombre de trajets par jour de la semaine
#' @export
#' @importFrom dplyr count
calcul_distribution_semaine <- function(trajet){
  trajet |>
    count(`Jour de la semaine`, wt = Total, sort = TRUE, name = "trajets")
}

#' Visualiser la distribution des trajets par jour de la semaine
#'
#' @param trajet Un data.frame contenant les trajets vélos
#' @return Un graphique ggplot2 en colonnes
#' @export
#' @importFrom ggplot2 ggplot aes geom_col
#' @importFrom forcats fct_recode
#' @importFrom dplyr mutate
plot_distribution_semaine <- function(trajet) {
  trajet_weekday <- trajet |>
    filtre_anomalie() |>
    calcul_distribution_semaine() |>
    mutate(
      jour = fct_recode(
        factor(`Jour de la semaine`),
        "lundi"    = "1",
        "mardi"    = "2",
        "mercredi" = "3",
        "jeudi"    = "4",
        "vendredi" = "5",
        "samedi"   = "6",
        "dimanche" = "7"
      )
    )

  ggplot(trajet_weekday) +
    aes(x = jour, y = trajets) +
    geom_col()
}

test_that("filtre_anomalie supprime bien les anomalies", {

  # On crée un mini jeu de données de test
  df_test <- data.frame(
    `Probabilité de présence d'anomalies` = c(NA, "Forte", NA, "Faible"),
    Total = c(100, 200, 150, 50),
    check.names = FALSE
  )

  resultat <- filtre_anomalie(df_test)

  # Le résultat doit avoir seulement 2 lignes (les NA)
  expect_equal(nrow(resultat), 2)

  # Le résultat doit être un data.frame
  expect_true(is.data.frame(resultat))
})

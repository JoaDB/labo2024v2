require("rlang")

# workflow pesronalizado que voy a correr future 202107
PARAM <- "src/workflows/517_workflow_f202107_conc.r"


envg <- env()

envg$EXPENV <- list()
envg$EXPENV$repo_dir <- "~/labo2024v2/"

#------------------------------------------------------------------------------

correr_workflow <- function( wf_scriptname )
{
  dir.create( "~/tmp", showWarnings = FALSE)
  setwd("~/tmp" )

  # creo el script que corre el experimento
  comando <- paste0( 
      "#!/bin/bash\n", 
      "source /home/$USER/.venv/bin/activate\n",
      "nice -n 15 Rscript --vanilla ",
      envg$EXPENV$repo_dir,
      wf_scriptname,
      "   ",
      wf_scriptname,
     "\n",
     "deactivate\n"
    )
  cat( comando, file="run.sh" )

  Sys.chmod( "run.sh", mode = "744", use_umask = TRUE)

  system( "./run.sh" )
}
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

Tiempo_inicio <- Sys.time()

# aqui efectivamente llamo al workflow
correr_workflow( PARAM )

#Fin del worfklow
Tiempo_fin <- Sys.time()
Tiempo_total <- difftime(Tiempo_fin, Tiempo_inicio, units = "hours")
cat("\n-----------------------------------------------------------------------------------")
cat("\n            Expw_julio_3 EV_03 metodo drifting: estandarizar Y TODOS LAG ON")
cat("\n-----------------------------------------------------------------------------------")
cat("\n           El tiempo total fue de", round(Tiempo_total, 2), "horas\n")
cat("\n-----------------------------------------------------------------------------------")


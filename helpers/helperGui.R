loadFile <- function(opcion){
	rutaArchivo <- tclvalue(tkgetOpenFile())
	if(validateFile(rutaArchivo, 1)){
		tclvalue(txtNombreArchivo) <- archivo
		tclvalue(txtEstadoCarga) <- "Archivo cargado"
		tkconfigure(b.ivi, state="normal")
		tkconfigure(b.alfa, state="normal")
	}
}
loadFileA <- function(opcion){
	rutaArchivo <- tclvalue(tkgetOpenFile())
	if(validateFile(rutaArchivo, 2)){
		tclvalue(txtNombreArchivoA) <- archivo
		tclvalue(txtEstadoCargaA) <- "Archivo cargado"
		if(nchar(tclvalue(txtNombreArchivoB)) > 0){
			tkconfigure(b.beta, state="normal")
		}
	}
}
loadFileB <- function(opcion){
	rutaArchivo <- tclvalue(tkgetOpenFile())
	if(validateFile(rutaArchivo, 3)){
		tclvalue(txtNombreArchivoB) <- archivo
		tclvalue(txtEstadoCargaB) <- "Archivo cargado"
		if(nchar(tclvalue(txtNombreArchivoA)) > 0){
			tkconfigure(b.beta, state="normal")
		}
	}
}
validateFile <- function(rutaArchivo, opcion){
	switch(opcion,
		"1"={
			validacion = FALSE
			tclvalue(txtEstadoCarga) <- "Cargando archivo..."
			if(!nchar(rutaArchivo)){
				tclvalue(txtEstadoCarga) <- "Archivo no seleccionado"
				tkmessageBox(title = "Advertencia", message = "No seleccionó ningún archivo. \nPor favor intente de nuevo!", icon = "warning", type = "ok") 
				return(validacion)
			} else {
				archivo <<- basename(rutaArchivo)
				extensiones <- grepl("*xlsx|xls", archivo)
				if(extensiones){			
					tkconfigure(b.load, state="disabled")			
					ecosystem <<- readFile(rutaArchivo)
					tkmessageBox(title = "Mensaje", message = "El archivo fue cargado exitosamente!", type = "ok")
					validacion = TRUE
					return(validacion)
				} else{
					tclvalue(txtEstadoCarga) <- "Archivo no compatible"
					rutaArchivo <- NULL
					tkmessageBox(title = "Error", message = "Tipo de archivo no válido.\nIntente de nuevo con un archivo Excel!", icon = "error", type = "ok")  
					return(validacion)
				}
			}
		},
		"2"={
			validacion = FALSE
			tclvalue(txtEstadoCargaA) <- "Cargando archivo..."
			if(!nchar(rutaArchivo)){
				tclvalue(txtEstadoCargaA) <- "Archivo no seleccionado"
				tkmessageBox(title = "Advertencia", message = "No seleccionó ningún archivo. \nPor favor intente de nuevo!", icon = "warning", type = "ok") 
				return(validacion)
			} else {
				archivo <<- basename(rutaArchivo)
				extensiones <- grepl("*xlsx|xls", archivo)
				if(extensiones){			
					tkconfigure(b.loadA, state="disabled")			
					ecosystemA <<- readFile(rutaArchivo)
					tkmessageBox(title = "Mensaje", message = "El archivo fue cargado exitosamente!", type = "ok")
					validacion = TRUE
					return(validacion)
				} else{
					tclvalue(txtEstadoCargaA) <- "Archivo no compatible"
					rutaArchivo <- NULL
					tkmessageBox(title = "Error", message = "Tipo de archivo no válido.\nIntente de nuevo con un archivo Excel!", icon = "error", type = "ok")  
					return(validacion)
				}
			}
		},
		"3"={
			validacion = FALSE
			tclvalue(txtEstadoCargaB) <- "Cargando archivo..."
			if(!nchar(rutaArchivo)){
				tclvalue(txtEstadoCargaB) <- "Archivo no seleccionado"
				tkmessageBox(title = "Advertencia", message = "No seleccionó ningún archivo. \nPor favor intente de nuevo!", icon = "warning", type = "ok") 
				return(validacion)
			} else {
				archivo <<- basename(rutaArchivo)
				extensiones <- grepl("*xlsx|xls", archivo)
				if(extensiones){			
					tkconfigure(b.loadB, state="disabled")			
					ecosystemB <<- readFile(rutaArchivo)
					tkmessageBox(title = "Mensaje", message = "El archivo fue cargado exitosamente!", type = "ok")
					validacion = TRUE
					return(validacion)
				} else{
					tclvalue(txtEstadoCargaB) <- "Archivo no compatible"
					rutaArchivo <- NULL
					tkmessageBox(title = "Error", message = "Tipo de archivo no válido.\nIntente de nuevo con un archivo Excel!", icon = "error", type = "ok")  
					return(validacion)
				}
			}
		}
	)
}
readFile <- function(filePath){
	ecosystem <- read.xls(filePath, perl = 'C:\\Perl64\\bin\\perl.exe');
  return(ecosystem);
}
saveAs <- function(){
  savenFile <- tclvalue(tkgetSaveFile())
  if(!nchar(savenFile)){
    tkmessageBox(title = "Advertencia", message = "No guardó el archivo.\nPor favor intente de nuevo!", icon = "warning", type = "ok") 
  } else {  	
  	fileName <- paste(savenFile, ".xlsx", sep="")
    save.xlsx(fileName, Iv)
    tkmessageBox(title = "Mensaje", message = "El archivo ha sido\nguardado exitosamente!", type = "ok")
  }
}
saveAll <- function(){
	fileName <- paste("data/resultados", archivo, sep=" ")
	save.xlsx(fileName, Iv, Alfa)
	tkmessageBox(title = "Mensaje", message = "El archivo ha sido\nguardado exitosamente!", type = "ok")
}
saveAlfa <- function(){
	fileName <- paste("data/resultados alfa", archivo, sep=" ")	
	save.xlsx(fileName, Alfa)
	tkmessageBox(title = "Mensaje", message = "El archivo ha sido\nguardado exitosamente!", type = "ok")
}
saveBeta <- function(){
	fileName <- "data/resultados beta.xlsx"
	save.xlsx(fileName, Beta)
	tkmessageBox(title = "Mensaje", message = "El archivo ha sido\nguardado exitosamente!", type = "ok")
}
save.xlsx <- function (file, ...){  
  objects <- list(...)
  fargs <- as.list(match.call(expand.dots = TRUE))
  objnames <- as.character(fargs)[-c(1, 2)]
  nobjects <- length(objects)
  path <- file  
  for (i in 1:nobjects) {
    if (i == 1)
      write.xlsx(objects[[i]], path, sheetName = objnames[i])
    else write.xlsx(objects[[i]], path, sheetName = objnames[i],
                    append = TRUE)
  }
  print(paste("El archivo", file, "tiene", nobjects, "subhojas."))
}
calculateIv <- function(){
	Iv <<- getIv(ecosystem)
	tkmessageBox(title = "Mensaje", message = "El Índice de Valor de Importancia\nha sido calculado exitosamente!", type = "ok")
	if(exists("b.exportAll")){
		tkconfigure(b.exportAll, state="normal")
	}	

	iviProcessed <- trim(Iv)
  iviMatrix <- c(colnames(iviProcessed))
  dim(iviMatrix) <- c(1,ncol(Iv))
  iviMatrix <- trim(iviMatrix)
  iviMatrix <- rbind(iviMatrix, as.matrix(iviProcessed))
  dim(iviMatrix) <- c(nrow(Iv)+1,ncol(Iv))
  iviMatrix <- trim(iviMatrix)
  tclarray <- tclArray()
  for (i in (0:nrow(Iv)))
    for (j in (0:ncol(Iv)-1))
      tclarray[[i,j]] <- iviMatrix[i+1,j+1]

	suppressMessages(tclRequire("Tktable"))
  ventanaResultadosIVI<-tktoplevel(parent=ventanaIvAlfa)
  titulo <- paste("Resultados IVI", archivo, sep=" ")
  tkwm.title(ventanaResultadosIVI, titulo)
  topMenu <- tkmenu(ventanaResultadosIVI)
  tkconfigure(ventanaResultadosIVI, menu = topMenu)
  fileMenu <- tkmenu(topMenu, tearoff = FALSE)
  tkadd(fileMenu, "command", label = "Guardar como...", command = function() saveAs())
  tkadd(fileMenu, "command", label = "Salir", command = function() tkdestroy(ventanaResultadosIVI))
  tkadd(topMenu, "cascade", label = "Archivo", menu = fileMenu)
  table <- tkwidget(ventanaResultadosIVI, "table", variable = tclarray, rows = (nrow(Iv)+1),
                    cols = 8, titlerows = 1, width="20",
                    xscrollcommand = function(...) tkset(xscr,...), yscrollcommand=function(...) tkset(yscr,...))
  
  xscr <-tkscrollbar(ventanaResultadosIVI, orient="horizontal", command = function(...) tkxview(table,...))
  yscr <- tkscrollbar(ventanaResultadosIVI, command = function(...) tkyview(table,...))
  
  tkgrid(table, yscr)
  tkgrid.configure(yscr,sticky="nsw")
  tkconfigure(table, variable = tclarray, background = "white", selectmode = "extended")
  tkfocus(ventanaResultadosIVI)
}
calculateAlfa <- function(){
	Alfa <<- getAlfa(ecosystem)
	tkmessageBox(title = "Mensaje", message = "Los índices de Alfadiversidad\nhan sido calculados exitosamente!", type = "ok")

	l.margalef 		<- tklabel(frameLower, width="36", text="Margalef (Dmg):", font=style.label)
	e.margalef 		<- tklabel(frameLower, text=Alfa$Margalef, font=style.label)

	l.menhinick 	<- tklabel(frameLower, width="37", text="Menhinick (Dmn):", font=style.label)
	e.menhinick 	<- tklabel(frameLower, text=Alfa$Menhinick, font=style.label)

	l.shannonH 		<- tklabel(frameLower, width="40", text="Shannon-Wiener (H´):", font=style.label)
	e.shannonH 		<- tklabel(frameLower, text=Alfa$ShannonH, font=style.label)

	l.shannonE 		<- tklabel(frameLower, width="40", text="Shannon-Wiener (E):", font=style.label)
	e.shannonE 		<- tklabel(frameLower, text=Alfa$ShannonE, font=style.label)

	l.simpson 		<- tklabel(frameLower, width="33", text="Simpson (D):", font=style.label)
	e.simpson 		<- tklabel(frameLower, text=Alfa$Simpson, font=style.label)

	l.bergerParker 	<- tklabel(frameLower, width="35", text="Berger Parker:", font=style.label)
	e.bergerParker 	<- tklabel(frameLower, text=Alfa$BergerParker, font=style.label)

	b.exportAll 		<<- tkbutton(frameLower, width="16", text="Exportar Todo", state="disabled", command=saveAll)
	b.exportAlfa		<- tkbutton(frameLower, width="16", text="Exportar Alfa", command=saveAlfa)

	if(exists("Iv")){
		tkconfigure(b.exportAll, state="normal")
	}

	tkgrid(l.margalef, e.margalef)
	tkgrid(l.menhinick, e.menhinick)
	tkgrid(l.shannonH, e.shannonH)
	tkgrid(l.shannonE, e.shannonE)
	tkgrid(l.simpson, e.simpson)
	tkgrid(l.bergerParker, e.bergerParker)
	tkgrid.configure(e.margalef, e.menhinick, 
									e.shannonH, e.shannonE, 
									e.simpson, e.bergerParker,
									sticky="w")
	tkgrid.configure(l.margalef, l.menhinick, 
									l.shannonH, l.shannonE, 
									l.simpson, l.bergerParker,
									sticky="e")
	tkgrid(tklabel(frameLower,text="    "))
	tkgrid(b.exportAll, b.exportAlfa)
	tkgrid.configure(b.exportAll, b.exportAlfa, sticky="n")
}
calculateBeta <- function(){
	Beta <<- getBeta(ecosystemA, ecosystemB)
	tkmessageBox(title = "Mensaje", message = "Los índices de Betadiversidad\nhan sido calculados exitosamente!", type = "ok")

	l.jaccard 		<- tklabel(frameLowerBeta, width="36", text="Jaccard (Cj):", font=style.label)
	e.jaccard 		<- tklabel(frameLowerBeta, text=Beta$JaccardCj, font=style.label)

	l.sorensenCs 	<- tklabel(frameLowerBeta, width="37", text="Sorensen (Cs):", font=style.label)
	e.sorensenCs 	<- tklabel(frameLowerBeta, text=Beta$SorensenCs, font=style.label)

	l.sorensenCn 		<- tklabel(frameLowerBeta, width="40", text="Sorensen (Cn):", font=style.label)
	e.sorensenCn 		<- tklabel(frameLowerBeta, text=Beta$SorensenCn, font=style.label)

	l.morisitaHorn		<- tklabel(frameLowerBeta, width="40", text="Morisita-Horn (CmH):", font=style.label)
	e.morisitaHorn 		<- tklabel(frameLowerBeta, text=Beta$MorisitaHornCmH, font=style.label)

	l.DJK 		<- tklabel(frameLowerBeta, width="40", text="Distancia Euclidiana Absoluta (Djk):", font=style.label)
	e.DJK 		<- tklabel(frameLowerBeta, text=Beta$DJK, font=style.label)

	l.djk 		<- tklabel(frameLowerBeta, width="40", text="Distancia Euclidiana Promedio (djk):", font=style.label)
	e.djk 		<- tklabel(frameLowerBeta, text=Beta$djk, font=style.label)

	l.PD 	<- tklabel(frameLowerBeta, width="40", text="Porcentaje de disimilitud (PD):", font=style.label)
	e.PD 	<- tklabel(frameLowerBeta, text=Beta$PD, font=style.label)

	l.PR 	<- tklabel(frameLowerBeta, width="40", text="Porcentaje de remotidad (PR):", font=style.label)
	e.PR 	<- tklabel(frameLowerBeta, text=Beta$PR, font=style.label)

	b.exportBeta		<- tkbutton(frameLowerBeta, width="16", text="Exportar Beta", command=saveBeta)

	tkgrid(l.jaccard, e.jaccard)
	tkgrid(l.sorensenCs, e.sorensenCs)
	tkgrid(l.sorensenCn, e.sorensenCn)
	tkgrid(l.morisitaHorn, e.morisitaHorn)
	tkgrid(l.DJK, e.DJK)
	tkgrid(l.djk, e.djk)
	tkgrid(l.PD, e.PD)
	tkgrid(l.PR, e.PR)
	tkgrid.configure(e.jaccard, e.sorensenCs, 
									e.sorensenCn, e.morisitaHorn, 
									e.DJK, e.djk,
									e.PD, e.PR,
									sticky="w")
	tkgrid.configure(l.jaccard, l.sorensenCs, 
									l.sorensenCn, l.morisitaHorn, 
									l.DJK, l.djk,
									l.PD, l.PR,
									sticky="e")
	tkgrid(tklabel(frameLowerBeta,text="    "))
	tkgrid(b.exportBeta, columnspan=3)
}
guiMainMenu <- function(){
	ventanaMenuPrincipal <<- tktoplevel(bg="white", width=500, height=450)
	tkwm.title(ventanaMenuPrincipal, "vDiversity")
	tkwm.maxsize(ventanaMenuPrincipal, 500, 450)
	tkwm.minsize(ventanaMenuPrincipal, 500, 450)
	barraMenu <- tkmenu(ventanaMenuPrincipal)
	tkconfigure(ventanaMenuPrincipal, menu=barraMenu)
	menuArchivo <- tkmenu(barraMenu, tearoff=FALSE)
	menuComuna <- tkmenu(barraMenu, tearoff=FALSE)
	menuAyuda <- tkmenu(barraMenu, tearoff=FALSE)

	# Menú Archivo
	tkadd(
		menuArchivo, "command",
		label = "Salir",
		command = function() tkdestroy(ventanaMenuPrincipal)
	)
	tkadd(
		barraMenu, "cascade",
		label = "Archivo",
		menu = menuArchivo
	)
	# Menú Índices	
	tkadd(
		menuComuna, "command",
		label = "IVI & Alfa",
		command = function() guiIvAlfa()
	)
	tkadd(
		menuComuna, "command",
		label = "Beta",
		command = function() guiBeta()
	)
	tkadd(
		barraMenu, "cascade",
		label = "Índices",
		menu = menuComuna
	)
	# Menú Ayuda
	tkadd(
		menuAyuda, "command",
		label = "Acerca de vDiversity",
		command = function() guiAbout()
	)
	tkadd(
		barraMenu, "cascade",
		label = "Ayuda",
		menu = menuAyuda
	)
	tkfocus(ventanaMenuPrincipal)
}
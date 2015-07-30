guiAbout <- function(){
	ventanaAcercaDe <- tktoplevel(parent=ventanaMenuPrincipal, bg="white", width=315, height=485)
	tkwm.title(ventanaAcercaDe, "Acerca de vDiversity")
	tkwm.maxsize(ventanaAcercaDe, 315, 485)
	tkwm.minsize(ventanaAcercaDe, 315, 485)

	estiloTitulo 	<- tkfont.create(family="times", size=22, weight="bold")
	estiloVersionAutor <- tkfont.create(family="times", size=10, slant="italic")
	estiloRepositorio <- tkfont.create(family="times", size=10, weight="bold", slant="italic")
	estiloCuerpo <- tkfont.create(family="times", size=10, slant="italic")

	lblTitulo		<- tklabel(ventanaAcercaDe, bg="white", text="vDiversity", font=estiloTitulo)
	lblVersion 	<- tklabel(ventanaAcercaDe, bg="white", text="Versión 0.4.9 - 2015 MIT License", font=estiloVersionAutor)
	lblRepositorio <- tklabel(ventanaAcercaDe, bg="white", text="https://github.com/paleox/GInfo", font=estiloRepositorio)
	lblAutor1 		<- tklabel(ventanaAcercaDe, bg="white", text="Andrés Felipe Santos - andresfesantos@gmail.com", font=estiloVersionAutor)
	lblAutor2 		<- tklabel(ventanaAcercaDe, bg="white", text="Fernando Fernández - fmendez@ut.edu.co", font=estiloVersionAutor)
	lblAutor3 		<- tklabel(ventanaAcercaDe, bg="white", text="Luis Adalberto Pérez - laperezv@ut.edu.co", font=estiloVersionAutor)						
	cuerpo <- "La caracterización de comunidades vegetales requiere\ndel procesamiento de bases de datos con diferente\nnúmero de variables. Por lo general cada investigador\nrealiza sus procesamientos en hojas de cálculo o\nprogramas estadísticos, pero no se cuentan con\nherramientasfáciles de manejar para los diferentes\nprofesionales que hacen uso de esta información\nEste proyecto contempló el desarrollo de una aplicación\nen el lenguaje de programación R que abarca el cálculo\ndel índice de valor de importancia, los índices de alfa y\nbeta diversidad entre otros. El cálculo de los índices se\nrealiza en tamaños de parcelas y transectos variados y\nmás comúnmente usados en Colombia, para probar su\nfuncionalidad se utilizaron como casos de estudio\nparcelas establecidas en el municipio de Buenaventura\ny algunos municipios del Tolima."
	lblCuerpo 	<- tklabel(ventanaAcercaDe, bg="white", text=cuerpo, font=estiloCuerpo)

	btnAceptar <- tkbutton(
		ventanaAcercaDe,
		text="Aceptar",
		command = function() tkdestroy(ventanaAcercaDe)
	)

	tkgrid(lblTitulo)
	tkgrid(tklabel(ventanaAcercaDe,bg="white", text="    "))
	tkgrid(lblVersion, sticky="w")
	tkgrid(lblRepositorio, sticky="w")
	tkgrid(lblAutor1, sticky="w")
	tkgrid(lblAutor2, sticky="w")
	tkgrid(lblAutor3, sticky="w")
	tkgrid(tklabel(ventanaAcercaDe,bg="white", text="    "))
	tkgrid(lblCuerpo)
	tkgrid(tklabel(ventanaAcercaDe,bg="white", text="    "))
	tkgrid(btnAceptar)
	tkfocus(ventanaAcercaDe)
}
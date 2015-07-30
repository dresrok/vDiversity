guiIvAlfa <- function(){
	ventanaIvAlfa <<- tktoplevel(parent=ventanaMenuPrincipal, width=475, height=400)
	tkwm.title(ventanaIvAlfa, "Ivi & Alfa")
	tkwm.maxsize(ventanaIvAlfa, 475, 400)
	tkwm.minsize(ventanaIvAlfa, 475, 400)

	frameOverall 		<- tkframe(ventanaIvAlfa)
	frameUpper 			<- tkframe(frameOverall,relief="groove",borderwidth=2)
	frameMiddle 		<- tkframe(frameOverall,relief="groove",borderwidth=0)
	frameLower 			<<- tkframe(frameOverall,relief="groove",borderwidth=2)

	heading 				<- tklabel(ventanaIvAlfa, text="Formulario de cálculo del Ivi y Alfadiversidad", font=style.header)

	txtEstadoCarga 	<<- tclVar("Archivo no cargado")

	l.file 					<- tklabel(frameUpper, width="22", text="Seleccione el archivo:", font=style.label)
	b.load 					<<- tkbutton(frameUpper, width="16", text="Cargar", command=loadFile)
	l.state 				<- tklabel(frameUpper, width="20", text=tclvalue(txtEstadoCarga), font=style.label)
	tkconfigure(l.state, textvariable=txtEstadoCarga)	

	l.fileName 			<- tklabel(frameUpper, width="20", text="Nombre del archivo:", font=style.label)
	txtNombreArchivo <<- tclVar("")
	e.fileName 			<- tkentry(frameUpper, textvariable=txtNombreArchivo, state="readonly")

	b.ivi 					<<- tkbutton(frameUpper, width="16", text="Calcular IVI", state="disabled", command=calculateIv)
	b.alfa 					<<- tkbutton(frameUpper, width="16", text="Calcular Alfa", state="disabled", command=calculateAlfa)

	tkgrid(heading, columnspan=3)
	tkgrid(tklabel(ventanaIvAlfa,text="    "))
	tkgrid(l.file, b.load, l.state)
	tkgrid(l.fileName, e.fileName)
	tkgrid.configure(b.load, l.state, l.fileName, sticky="w")
	tkgrid.configure(l.file, l.fileName, sticky="e")
	tkgrid(tklabel(frameUpper,text="    "))
	tkgrid(tklabel(frameMiddle,text="    "))

	tkgrid(b.ivi, b.alfa)
	tkgrid.configure(b.ivi, b.alfa, sticky="n")

	tkgrid(frameUpper)	
	tkgrid(frameMiddle)
	tkgrid(frameLower)
	tkgrid(frameOverall)	
	
	tkfocus(ventanaIvAlfa)
}
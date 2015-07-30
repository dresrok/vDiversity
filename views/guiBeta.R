guiBeta <- function(){
	ventanaBeta <<- tktoplevel(parent=ventanaMenuPrincipal, width=475, height=470)
	tkwm.title(ventanaBeta, "Beta")
	tkwm.maxsize(ventanaBeta, 475, 470)
	tkwm.minsize(ventanaBeta, 475, 470)

	frameOverall 		<- tkframe(ventanaBeta)
	frameUpper 			<- tkframe(frameOverall,relief="groove",borderwidth=2)
	frameMiddle 		<- tkframe(frameOverall,relief="groove",borderwidth=0)
	frameLowerBeta 	<<- tkframe(frameOverall,relief="groove",borderwidth=2)

	heading 				<- tklabel(ventanaBeta, text="Formulario de cálculo de Índices de Betadiversidad", font=style.header)

	txtEstadoCargaA 	<<- tclVar("Archivo no cargado")
	txtEstadoCargaB 	<<- tclVar("Archivo no cargado")

	l.fileA 				<- tklabel(frameUpper, width="22", text="Ecosistema A:", font=style.label)
	b.loadA 				<<- tkbutton(frameUpper, width="16", text="Cargar", command=loadFileA)
	l.stateA 				<- tklabel(frameUpper, width="20", text=tclvalue(txtEstadoCargaA), font=style.label)
	tkconfigure(l.stateA, textvariable=txtEstadoCargaA)

	l.fileB					<- tklabel(frameUpper, width="22", text="Ecosistema B:", font=style.label)
	b.loadB					<<- tkbutton(frameUpper, width="16", text="Cargar", command=loadFileB)
	l.stateB 				<- tklabel(frameUpper, width="20", text=tclvalue(txtEstadoCargaB), font=style.label)
	tkconfigure(l.stateB, textvariable=txtEstadoCargaB)

	l.fileNameA 			<- tklabel(frameUpper, width="20", text="Archivo ecosistema A:", font=style.label)
	txtNombreArchivoA <<- tclVar("")
	e.fileNameA 			<- tkentry(frameUpper, textvariable=txtNombreArchivoA, state="readonly")

	l.fileNameB 			<- tklabel(frameUpper, width="20", text="Archivo ecosistema B:", font=style.label)
	txtNombreArchivoB <<- tclVar("")
	e.fileNameB 			<- tkentry(frameUpper, textvariable=txtNombreArchivoB, state="readonly")

	b.beta 					<<- tkbutton(frameUpper, width="16", text="Calcular Beta", state="disabled", command=calculateBeta)	

	tkgrid(heading, columnspan=3)
	tkgrid(tklabel(ventanaBeta,text="    "))
	tkgrid(l.fileA, b.loadA, l.stateA)
	tkgrid(l.fileNameA, e.fileNameA)
	tkgrid(l.fileB, b.loadB, l.stateB)	
	tkgrid(l.fileNameB, e.fileNameB)
	tkgrid.configure(l.stateA, l.fileNameA, sticky="w")
	tkgrid.configure(l.stateB, l.fileNameB, sticky="w")
	tkgrid(tklabel(frameUpper,text="    "))
	tkgrid(b.beta, columnspan=3)
	tkgrid(tklabel(frameMiddle,text="    "))

	tkgrid(frameUpper)	
	tkgrid(frameMiddle)
	tkgrid(frameLowerBeta)
	tkgrid(frameOverall)
	
	tkfocus(ventanaBeta)
}
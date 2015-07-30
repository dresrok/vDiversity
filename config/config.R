setEnvironment <- function(){
	suppressMessages(require(gdata))
	suppressMessages(require(tcltk))
	require(xlsx, quietly = TRUE)
	setVars()
}
setVars <- function(){
	style.header 		<<- tkfont.create(size=12, weight="bold")
	style.label 		<<- tkfont.create(size=10, weight="bold")
}
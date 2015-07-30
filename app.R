source('~/R/vDiversity/config/config.R')
source('~/R/vDiversity/helpers/helperDiversity.R')
source('~/R/vDiversity/helpers/helperGui.R', encoding = 'UTF-8')
source('~/R/vDiversity/views/guiMainMenu.R', encoding = 'UTF-8')
source('~/R/vDiversity/views/guiIvAlfa.R', encoding = 'UTF-8')
source('~/R/vDiversity/views/guiBeta.R', encoding = 'UTF-8')
source('~/R/vDiversity/views/guiAbout.R', encoding = 'UTF-8')

main <- function(){
	setEnvironment()
	guiMainMenu()
}

main()
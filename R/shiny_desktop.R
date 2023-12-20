library(janitor)


get_setup<-function(
  repo_url="https://github.com/gustavo234guimaraes/teste_shiny_desktop.git",
  app_name="Consistência Analíticos",
  dest.dir=getwd(),
  ico=get_ico(),
  dependencies=c("shiny","tidyverse")
){
  
  ### Sourcing get R
  source("https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/getR")
  
  ## Getting clean_name for dirs and files
  clean_name<-make_clean_names(app_name,use_make_names = F)
  
  ##Create bat file for setup
  batfile<-paste0(dest.dir,ifelse(substring(dest.dir,first = nchar(dest.dir))=='/','','/'),
                  'setup_',clean_name,".bat")
  file.create(batfile)
  write("chcp 65001",batfile)
  ##Create directory for final app in final destination
  dirapp<-paste0(gsub("\\\\","/",Sys.getenv("userprofile")),'/AppData/Local/Programs/appsGG/',clean_name)
  
  getR(file=batfile)
  
  commands<-c(
    "source('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/tkProgressBar')",
    "source('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/download_repo')",
    "source('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/change_app')",
    "source('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/write_runapp')",
    "source('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/install_withProgress')",
    "source('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/write_runappB')",
    "source('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/set_shortcut')",
    "ico=tempfile(fileext = '.ico')",
    "download.file('https://raw.githubusercontent.com/gustavo234guimaraes/teste_shiny_desktop/main/brilhante.ico',destfile = ico)",
    paste0("pb<-tk.ProgressBar(label='Downloading files from repository',icon=ico,title='Installing ",app_name,"')"),
    "pb$up(0.2)",
    paste("dir.create('",dirapp,"',recursive=T)"),
    paste0("setwd('",dirapp,"')"),
    paste0("download_repo('",repo_url,"')"),
    "setTkProgressBar(pb,0.4,label='Configuring run file')",
    "file.create('runapp.R')",
    paste0("write_runapp('",dirapp,"')"),
    "setTkProgressBar(pb,0.6,label='Configuring bat file')",
    "file.create('runapp.bat')",
    "write_runappB()",
    "download.file('https://raw.githubusercontent.com/gustavo234guimaraes/shiny_desktop/main/launch.vbs','launch.vbs')",
    "write_launch(getwd())",
    "setTkProgressBar(pb,0.8,label='Configuring app')",
    paste0("set_shortcut('",app_name,"','",dirapp,"','",ico,"')"),
    "setTkProgressBar(pb,1,label='Installing dependencies')",
    "pb2<-tk.ProgressBar.into(.win=pb$getWin(),initial = 0)",
    paste0("install_withProgress(pb=pb2,pkgs=c('",paste0(dependencies,collapse = "','"),"'))"),
    "pb$button()"
  )
  
  write(paste0("%R% -e ",'"',paste0(commands,collapse = ";"),'"'),batfile,append = T)
  return(TRUE)
}
get_setup(ico="brilhante.ico")






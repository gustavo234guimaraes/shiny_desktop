


use_favicon<-function(ico_url="teste.ico"){
  if(tools::file_ext(ico_url)%in%c("png","ico")==FALSE){
    stop("The ico extension must be .png or .ico")
  }
  
  if(tools::file_ext(ico_url)=="ico"){
    return(
      
      tags$head(
        tags$link(
          rel='shortcut icon',
          href=ico_url,
          type='image/x-icon'
        )
      )
      
    )
  }else{
    return(
      
      tags$head(
        tags$link(
          rel='icon',
          href=ico_url,
          type='image/png'
        )
      )
      
    )
  }
  
}

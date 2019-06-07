#' Mapa del Cantábrico y Galicia para una o varias especies y también combina campañas superponiéndolas
#' para dar una idea de la distribución de la especie. Si es muy escasa se puede pasar a representar
#' solo a puntos de aparición
#'
#' Crea un mapa para la campaña Demersales con información para la especie solicitada en la campañas solicitadas, para varias campañas ver también {\link{maphist}}
#' @param gr Grupo de la especie: 1 peces, 2 crustáceos 3 moluscos 4 equinodermos 5 invertebrados 6 desechos y otros, 9 escoge todos los orgánicos pero excluye desechos
#' @param esp Código de la especie númerico o caracter con tres espacios. 999 para todas las especies del grupo
#' @param camps Campañas a representar en el mapa, con MapCant1 se puede sacar más de  un año concreto (XX): Demersales "NXX", Porcupine "PXX", Arsa primavera "1XX" y Arsa otoño "2XX"
#' @param dns Elige el origen de las bases de datos: solo para el Cantábrico "Cant"
#' @param color Color de los puntos que representan las abundancias
#' @param puntos si TRUE en el mapa muestra sólo los puntos en los que aparece la especie, si false son puntos proporcionales al tamaño de la abundancia
#' @param bw si T los colores salen en blanco, si F en lightblue
#' @param add Si T añade los puntos al gráfico actual, si F dibuja uno nuevo
#' @param escala Varia el tamaño de los puntos
#' @param ti Si T añade titulo al mapa, el nombre de la especie en latín
#' @param ind Si "p" representa los datos de biomasa, si "n" representa los datos de abundancia
#' @param ceros Si T representa los ceros con cruces +, si F no representa lances sin captura
#' @seealso {\link{maphist}}
#' @family mapas base
#' @family Galicia Cantabrico
#' @export
MapCant<- function(gr,esp,camps,dns="Cant",color=1,puntos=FALSE,bw=FALSE,add=FALSE,escala=NA,ti=FALSE,ind="p",ceros=F,es=T,places=T){
  options(scipen=2)
  esp<-format(esp,width=3,justify="r")
  ch1<-DBI::dbConnect(odbc::odbc(), dns)
  ndat<-length(camps)
  absp<-NULL
  for (i in 1:ndat) {
    tempdumb<-DBI::dbReadTable(ch1, paste0("FAUNA",camps[i])) #RODBC::sqlQuery(ch1,paste("select lance,peso_gr,numero from FAUNA",camps[1]," where grupo='",gr,"' and esp='",esp,"'",sep=""))
    tempdumb<-tempdumb[tempdumb$GRUPO==gr & tempdumb$ESP==esp,]
    tempdumb<-select(tempdumb,lance=LANCE,peso_gr=PESO_GR,numero=NUMERO)
    if (!is.null(tempdumb)) absp<-rbind(absp,cbind(tempdumb,camp=camps[i]))
  }
  absp$lance<-as.integer(absp$lance)
  if (ti) {
		ident<-DBI::dbReadTable(ch1, paste0("CAMP",camps[1]))$IDENT
		ident<-stringr::word(ident)
		}
  lan<-datlan.camp(camps,dns,redux=TRUE,incl2=TRUE,incl0=FALSE)
	lan<-lan[,c("camp","lance","lat","long")]
	names(lan)<-c("camp","lan","lat","long")
	mm<-merge(lan,absp,by.x=c("camp","lan"),by.y=c("camp","lance"),all.x=TRUE)
	mm$peso<-mm$peso_gr/1000
	if (!identical(as.numeric(which(is.na(mm[,5]))),numeric(0))) {
		mm[which(is.na(mm[,5])),5]<-0
		mm[which(is.na(mm[,6])),6]<-0
		}
  if (ind=="p") peso=T else peso=F
	mi<-ifelse(peso,5,6)
	milab<-ifelse(peso,"kg/lance","N/lance")
	if (peso) {maxmm<-max(mm[,mi])}
	else {
		maxmm<-max(mm[,mi])*1000
		mm[,mi]<-mm[,mi]*1000
		}
	if ((signif(maxmm,1)/(10^nchar(maxmm)))>.7) {maxml<-10^nchar(maxmm)}
	else {
		if ((signif(maxmm,1)/(10^nchar(maxmm)))>.28) {
			maxml<-5*10^(nchar(maxmm)-1)}
		else {maxml<-10^(nchar(maxmm)-1)}
		}
	if (!add) {
	  MapNort(lwdl=1,places=places,es=es,bw=bw)
	}
	if (ti) {
	  especie<-buscaesp(gr,esp)
	}
	else {especie=NULL}
	if (puntos) {
	  MapNort(lwdl=1)
	  points(lat~long,mm,subset=peso>0,cex=1,pch=21,bg="red")
	  #legend("bottomleft",legend = paste0("Presencia en campañas ",camptoyear(camps[1]),"-",camptoyear(camps[length(camps)])),inset=c(.22,.05),bg="white",box.col = "white",text.font=2,cex=.8)
	  title(buscaesp(gr,esp,"e"),font.main=2,line=1.5)
	  mtext(buscaesp(gr,esp,"l"),font=4,cex=.8,line=1.5,adj=0)
	  mtext(paste0("Años: ",camptoyear(camps[1]),"-",camptoyear(camps[length(camps)])),3,cex=.8,font=2,line=1.5,adj=1)
	  }
	else {
	if (is.na(escala)) {
			points(lat~long,mm,subset=peso>0,cex=sqrt(mm[,mi]*7/maxmm),lwd=1,col=color,pch=21,bg=ifelse(bw,"darkgrey","lightblue"))
			if (ceros) {points(lat~long,mm,subset=peso==0,cex=0.8,pch="+",col=color)}
		if (!add) {
		  leyenda<-cbind(rep(-4,55),seq(42.2,43,by=.2),maxml*c(.05,.1,.25,.5,1))
		  points(leyenda[,1],leyenda[,2],cex=sqrt(leyenda[,3]*7/maxmm),lwd=1,col=1,bg=ifelse(bw,"darkgrey","lightblue"))
		  polygon(c(-4.3,-4.3,-3.3,-3.3,-4.3),c(41.9,43.15,43.15,41.9,41.9),col="white")
		  text(leyenda[,1]+.4,leyenda[,2]+.02,labels=round(leyenda[,3]/1000,2),cex=.9,adj=c(.5,.5))
		  text(-3.8,42.05,milab,font=2)
		  for (i in 1:5) {points(leyenda[i,1],leyenda[i,2],cex=sqrt(leyenda[i,3]*7/maxmm),lwd=1,col=1,pch=21,bg=ifelse(bw,"darkgrey","lightblue"))}
		  }
		}
	else {
		for (i in 1:length(mm[,1])) {
			points(lat~long,mm,subset=peso>0,cex=sqrt(mm[,mi]/escala),lwd=1,col=color,pch=21,bg=ifelse(bw,"darkgrey","lightblue"))
			if (ceros) {points(lat~long,mm,subset=peso>0,cex=0.8,pch="+",col=color)}
			if (!add) {
				leyenda<-cbind(rep(-4.6,5),seq(42.2,43,by=.2),maxml*c(.05,.1,.25,.5,1))
				polygon(c(-4.85,-4.85,-4,-4,-4.85),c(41.9,43.15,43.15,41.9,41.9),col="white")
				text(leyenda[,1]+.3,leyenda[,2]+.02,labels=round(leyenda[,3]/1000,2),cex=.9,adj=c(.5,.5))
				text(-4.43,42.05,milab,font=2)
				for (i in 1:5) {points(leyenda[i,1],leyenda[i,2],cex=sqrt(leyenda[i,3]/escala),lwd=1,pch=21,bg=ifelse(bw,"darkgrey","lightblue"))}
				}
			}
		}
	if (ti) {
		years<-camptoyear(camps)
	  title(ident,sub=especie,cex.main=1.3,font.sub=4,cex.sub=1,line=2)
		title(paste0(years[1],"-",years[length(years)]),font.main=2,cex.main=1,line=1.1)
		#	text(-2.7,42.45,"kg/lance")
		}
	}
	}

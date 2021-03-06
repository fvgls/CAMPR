% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MapNort.R
\name{MapNort}
\alias{MapNort}
\title{Mapa del Cantábrico y Galicia}
\usage{
MapNort(
  lwdl = 0.5,
  cuadr = FALSE,
  cuadrcol = gray(0.4),
  cuadrMSFD = FALSE,
  ICESrect = FALSE,
  ICESrectcol = gray(0.2),
  ICESlab = FALSE,
  ICESlabcex = 0.7,
  leg = F,
  bw = TRUE,
  es = FALSE,
  ax = TRUE,
  strat = FALSE,
  places = FALSE,
  FU = NA,
  country = F,
  xlims = c(-10.25, -1.4),
  ylims = c(41.82, 44.48)
)
}
\arguments{
\item{lwdl}{Ancho de las líneas del mapa}

\item{cuadr}{Si T saca las cuadrículas de 5x5 millas naúticas}

\item{cuadrcol}{Color para los recuadros de muestreo}

\item{cuadrMSFD}{Si T dibuja caudrícula de 10 millas naúticas utilizada para la evaluación de la estrategia marina (MSFD)}

\item{ICESrect}{Si T saca los rectangulos ices de 1 grado de latitud por medio de longitud}

\item{ICESlab}{Si T incluye las etiquetas de los rectángulos ICES}

\item{ICESlabcex}{tamaño del ICESlab en cex, .5 por defecto subirlo si se quiere más grande}

\item{leg}{Si T saca una leyenda con los estratos batimétricos que salen de color o con grises en bw}

\item{bw}{si T mapa con tierra en gris, si F tierra en color}

\item{es}{si T saca textos en español, si F en inglés}

\item{ax}{Si T saca los ejes x e y}

\item{strat}{Si marca los sectores geográficos (los batimetricos salen con las líneas correspondientes, y en colores con leg=T)}

\item{places}{Si T saca ciudades y puntos geográficos de referencia}

\item{FU}{pinta una o varias unidades funcionales, a elegir FU26, FU25 o FU31 con grueso lwd=2 y color rojo}

\item{country}{si T saca el país}

\item{xlims}{Define los limites longitudinales del mapa, por defecto -10.25 y -1.4 oeste}

\item{ylims}{Define los limites longitudinales del mapa, por defecto 41.82 y 44.48 norte}

\item{icesrectcol}{Color para los rectángulos ICES}

\item{dens}{si mayor de 0 las superficies de los estratos tienen patrones de líneas}
}
\value{
Saca en pantalla el mapa y es utilizada por otras funciones
}
\description{
Función auxiliar para sacar el mapa de la campaña Demersales
}
\seealso{
{\link{MapCant}}, {\link{mapporco}}

Other mapas base: 
\code{\link{MapArsa}()},
\code{\link{MapCant}()},
\code{\link{MapIberia}()},
\code{\link{MapMedit}()},
\code{\link{MapPorc}()},
\code{\link{mapporco}()}

Other Galicia Cantabrico: 
\code{\link{MapCant}()}
}
\concept{Galicia Cantabrico}
\concept{mapas base}

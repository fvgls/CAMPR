% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MeanMaxL.camps.r
\name{MeanMaxL.camps}
\alias{MeanMaxL.camps}
\title{Talla máxima media del grupo de especies elegidas}
\usage{
MeanMaxL.camps(gr = 1, esps, camps, dns = "Cant", lmax = NA,
  incl2 = FALSE, excl.sect = NA, plot = TRUE, es = TRUE,
  ti = FALSE)
}
\arguments{
\item{gr}{Grupo de la especie: 1 peces, 2 crustáceos 3 moluscos (4 equinodermos 5 invertebrados habitualmente no medidos)}

\item{esps}{Código de las especies seleccionadas. Si se mezclan grupos hay que introducir el mismo numero de elementos en gr que en esps}

\item{camps}{Campaña de las que se extraen los datos: Demersales NYY, Porcupine PYY, Arsa primavera 1YY y Arsa otoño 2YY, Medits MYY}

\item{dns}{Elige el origen de las bases de datos: Porcupine "Pnew", Cantábrico "Cant, Golfo de Cádiz "Arsa", Medits: "Medi"}

\item{lmax}{Debe incluir los datos de Linf de cada una de las especies en el campo esps. Si se usa NA en un caso utiliza la talla máxima de la campaña camp, se puede dar para cada esps dejando un NA en las especies que se quiera utilizar el maximo de la campaña, o en general}

\item{incl2}{Si F no tiene en cuenta los lances especiales, si T si los tiene en cuenta, pero da problemas por que no puede calcular las abundancias estratificadas}

\item{excl.sect}{Excluye los sectores y estratos en cuestion, si NA usa toda el area.}

\item{plot}{Si T saca un gráfico con la evolución de la talla media máxima a lo largo de la serie historica}

\item{es}{Si T saca las etiquetas y titulos en español, Si F en inglés}

\item{ti}{Si F no saca titulo en el gráfico, si T lo saca por defecto Talla media maxima, se puede utilizar para sacar el titulo que se quiera: p.ej: "Talla media maxima elasmobranquios"}
}
\value{
Devuelve una lista con un data.frame datos por especie: gr, esps, unid, n, lmax y el valor del indice la talla maxima media ponderada a la abundancia
}
\description{
Debería de usar especies de un ecotipo similar (mismo gr) y sobre todo medidas en la misma unidad, en caso contrario da un error y avisa del problema.
Para cada especie calcula la abundancia estratificada y la talla máxima, con ello hace una media ponderada, la salida
}
\examples{
MeanMaxL.camps(gr=1,c(50,42,43,44,45),Nsh[7:27],"Cant")
}
\seealso{
{\link{MeanMaxL.camp}}
}

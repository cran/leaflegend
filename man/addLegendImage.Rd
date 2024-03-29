% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/legend.R
\name{addLegendImage}
\alias{addLegendImage}
\title{Add a Legend with Images}
\usage{
addLegendImage(
  map,
  images,
  labels,
  title = NULL,
  labelStyle = "font-size: 24px; vertical-align: middle;",
  orientation = c("vertical", "horizontal"),
  width = 20,
  height = 20,
  group = NULL,
  className = "info legend leaflet-control",
  ...
)
}
\arguments{
\item{map}{a map widget object created from 'leaflet'}

\item{images}{path to the image file}

\item{labels}{labels for each image}

\item{title}{the legend title, pass in HTML to style}

\item{labelStyle}{character string of style argument for HTML text}

\item{orientation}{stack the legend items vertically or horizontally}

\item{width}{in pixels}

\item{height}{in pixels}

\item{group}{group name of a leaflet layer group}

\item{className}{extra CSS class to append to the control, space separated}

\item{...}{arguments to pass to \link[leaflet]{addControl}}
}
\value{
an object from \link[leaflet]{addControl}
}
\description{
Creates a legend with images that are embedded into a 'leaflet' map so that
images do not need to be packaged when saving a 'leaflet' map as HTML. Full
control over the label and title style. The 'leaflet' map is passed through
and the output is a control so that legend is fully integrated with other
functionalities.
}
\examples{

library(leaflet)
data(quakes)

quakes1 <- quakes[1:10,]

colors <- c('blue', 'red', 'yellow', 'green', 'orange', 'purple')
i <- as.integer(cut(quakes$mag, breaks = quantile(quakes$mag, seq(0,1,1/6)),
                    include.lowest = TRUE))
leafImg <- system.file(sprintf('img/leaf-\%s.png', colors),
                       package = 'leaflegend')
leafIcons <- icons(
  iconUrl = leafImg[i],
  iconWidth = 133/236 * 50, iconHeight = 50
)
leaflet(data = quakes) \%>\% addTiles() \%>\%
  addMarkers(~long, ~lat, icon = leafIcons) \%>\%
  addLegendImage(images = leafImg,
                 labels = colors,
                 width = 133/236 * 50,
                 height = 50,
                 orientation = 'vertical',
                 title = htmltools::tags$div('Leaf',
                                             style = 'font-size: 24px;
                                             text-align: center;'),
                 position = 'topright')

 # use raster images with size encodings
 height <- sizeNumeric(quakes$depth, baseSize = 40)
 width <- height * 38 / 95
 symbols <- icons(
   iconUrl = leafImg[4],
   iconWidth = width,
   iconHeight = height)
 probs <- c(.2, .4, .6, .8)
 leaflet(quakes) \%>\%
   addTiles() \%>\%
   addMarkers(icon = symbols,
              lat = ~lat, lng = ~long) \%>\%
   addLegendImage(
     images = rep(leafImg[4], 4),
     labels = round(quantile(height, probs = probs), 0),
     width = quantile(height, probs = probs) * 38 / 95,
     height = quantile(height, probs = probs),
     title = htmltools::tags$div(
       'Leaf',
       style = 'font-size: 24px; text-align: center; margin-bottom: 5px;'),
     position = 'topright', orientation = 'vertical')
}

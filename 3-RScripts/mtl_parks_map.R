source("3-RScripts/packages.R")

parks <- read_sf('1-Input/shapefile/Espace_Vert.shp')

bb <- c(xmin = -74.0788,
        ymin = 45.3414,
        xmax = -73.3894,
        ymax = 45.7224)

mtl <- opq(bb) %>%
  add_osm_feature(key = 'place', value = 'island') %>%
  osmdata_sf()
multipolys <- mtl$osm_multipolygons
polys <- mtl$osm_polygons
polys <- st_cast(polys, "MULTIPOLYGON")
allpolys <- st_as_sf(st_union(polys, multipolys))

water <- opq(bb) %>%
  add_osm_feature(key = 'natural', value = 'water') %>%
  osmdata_sf()
# We only want multipolygons (aka large rivers)
mpols <- water$osm_multipolygons
mpols <- st_cast(mpols, "MULTIPOLYGON")
mpols <- st_as_sf(st_make_valid(mpols))


bbi <- st_bbox(st_buffer(allpolys, 2.5))


map <- ggplot() +
  # add island layer to figure
  geom_sf(fill = '#ceb99b', data = allpolys) +
  # add water layer to figure
  geom_sf(fill = '#99acc3', data = mpols) +
  # add plot layer to figure
  geom_sf(size = 2, data = parks) +
  # explicitly state where you want boundaries of your figure using line above
  coord_sf(xlim = c(bbi['xmin'], bbi['xmax']),
           ylim = c(bbi['ymin'], bbi['ymax'])) +
  theme(panel.border = element_rect(linewidth = 1, fill = NA),
        panel.background = element_rect(fill = '#ddc48d'),
        panel.grid = element_line(color = '#73776F', linewidth = 0.2),
        axis.text = element_text(size = 11, color = 'black'),
        axis.title = element_blank(),
        plot.background = element_rect(fill = NA, colour = NA),
        legend.position = 'top')
map

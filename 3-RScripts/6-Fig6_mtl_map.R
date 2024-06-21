source("3-RScripts/packages.R")




# Data --------------------------------------------------------------------

# your parks
df <- data.frame(parks = c("McGill Bird Observatory", "Technoparc", "Bois-de-Liesse"),
                    latitude = c(45.43067,45.4758, 45.5012),
                    longitude = c(-73.93859, -73.7568, -73.7674))
df_spatial <- st_as_sf(df,coords = c("longitude", "latitude"), crs = 4326)

# download data for the island of Montreal for the background of the map
# choose the coordinates of the region you are interested in (got these from Google Maps)
bb <- c(xmin = -74.0788,
        ymin = 45.3414,
        xmax = -73.3894,
        ymax = 45.7224)

# Use the coordinates you extracted to download all the things called islands within that range
# Download island boundary in bbox
mtl <- opq(bb) %>%
  add_osm_feature(key = 'place', value = 'island') %>%
  osmdata_sf() # returns an object with points, lines, polygons, and multipolygons
# Grab multipolygons (large islands)
multipolys <- mtl$osm_multipolygons
# Grab polygons (small islands)
polys <- mtl$osm_polygons
polys <- st_cast(polys, "MULTIPOLYGON")
# Combine geometries and cast as sf
allpolys <- st_as_sf(st_union(polys, multipolys))

# Now use the coordinates you extracted to download all the things called water within that range
water <- opq(bb) %>%
  add_osm_feature(key = 'natural', value = 'water') %>%
  osmdata_sf()
# We only want multipolygons (aka large rivers)
mpols <- water$osm_multipolygons
mpols <- st_cast(mpols, "MULTIPOLYGON")
mpols <- st_as_sf(st_make_valid(mpols))


# Montreal plot -----------------------------------------------------------

# make the coordinates of your plot a little bit larger than the exact boundaries of all the polygons you extracted
# (you don't want the edge of your plot to be touching the border of the island of Montreal)
bbi <- st_bbox(st_buffer(allpolys, 2.5))


map <- ggplot() +
  # add island layer to figure
  geom_sf(fill = '#ceb99b', data = allpolys) +
  # add water layer to figure
  geom_sf(fill = '#99acc3', data = mpols) +
  # add plot layer to figure
  geom_sf(size = 2, data = df_spatial) +
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


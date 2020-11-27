:: This .bat file needs to be inside of the directory with necessary files (gadm36_SVN.gpkg, N45E014.hgt, etc,)
:: In order to generate the for the processing needed dem_merge.tif file, run the line below:
:: gdal_merge -o dem_merge.tif N45E014.hgt n45_e013_1arc_v3.tif
ogr2ogr -f "ESRI Shapefile" extracted_layers gadm36_SVN.gpkg 
ogr2ogr -sql "SELECT * FROM gadm36_SVN_2 WHERE NAME_2 = 'Izola'" -f "ESRI Shapefile" izola.shp extracted_layers/gadm36_SVN_2.dbf 
ogrinfo izola.shp -so
gdalwarp -dstnodata -9999 -t_srs EPSG:32632 -cutline izola.shp -crop_to_cutline dem_merge.tif cropped_dem_merge.tif 
gdaldem slope cropped_dem_merge.tif slope_cropped_dem_merge.tif 
gdaldem hillshade cropped_dem_merge.tif hillshade_cropped_dem_merge.tif
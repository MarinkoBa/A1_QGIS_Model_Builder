#### Aufgabe 2.1: Informationsgewinnung mit `gdalinfo`
##### `$ gdalinfo n45_e013_1arc_v3.tif`:
1. EPSG: 4326 (WGS84)
2. Driver: GTiff/GeoTIFF
3. räumliche Aufösung: (0.000277777777778 x 0.000277777777778), Angaben in Grad

##### `$ gdalinfo N45E014.hgt`:
1. EPSG: 4326 (WGS84)
2. Driver: SRTMHGT/SRTMHGT File Format
3. räumliche Aufösung: (0.000277777777778 x 0.000277777777778), Angaben in Grad

#### Aufgabe 2.2: Erstellen eines Rastermosaiks
1. `$ gdal_merge -o dem_merge.tif N45E014.hgt n45_e013_1arc_v3.tif`
2. `$ gdal_translate N45E014.hgt N45E014.tif`
`$ gdalbuildvrt dem_buildvrt.vrt N45E014.tif n45_e013_1arc_v3.tif`
3. a) Die beiden Befehle generieren unterschiedliche Dateiformate. In Aufgabe 2.2.2 wurde durch den Befehl `$ gdal_merge` aus einer .tif- sowie einer .hgt-Datei ein GeoTIFF – also eine Art Bildformat – erstellt, da dies durch den Outputnamen so vorgeben wurde. Da diese Funktion auf einem Python-Skript basiert, musste zunächst der Befehl `$ py3_env` in die Shell eingegeben werden.
Im Gegensatz dazu werden mit dem Command `$ gdalbuildvrt` nicht nur zwei Rasterdatensätze miteinander verschmolzen, wie es bei `$ gdal_merge` der Fall ist, sondern es wird ein virtuelles Raster - eine VRT-Datei (ausgeschriebene Form: GDAL Virtual Format) - produziert, also eine Datei, die sich vom Dateiformat der Inputs unterscheidet. Letztere müssen zudem das gleiche Dateiformat vorweisen, so dass die .hgt-Datei für Aufgabe 2.2.2 zunächst mittels `$ gdal_translate` in ein GeoTIFF umgewandelt wurde. 
VRT-Dateien basieren auf XML-Datenstrukturen (Holl 2011). Dabei werden die Dateien textuell gespeichert, so dass man - anders als bei .tif-Dateien - nicht ohne ein GIS das abgebildete Raster betrachten kann.
Auffallend ist, dass ein Größenunterschied zwischen den beiden Outputs besteht: Das GeoTIFF ist 49,4 MB groß, das VRT hingegen nur 1,83 KB.
b) Der Vorteil des Commands `$ gdalbuildvrt` könnte darin liegen, dass hierbei eher überprüft wird, ob das Ergebnis bzw. die Operation sinnvoll sind. Von Vorteil ist zudem, dass bei vielen Inputs einfach eine .txt-Datei mit allen Inputs angegeben werden kann. Außerdem ist eine VRT-Datei deutlich kleiner als ein vergleichbares GeoTIFF (vgl. Aufgabenteil a)).  Dieser Größenunterschied, der vermutlich darin begründet liegt, dass bei einem VRT kein Bild, sondern eine Datei, die erst weiterprozessiert werden muss, abgespeichert wird, ist besonders bei geringen Speicherkapazitäten hilfreich. Insgesamt stehen mit `$ gdalbuildvrt` auch mehr Optionen und Parameter (im Vergleich zum Befehl `$ gdal_merge`) zur Verfügung.

##### Quellen
Holl, S. (2011, 5. April): _Virtual Raster Tables und andere GDAL-Tools. Performante und einfache Rasterdatenprozessierung mit dem GDAL-Werkzeugkasten_ [Konferenzbeitrag]. Freie und Open Source Software für Geoinformationssysteme (FOSSGIS), Heidelberg, Deutschland.

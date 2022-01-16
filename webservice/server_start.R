library(plumber)

# Falls die Datei nicht gefunden wird, geben Sie hier den absoluten Pfad zum server.R an.
path = "C:/Users/tomoli/Desktop/Skola/Data Science/DS_Predicting_House_Prices/webservice/server.R"

ws = plumb(path)
ws$run(host="127.0.0.1", port = 8080)



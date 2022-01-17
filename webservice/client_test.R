
# Libraries
library(httr)
library(rjson)

# Beispiel 1

# Ein großes Haus mit vielen Zimmer, im guten Zustand und Grade
test1 = data.frame(bedrooms = 5, bathrooms = 3, sqft_living = 5000, 
                   floors = 2, waterfront = 1, view = 2,
                   grade = 10, sqft_above = 5000, sqft_basement = 0, sqft_living15 = 5010, sqft_lot15 = 10010)

str = toJSON(test1)

# Laut unserem Modell würde es mehr als 2 Millionen kosten
as.double(content(POST("http://127.0.0.1:8080/predict_price", body = str, encode = "json"))[[1]])


# Beispiel 2

# Ein kleiners Haus mit nur 2 Zimmer, im schlechten Zustand und Grade
test2 = data.frame(bedrooms = 2, bathrooms = 1, sqft_living = 1000, 
                   floors = 1, waterfront = 0, view = 0,
                   grade = 3, sqft_above = 1100, sqft_basement = 0, sqft_living15 = 1000, sqft_lot15 = 1100)


str2 = toJSON(test2)

# Laut unserem Modell würde es unter 300 Tausend kosten.
as.double(content(POST("http://127.0.0.1:8080/predict_price", body = str2, encode = "json")))





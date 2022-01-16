
# Libraries
library(httr)
library(rjson)

# Beispiel 1

# Ein großes Haus mit vielen Zimmer, im guten Zustand und Grade, Neubau
test1 = data.frame(bedrooms = 5, bathrooms = 3, sqft_living = 5000, 
               sqft_lot = 10000, floors = 2, waterfront = 1, view = 2, condition = 3, 
               grade = 10, sqft_above = 5000, sqft_basement = 0, yr_built = 2010, 
               yr_renovated = 0, zipcode = 98028)

str = toJSON(test1)

# Laut unserem Modell würde es mehr als 2 Millionen kosten
content(POST("http://127.0.0.1:7234/predict_price", body = str, encode = "json"))

# Beispiel 2

# Ein großes Haus mit nur 2 Zimmer, im schlechten Zustand und Grade, Altbau
test2 = data.frame(bedrooms = 2, bathrooms = 1, sqft_living = 1000, 
                   sqft_lot = 3000, floors = 1, waterfront = 0, view = 0, condition = 1, 
                   grade = 3, sqft_above = 3000, sqft_basement = 0, yr_built = 1945, 
                   yr_renovated = 1792, zipcode = 98028)


str2 = toJSON(test2)

# Laut unserem Modell würde es unter 400 Tausend kosten.
content(POST("http://127.0.0.1:7234/predict_price", body = str2, encode = "json"))





## Expose prediction model as web service

library(rjson)
load("model.rda")

decode <- function(s)
{
    as.data.frame(fromJSON(s$postBody))
}

#* @post /predict_price
#* @json
function(req)
{
    as.character(try(predict(model_r_randomForest, decode(req))))
}

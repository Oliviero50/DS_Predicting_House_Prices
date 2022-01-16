## Expose prediction model as web service

library(rjson)
load("model.rda")
load("scaled_scale.rda")
load("scaled_center.rda")

data = data.frame()

decode_and_scale <- function(s)
{
  data = as.data.frame(fromJSON(s$postBody))
  return(as.data.frame(scale(data, scale = scaled_scale, center = scaled_center )))
}


#* @post /predict_price
#* @json
function(req)
{
    as.character(try(predict(model_r_randomForest, decode_and_scale(req))))
}


devtools::install_github('kaseyriver11/k3d3')
library(k3d3)
library(RJSONIO)
library(stringr)

parent <- c("Car", "Car", "car1", "car1", "car2", "car2")
chil_1 <- c("mar", "mar1", "stan", "stan1", "cran1", "cran2")
size <- c(0,2000,1100,100,300,1000)
test_data <- data.frame(parent, chil_1, size)


makeList_collpsable_tree<-function(x){
  if(ncol(x)>2){
    listSplit<-split(x[-1],x[1],drop=T)
    lapply(names(listSplit),function(y){list(name=y,children=makeList(listSplit[[y]]))})
  }else{
    lapply(seq(nrow(x[1])),function(y){list(name=x[,1][y],Percentage=x[,2][y])})
  }
}

jsonOut_test<-toJSON(list(name="23433",children=makeList_collpsable_tree(test_data)))
jsonOut_final <- str_replace_all(jsonOut_test, "[\r\n]" , "")

CTR(jsonOut_final)


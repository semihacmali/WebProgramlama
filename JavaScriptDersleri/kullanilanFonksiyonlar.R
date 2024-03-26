dfFeature <- function(featureRaster){
  featureDF=getValues(featureRaster)
  featureDF=na.omit(featureDF)
  featureDF=as.data.frame(featureDF)
  return(featureDF)
}

FeatureData <- function(features,train){
  
  #train <- resample(train,features, resample='bilinear')
  pol <- rasterToPolygons(train,dissolve=TRUE)
  train1 <- rasterize(pol,field = names(train),features, updateValue= "NA")
  
  
  predictors<-stack(features,train1)
  names(predictors)[length(names(predictors))]<-"train"
  names(predictors)
  
  value_table=getValues(predictors)
  value_table=na.omit(value_table)
  value_table=as.data.frame(value_table)
  value_table$train <- rounded_value(value_table$train)
  return(value_table)
  
}

####### Egitim seti içerisinde 0 ve 1 dýsýndaki verilerin yuvarlanmasý--------
rounded_value <- function(value) {
  value <- round(value,digits = 0)
  return (value)
}

TrainTestSplit <- function(value_table,type = "Örneklem Oraný",value = 70){
  
  if(type == "Örneklem Oraný"){
    if(value > 95){
      cat("Yuzdelik deger 95'den fazla olamaz....\n
          Isleminiz %95 uzerinden devam edecektir...")
      value = 95
    }
    else if(value < 5){
      cat("%5'dan kucuk olamaz\n
          Isleminiz %5 olarak devam edecektir...")
      value =5
    }
    
    #veri setindeki 0 ve 1 lere bakarak en az olana göre ayarlanmasi
    maxverisayisi <- min(table(value_table$train)) * 2
    #percentvalue kadarinin train gerisinin test verisi olarak ayarlar ve idlerini tutar
    trainsayisi <- as.integer(maxverisayisi*value/100) 
    testsayisi <- maxverisayisi - trainsayisi
    trainid <- createSets(value_table,value_table$train,trainsayisi)
    testid <- createSets(value_table,value_table$train,testsayisi)
    
    #tutulan idler üzerinden train ve test verisini value_table dan ceker
    traindata <- value_table[trainid,]
    testdata <- value_table[testid,]
    #train ve test verisini disa aktarmak icin list'in icine atanir
    traintest <-list(train = traindata,test = testdata)
    return(traintest)
    
    
  }
  else if(type == "Örneklem Sayýsý"){
    #veri setindeki 0 ve 1 lere bakarak en az olana göre ayarlanmasi
    maxverisayisi <- min(table(value_table$train)) * 2
    enfazladeger <- as.integer(maxverisayisi * 0.95)
    enazdeger <- as.integer(maxverisayisi * 0.05)
    if(value > enfazladeger){
      cat("Girmis oldugunuz deger olusturulabilecek veri sayisindan fazladir\n En fazla :",enfazladeger)
      value <- enfazladeger
    }else if(value < enazdeger){
      cat("Girmis oldugunuz deger olusturulabilecek veri sayisindan azdir\n En fazla :",enazdeger)
      value <- enazdeger
    } 
    
    testsayisi <- maxverisayisi - value
    trainid <- createSets(value_table,value_table$train,value)
    testid <- createSets(value_table,value_table$train,testsayisi)
      
    #tutulan idler üzerinden train ve test verisini value_table dan ceker
    traindata <- value_table[trainid,]
    testdata <- value_table[testid,]
    #train ve test verisini disa aktarmak icin list'in icine atanir
    traintest <-list(train = traindata,test = testdata)
    return(traintest)
    
    
  }
  else cat("type olarak 'Örneklem Sayýsý' veya 'Örneklem Oraný' yazmaniz gerekmektedir....\n
           yazmamaniz durumunda %70'e gore train test veri seti olusturulacaktir")
  
}

esitSayidaAlma <- function(value_table){
  
  #veri setindeki 0 ve 1 lere bakarak en az olana göre ayarlanmasi
  maxverisayisi <- min(table(value_table$train)) * 2
  #percentvalue kadarinin train gerisinin test verisi olarak ayarlar ve idlerini tutar
  trainsayisi <- maxverisayisi
  
  trainid <- createSets(value_table,value_table$train,trainsayisi)
  
  
  #tutulan idler üzerinden train ve test verisini value_table dan ceker
  traindata <- value_table[trainid,]
  
  
  return(traindata)
}

### eþit sayýda ve rastgele train ve test üretme -----------
#x = kullanilacak dataframe
#y = dataframe'in icindeki 0 ve 1 lerden olusan train sutunu
#p = islem sonucu olusturulacak veri sayisi
createSets <- function(x, y, p){
  nr <- NROW(x)
  size <- (p) %/% length(unique(y))
  idx <- lapply(split(seq_len(nr), y), function(.x) sample(.x, size))
  unlist(idx)
  
}

normalizationData <- function(r){
  
  r.min = min(r, na.rm = T)
  r.max = max(r, na.rm = T)
  
  r.normal <- ((r - r.min) / (r.max - r.min) )
  return(r.normal)
}

#---- raster Normalization ------
normalizationraster <- function(r){
  
  r.min = cellStats(r, "min")
  r.max = cellStats(r, "max")
  
  r.normal <- ((r - r.min) / (r.max - r.min) )
  return(r.normal)
}

funmanual = function(x){
  a <-min(values(x),na.rm = TRUE)
  b <-max(values(x),na.rm = TRUE)
  kirilmalar <- as.numeric(c(a,((b-a)*0.2),((b-a)*0.4),((b-a)*0.6),((b-a)*0.8),b))
  
  with(x, cut(x,breaks=kirilmalar, na.rm=TRUE),include.lowest=TRUE)
}

# verilen list e icerisinde kalan alanlari 1 digerlerini NA yapar
funmanual1 = function(x,bottomTopList){
  with(x, cut(x,breaks=bottomTopList, na.rm=TRUE),include.lowest=TRUE)
}

#x raster verisi y siniflandirma yapilacak algoritmalar fisher, quantil, equal algoritmalari
funclasifier <- function(x,y = "quantile",n = 5){
  if(y == "fisher"){
    breaks <- classIntervals(sampleRandom(x,1000), n=n,style=y,warnLargeN = FALSE)$brks
    breaks <- unique(breaks)
  }
  #bolme isleminin kesme noktalarinin ayni cikmasina karsin alinan onlem
  else{
    breaks <- classIntervals(values(x), n=n,style=y,warnLargeN = FALSE)$brks
    breaks <- unique(breaks)
  }
  
  
  with(x, cut(x,breaks=breaks, na.rm=TRUE),include.lowest=TRUE)
}

arrayClasifier <- function(x,y = "quantile",n = 5){
  #bolme isleminin kesme noktalarinin ayni cikmasina karsin alinan onlem
  breaks <- classIntervals(x, n=n,style=y,warnLargeN = FALSE)$brks
  breaks <- unique(breaks)
  cut(x, breaks = breaks, labels=F)
}
#HDH path uzantisi ve olan alanlarin olduðu Shape path verilerek bunlari listenin icinde
#1. raster verisinin success Rate i
#2. Shape verinin success Rate i
#olarak geri dondurur
successRateRasterShape <- function(predictraster, olanShp){
  #------ HDH Raster'a cevrilmesi ve islemlerin yapilmasi -----------
  # predictRaster <- raster(rasterPath)
  
  equalRaster <- funclasifier(predictraster,"equal",100)
  summary(equalRaster)
  
  
  
  equalDf <- dfFeature(equalRaster)
  listdata <- as.data.frame(table(equalDf))
  #bos deger gelirse bunu 0 ile doldurur
  df1 <- data.frame("equalDf" = factor(1:100),"Freq" = 0)
  dataF1 <- rbind(df1,listdata)%>%group_by(equalDf)%>%summarise_each(funs(sum))
  
  
  
  #data frame i buyukten kucuge siralar
  dataF1 <- arrange(dataF1,desc(dataF1[[1]]))
  dataF1$sumcount <- NA
  for(i in 1:nrow(dataF1)){
    dataF1$sumcount[[i]] <- sum(dataF1[[2]][1:i])
  }
  dataF1$sumcountnormal <- (normalizationData(dataF1$sumcount) * 100)
  
  
  #---------- Shape dosyanin Raster veri ile extract edilmesi ve islemlerin yapilmasi -----------
  

  
  # 
  # olanRaster <- ShapetoRaster(olanShp, resolation = 30)
  # 
  # summary(olanasd)
  olanasd <- extract(equalRaster,olanShp,cellnumbers=FALSE, na.rm=FALSE, method = 'bilinear')
  listdata <-unlist(olanasd)
  
  # table(values(olanasd))
  # olandf <- dfFeature(olanasd)
  listdata <- as.data.frame(table(listdata))
  #bos deger gelirse bunu 0 ile doldurur
  df1 <- data.frame("listdata" = factor(1:100),"Freq" = 0)
  dataF2 <- rbind(df1,listdata)%>%group_by(listdata)%>%summarise_each(funs(sum))
  
  dataF2 <- arrange(dataF2,desc(dataF2[[1]]))
  dataF2$sumcount <- NA
  for(i in 1:nrow(dataF2)){
    dataF2$sumcount[[i]] <- sum(dataF2[[2]][1:i])
  }
  dataF2$sumcountnormal <- (normalizationData(dataF2$sumcount) * 100)
  data <- list()
  data[[1]] <- dataF1
  data[[2]] <- dataF2
  return(data)
}

# [a,b] icerisine NULL olarak istenilen türe donusturulebilen nestedlist olusturma
createnestedlist <- function(a,b) {
  lapply(1:a, function(x)
    lapply(1:b, function(x) NULL))
}

extentCheck <- function(extentList){
  cevap <- "cevap"
  for(i in 1:length(extentList)){
    for(j in 1:length(extentList)){
      kesisimKontrol <- intersect(extentList[[i]],extentList[[j]])
      if(is.null(kesisimKontrol)){
        msg_box(" Yüklediðini veriler de pencere boyutu (Extent) uyuþumsuzluðu yaþanmýþtýr. 
                \n Lütfen yüklediðiniz verilerin Pencere Boyutlarýnýn (Extent) ayný olmasýna dikkat ediniz. 
                \n Ýþleminiz durdurulmuþtur.")
        cevap <- "no"
        return(cevap)
      }
    }
  }
  return(cevap)
}

resoCheck <- function(resoList){
  cevap <- "cevap"
  for(i in 1:length(resoList)){
    for(j in i:length(resoList)){
      if(!isTRUE(all.equal(resoList[[i]],resoList[[j]]))){
        msg_box(" Yüklediðiniz verilerde çözünürlük uyumsuzlugu bulunmaktadir! 
                \n Ýþleminiz durdurulmustur.")
        cevap <- "no"
        return(cevap)
      }
    }
  }
  return(cevap)
}

CrsCheck <- function(crsCodes){
  result <- "continue"
  projCode <- unlist(lapply(crsCodes, function(x){
    pos1 <- strsplit(x, "+proj=")
    pos2 <- pos1[[1]][length(pos1[[1]])]
    pos3 <- strsplit(pos2, "[ +]")[[1]][1]
  }))
  
  for(i in 1:length(projCode)){
    for(j in i:length(projCode)){
      if(!is.na(projCode[i]) & !is.na(projCode[j]) & !is.null(projCode[i]) & !is.null(projCode)){
        if(projCode[i] != projCode[j]){
          result <- dlg_message(c("Girmiþ olduðunuz verilerde Koordinat verisi (CRS) bulunmamakta veya veriler arasýnda koordinat uyuþumsuzluðu vardýr.", "Devam Etmek Ýstiyor musunuz?"), "okcancel")$res
          if(result == "cancel") return("cancel")
        }
      }else{
        result <- dlg_message(c("Girmiþ olduðunuz verilerde Koordinat verisi (CRS) bulunmamakta veya veriler arasýnda koordinat uyuþumsuzluðu vardýr.", "Devam Etmek Ýstiyor musunuz?"), "okcancel")$res
        if(result == "cancel") return("cancel")
      } 
    }
  }
  if(result != "cancel") return("continue")
  }

##### ----------Shape dosyasinin Rastera cevirme  ------------
ShapetoRaster <- function(konumV, resolation,field = "heyelanTur"){
  RasterF <- raster(extent(konumV))
  res(RasterF) <- resolation
  RasterF <- rasterize(konumV,field = field,RasterF, updateValue= "NA")
  return(RasterF)
}

#----- Raster halde verilen faktor ve egitim verisinin DataFrame formatina cevrilmesi  -------

RastertoDataFrame <- function(featureRaster, trainRaster){
  #verilerin birlestirilebilmesi icin extentlerinin esitlenmesi
  traindf <- resample(trainRaster,featureRaster,resample='bilinear')
  traindf <- stack(featureRaster,traindf)
  #egitim verisinin degisken adinin train olarak atanmasi
  names(traindf)[length(names(traindf))]<-"train"
  
  #degerlerin DataFrame formatina cevrilmesi
  value_table=getValues(traindf)
  value_table=na.omit(value_table)
  value_table=as.data.frame(value_table)
  
  return(value_table)
}

#Verilen dosya uzantisindan dosya türünü bulur
getFileNameExtension <- function (filePath) {
  # remove a path
  splitted    <- strsplit(x=filePath, split='/')[[1]]   
  # or use .Platform$file.sep in stead of '/'
  filePath          <- splitted [length(splitted)]
  ext         <- ''
  splitted    <- strsplit(x=filePath, split='\\.')[[1]]
  l           <-length (splitted)
  if (l > 1 && sum(splitted[1:(l-1)] != ''))  ext <-splitted [l] 
  # the extention must be the suffix of a non-empty name    
  ext
}

to.dendrogram <- function(dfrep,rownum=1,height.increment=0.1){
  
  if(dfrep[rownum,'status'] == -1){
    rval <- list()
    
    attr(rval,"members") <- 1
    attr(rval,"height") <- 0.0
    attr(rval,"label") <- dfrep[rownum,'prediction']
    attr(rval,"leaf") <- TRUE
    
  }else{##note the change "to.dendrogram" and not "to.dendogram"
    left <- to.dendrogram(dfrep,dfrep[rownum,'left daughter'],height.increment)
    right <- to.dendrogram(dfrep,dfrep[rownum,'right daughter'],height.increment)
    rval <- list(left,right)
    
    attr(rval,"members") <- attr(left,"members") + attr(right,"members")
    attr(rval,"height") <- max(attr(left,"height"),attr(right,"height")) + height.increment
    attr(rval,"leaf") <- FALSE
    attr(rval,"edgetext") <- paste(dfrep[rownum,'split var'],"\n<",round(dfrep[rownum,'split point'], digits = 2),"=>", sep = " ")
  }
  
  class(rval) <- "dendrogram"
  
  return(rval)
}

RootMSE <- function(prediction, target){
  sqrt(mean((prediction - target)^2))
}

trainDataControl <- function(train){
  
  degerler <- as.data.frame(names(table(values(train))))
  names(degerler) <- "MevcutDegerler"
  degerler$yenidegeler <- c("yeni deger")
  
  a <- edit(degerler)
  b <- toupper(a[[2]])
  
  
  NADegerler <- which(b == "NA" | is.na(b) | b == "YENI DEGER")
  olanDegerler <- which(b == "1" | b == 1)
  olmayanDegerler <- which(b == "0" | b ==0)
  Nalar <- as.numeric(levels(a[[1]])[NADegerler])
  olanlar <- as.numeric(levels(a[[1]])[olanDegerler])
  olmayanlar <- as.numeric(levels(a[[1]])[olmayanDegerler])
  
  a <- unlist(lapply(Nalar, function(x) c((x-0.001),(x+0.001),NA)))
  b <- unlist(lapply(olanlar, function(x) c((x-0.001),(x+0.001),1)))
  c <- unlist(lapply(olmayanlar, function(x) c((x-0.001),(x+0.001),0)))
  
  degismmatrix <- matrix(data = c(a,b,c),ncol = 3,byrow = T)
  
  sonuc <- reclassify(train,degismmatrix,right = FALSE)
  return(sonuc)
}

trainTableKontrol <- function(train){
  cevap <- "cevap"
  trainTable <- table(values(train))
  trainDeger <- as.numeric(names(trainTable))
  if(length(trainDeger) == 2){
    # if(!length(which(trainDeger == c(0,1))) & !length(which(trainDeger == c(1,0)))){
    if(length(intersect(trainDeger,c(0,1))) != 2){
      cevap <- dlgMessage("Yuklediginiz egitim verisinin icerigi 0 ve 1 lerden olmusmamaktadir. Olan Heyelan Alanlari icin 1 ve Olmayan
     heyelan alanlar icin 0 olarak tekrar duzenleyiniz. Diger yerler icin NA yaziniz veya aynen birakiniz!\n
                          Duzeltilmesi icin Yes'e basiniz..\n
                          Aksi Takdirde isleminiz sonlandirilacaktir", type = "yesno", gui = .GUI)$res
    }
  }else{
    cevap <- dlgMessage("Yuklediginiz egitim verisinin icerigi 0 ve 1 lerden olmusmamaktadir. Olan Heyelan Alanlari icin 1 ve Olmayan
     heyelan alanlar icin 0 olarak tekrar duzenleyiniz. Diger yerler icin NA yaziniz veya aynen birakiniz!\n
                          Duzeltilmesi icin Yes'e basiniz..\n
                          Aksi Takdirde isleminiz sonlandirilacaktir", type = "yesno", gui = .GUI)$res
    
  }
  return(cevap)
}

trainYazdirma <- function(train, baseName){
  saveAnswer <- dlg_message("Düzeltilmiþ eðitim verisini kaydetmek ister misiniz?",type = "yesno",gui = .GUI)$res
  if(saveAnswer == "yes"){
    folderPath <- choose.dir()
    writeRaster(train, filename = paste0(folderPath,"\\Rev",baseName),overwrite=TRUE)
  }
}

findOptiFea <- function(resultMatrix){
  nX <- ncol(resultMatrix)
  listOfTrue <- lapply(1:nX, function(x) NULL)
  for(i in 1:nX){
    dogrudegersayisi = 0
    if((i+1) <= nX){
      for(j in (i+1):nX){
        
        dogruolmasigerekendegersayisi = nX - i
        
        if(resultMatrix[i,j] < 0.05 & !is.nan(resultMatrix[i,j]) & !is.na(resultMatrix[i,j])) {
          dogrudegersayisi = dogrudegersayisi + 1
        }
      }
      
      listOfTrue[[i]] <- dogrudegersayisi
    }
    else{
      listOfTrue[[nX]] <- nX
    }
  }
  
  #en küçük degerin bulunmasý ve sonuc olarak alýnmasý
  minimum <- min(unlist(listOfTrue))
  minimumdeger <- nX + 100
  for(i in 1:( nX- 1)){
    if(listOfTrue[[i]] == minimum){
      minimumdeger <- i
      break
    }
  }
  return(minimumdeger)
}

upper.diag<-function(x){
  m<-(-1+sqrt(1+8*length(x)))/2
  X<-lower.tri(matrix(NA,m,m),diag=TRUE)
  X[X==TRUE]<-x
  X[X==FALSE]<-NA
  t(X)
}

theme_map <- function(...) {
  theme_minimal() +
    theme(
      text = element_text(family = "Ubuntu Regular", color = "#22211d"),
      # remove all axes
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      # add a subtle grid
      panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#f5f5f2", color = NA), 
      plot.margin = unit(c(.5, .5, .2, .5), "cm"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = "#f5f5f2", color = NA), 
      panel.spacing = unit(c(-.1, 0.2, .2, 0.2), "cm"),
      legend.background = element_rect(fill = "#f5f5f2", color = NA),
      legend.title = element_text(size = 13),
      legend.text = element_text(size = 11, hjust = 0, color = "#4e4d47"),
      plot.title = element_text(size = 16, hjust = 0.5, color = "#4e4d47"),
      plot.subtitle = element_text(size = 10, hjust = 0.5, color = "#4e4d47", 
                                   margin = margin(b = -0.1, 
                                                   t = -0.1, 
                                                   l = 2, 
                                                   unit = "cm"), 
                                   debug = F),
      plot.caption = element_text(size = 9, 
                                  hjust = .5, 
                                  margin = margin(t = 0.2, 
                                                  b = 0, 
                                                  unit = "cm"), 
                                  color = "#939184"),
      ...
    )
}
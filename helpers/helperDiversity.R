getIv <- function(ecosystem){  
  data <- ecosystem;
  forest <- data.frame(table(data$Especie), stringsAsFactors=FALSE, row.names = NULL);  
  names(forest) <- c('Especie', 'abunA');
  forest$Especie <- as.character(forest$Especie);
  forest$abunR <- (forest$abunA/sum(forest$abunA))*100;
  freqSpecies <- data.frame(table(data$Subparcela, data$Especie));
  names(freqSpecies) <- c('subparcela', 'especie', 'frecA');
  dtFreq <- data.frame(table(freqSpecies$especie[freqSpecies$frec > 0]));
  forest$frecA <- dtFreq$Freq;
  forest$frecR <- (forest$frecA/sum(forest$frecA))*100;
  data$dA <- (pi/40000) * (data$Dn^2);
  dtDn <- data.frame(tapply(data$dA, data$Especie, sum), row.names=NULL);
  names(dtDn) <- c('sumDn');
  forest$domA <-  dtDn$sumDn;
  forest$domR <- (forest$domA/sum(forest$domA))*100;
  forest$IVI <- forest$abunR + forest$frecR + forest$domR;  
  total <- data.frame(Especie = "Total", abunA = sum(forest$abunA), abunR = sum(forest$abunR), frecA = sum(forest$frecA), frecR = sum(forest$frecR), domA = sum(forest$domA), domR = sum(forest$domR), IVI = sum(forest$IVI));
  forest <- rbind(forest, total);
  return(forest); 
}
getAlfa <- function(ecosystem){  
  data <- ecosystem;
  forest <- data.frame(table(data$Especie), row.names = NULL);
  names(forest) <- c('especie', 'abunA');
  forest$abunR <- (forest$abunA/sum(forest$abunA));
  s <- length(unique(data$Especie));
  n <- nrow(data)
  index <- NULL;
  index$Margalef <- (s-1)/log(n);
  index$Menhinick <- s/sqrt(n);
  index$ShannonH <- -sum((forest$abunR * log(forest$abunR)));
  index$ShannonE <- index$ShannonH / log(s);
  index$Simpson <- sum(forest$abunR^2);
  index$BergerParker <- max(forest$abunA) / n;
  return(index);
}
getBeta <- function(ecosystemA, ecosystemB){
  speciesA <- unique(ecosystemA$Especie);
  speciesB <- unique(ecosystemB$Especie);

  AB <- intersect(tolower(speciesA), tolower(speciesB));

  a <- length(unique(ecosystemA$Especie));
  b <- length(unique(ecosystemB$Especie));
  j <- length(AB);

  index <- NULL;
  index$JaccardCj <- j/(a+b-j);
  index$SorensenCs <- 2*j/(a+b);

  aN <- nrow(ecosystemA);
  bN <- nrow(ecosystemB);

  match <- integer(0);
  ani <- integer(0);
  bni <- integer(0);
  ani_bni <- integer(0);
  Xij_Xik <- integer(0);
  maxS <- integer(0);

  for(i in 1:length(AB)){
    sA <- subset(ecosystemA, tolower(Especie) == AB[i]);
    sB <- subset(ecosystemB, tolower(Especie) == AB[i]);
    
    if(nrow(sA) < nrow(sB)){
      match[i] <- nrow(sA);
      maxS[i] <- nrow(sB);
    } else{
      match[i] <- nrow(sB);
      maxS[i] <- nrow(sA);
    }
    ani_bni[i] <- nrow(sA)*nrow(sB);
    Xij_Xik[i] <- ( nrow(sA) - nrow(sB) )^2
  }

  jN <- sum(match);

  index$SorensenCn <- 2*jN/(aN + bN);
  S_ani_bni <- sum(ani_bni);

  freqSpeciesA <- as.data.frame(table(ecosystemA$Especie));
  freqSpeciesB <- as.data.frame(table(ecosystemB$Especie));

  ani <- sum(freqSpeciesA$Freq^2);
  bni <- sum(freqSpeciesB$Freq^2);

  da <- ani / (aN^2);
  db <- bni / (bN^2);

  index$MorisitaHornCmH <- (2*S_ani_bni) / ((da+db)*(aN*bN));  

  tmpXij <- subset(ecosystemA, !( tolower(Especie) %in% AB ) );
  Xij <- as.data.frame(table(factor(tmpXij$Especie)));
  tmpXik <- subset(ecosystemB, !( tolower(Especie) %in% AB ) );
  Xik <- as.data.frame(table(factor(tmpXik$Especie)));

  S_Xij_Xik <- sum(Xij$Freq^2) + sum(Xik$Freq^2) + sum(Xij_Xik);

  index$DJK <- sqrt(S_Xij_Xik);
  n <- (a+b)-j;
  index$djk <- sqrt( (index$DJK)^2 / n );

  PS <- 200 * ( jN / (nrow(ecosystemA) + nrow(ecosystemB)) );

  index$PD <- 100 - PS;

  RI <- 100 * ( jN / (sum(Xij$Freq) + sum(Xik$Freq) + sum(maxS)) );

  index$PR <- 100 - RI;

  return(index)
}
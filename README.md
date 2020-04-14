---
title: "Trabalhar com dados Espacias em R"
author: "Prof. Erison Barros"
date: "14/04/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Instalação dos Pacotes

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
# Instalar pacotes
install.packages("sf")           # Formato espacial sf
install.packages("units")        # Atribuicao e conversao de unidades de medida
install.packages("xml2")         # Visualizacao de tabelas xml2 (como as do pacote units)
install.packages("tidyr")        # Manipulacao de dados em tabelas (como substituir valores nulos)
install.packages("cleangeo")     # Correcao topologica
install.packages("rmapshaper")   # Simplificacao de poligonos e sobreposicao de camadas
install.packages("spatialEco")   # Tecnicas de amostragem e metricas de paisagem
```

# Carregar os pacotes que iremos utilizar


```{r}
# Carregar os pacotes que iremos utilizar
library(sf)
library(units)
library(xml2)
library(tidyr)
library(cleangeo)
library(rmapshaper)
library(spatialEco)
```

# Copiar os dados para D:/xxxx/wwww e configurar diretorio de trabalho
```{r}
setwd("D:/R_CTA/aula4")
getwd()
dir()
```

# Importacao dos dados vetoriais (Geopeck)

```{r}
# Importacao dos dados vetoriais (Geopeck)
pocos_abc <- read_sf("abc.gpkg", layer="pocos_abc")
hidrografia_abc <- read_sf("abc.gpkg", layer="hidrografia_abc")
setores_abc_censo <- read_sf("abc.gpkg", layer="setores_abc_censo")
contaminadas_abc <- read_sf("abc.gpkg", layer="contaminadas_abc")
View(setores_abc_censo)
```

# Padronizar a projecao cartografica - Sirgas2000 UTM23S
```{r}
st_crs(pocos_abc)
st_crs(pocos_abc)<-31983
st_crs(hidrografia_abc)<-31983
st_crs(setores_abc_censo)<-31983
st_crs(contaminadas_abc)<-31983
```

# Plotar os vetores para conferir a sobreposicao

```{r}
plot(st_geometry(setores_abc_censo))
plot(st_geometry(hidrografia_abc), add=TRUE, col="blue")
plot(st_geometry(contaminadas_abc), add=TRUE, col= "red")
plot(st_geometry(pocos_abc), add=TRUE, col= "green")
```

# Calcular areas e comprimentos euclidianos

```{r}
setores_abc_censo$area_m2<-st_area(setores_abc_censo)
View(setores_abc_censo)
hidrografia_abc$comprimento_m<-st_length(hidrografia_abc)
View(hidrografia_abc)
```

# Calculo de valores dos campos e unidades de medida

```{r}
setores_abc_censo$area_ha <- setores_abc_censo$area_m2/10000 #calculo em hectares
View(setores_abc_censo)
setores_abc_censo$area_ha <- set_units(setores_abc_censo$area_ha, NULL)
View(setores_abc_censo)
View(valid_udunits())
setores_abc_censo$area_ha <- set_units(setores_abc_censo$area_ha, "hectare")
View(setores_abc_censo)
plot(setores_abc_censo["area_ha"], main="Area(ha)", axes = TRUE, border = NA, cex.axis=0.5, breaks = "fisher") #fisher=quebras naturais
```

# Atividade 1 
##A) Criar uma variavel de densidade demografica, denominada "pessoas_km2" para cada setor censitario.
##B) Plotar um mapa da densidade demografica
##Obs: submeta o codigo e a figura gerados

```{r}
# Lidar com valores nulos
View(setores_abc_censo)
plot(setores_abc_censo["Pessoas"])
library(tidyr)
setores_abc_censo$Pessoas_sem_na <- replace_na(setores_abc_censo$Pessoas,0)
View(setores_abc_censo)
```

# Agregar de setores para distritos

```{r}
f1 <- function(x) sum(x)
bairros_abc_censo <- aggregate(setores_abc_censo["Pessoas_sem_na"], by=list(setores_abc_censo$CD_GEOCODB), FUN = f1)
View(bairros_abc_censo)
plot(st_geometry(setores_abc_censo))
plot(st_geometry(bairros_abc_censo), border="blue", add=T)
plot(bairros_abc_censo["Pessoas_sem_na"])
```

# Correcao topologica

```{r}
library(cleangeo)
bairros_sp <- as(bairros_abc_censo,"Spatial")
clgeo_IsValid(bairros_sp)
analise_topologica <- clgeo_CollectionReport(bairros_sp)
clgeo_SummaryReport(analise_topologica)
View(analise_topologica)
clgeo_SuspiciousFeatures(analise_topologica)
bairros_clean <- clgeo_Clean(bairros_sp) # pode demorar um pouco para processar
clgeo_IsValid(bairros_clean)
bairros_sf <- st_as_sf(bairros_clean)
plot(st_geometry(bairros_sf))
```

# Agregar ponderando pela area

```{r}
setores_abc_censo$pessoas_km2_sem_na <- replace_na(setores_abc_censo$pessoas_km2, 0)
bairros_abc_censo_densidade <- st_interpolate_aw(setores_abc_censo["pessoas_km2_sem_na"], to = bairros_sf, extensive = FALSE)
View(bairros_abc_censo_densidade)
plot(bairros_abc_censo_densidade["pessoas_km2_sem_na"])
setores_abc_censo$domicilios_sem_na <- replace_na(setores_abc_censo$Domicilios,0)
bairros_abc_censo_domicilios <- st_interpolate_aw(setores_abc_censo["domicilios_sem_na"], to = bairros_sf, extensive = TRUE)
View(bairros_abc_censo_domicilios)
plot(bairros_abc_censo_domicilios["domicilios_sem_na"])
```

# Atividade 2
## A) Agregar a variavel "Domicilios" por municipio (identificado pelo atributo CD_GEOCODM) e plotar um mapa pelo metodo de intervalos "pretty"
## B) Fazer a agregacao ponderada pela area para porcentagem de cobertura de rede de esgoto ("rede_esg") pela area do municipio e plotar um mapa pelo metodo de intervalos iguais

# Simplificar geometrias para escala 1:250.000 
## Obs: 125 metros de resolucao. Referencia: Waldo Tobler, para interpretacao digital

```{r}
hidrografia_simplificada <- st_simplify(hidrografia_abc, dTolerance = 125, preserveTopology = TRUE)
par(mfrow=c(1,2))
plot(st_geometry(hidrografia_abc))
plot(st_geometry(hidrografia_simplificada))
par(mfrow=c(1,1))
```

# Atividade 3: simplificar a camada agregada por municipios para escala 1:1.000.000
## Plotar dois mapas, lado a lado, para comparar a camada original com a simplificada

# Simplificacao de poligonos

```{r}
library(rmapshaper)
municipios_simplificado_ms <- ms_simplify(municipios_abc_censo, keep = 0.05)
par(mfrow=c(1,3))
plot(st_geometry(municipios_abc_censo))
plot(st_geometry(municipios_simplificado))
plot(st_geometry(municipios_simplificado_ms))
par(mfrow=c(1,1))
```

# Atividade 4 - Analisar a correcao topologica da camada municipios_simplificado_ms, e corrigir, se necessario

# Distancia, buffer, selecao espacial

```{r}
distancia_pocos_contaminacao <- st_distance(pocos_abc,contaminadas_abc)
View(distancia_pocos_contaminacao)
contaminadas_buff<-st_buffer(contaminadas_abc, 250)
plot(st_geometry(contaminadas_buff), col="red")
plot(st_geometry(contaminadas_abc), pch=20, cex=0.5, col="pink", add=T)
View(contaminadas_buff)
plot(st_geometry(pocos_abc),pch=20,cex=0.8, add=T)
pocos_contaminacao <- st_intersects(pocos_abc, contaminadas_buff)
View(pocos_contaminacao)
contaminacao <- st_is_within_distance(contaminadas_abc,pocos_abc,dist=250)
View(contaminacao)
pocos_contaminados <- pocos_abc[contaminadas_buff, op=st_intersects]
plot(pocos_contaminados,pch=20,cex=0.8,col="yellow", add=T)
zona_pocos <- st_convex_hull(st_union(pocos_contaminados))
plot(st_geometry(zona_pocos), border="purple", lwd=3, add=T)
abc <- st_union(municipios_simplificado_ms)
plot(st_geometry(abc), add=T)
```

 Atividade 5 
## A) Fazer um buffer com area de preservacao permanente (APP) de 30 metros dos cursos de agua.
## B) Criar uma camada com os trechos de APPs potencialmente contaminados, que estao a 100 metros de areas contaminadas
## C) Montar um mapa com as APPs totais em fundo verde e borda verde, e apps potencialmente contaminadas com fundo vermelho e borda vermelha
## D) Fazer um poligono envolvente das apps potencialmente contaminadas, e sobrepor ao mapa gerado na etapa anterior (C)

```{r}
eposicao de camadas (overlay)
bacia_tamanduatei <- read_sf("abc.gpkg", layer="bacia_tamanduatei")
st_crs(bacia_tamanduatei)<-31983
plot(st_geometry(bacia_tamanduatei), col="pink")
plot(st_geometry(setores_abc_censo),add=T)
setores_crop_tamanduatei <- st_crop(setores_abc_censo,bacia_tamanduatei)
plot(st_geometry(bacia_tamanduatei), col="pink")
plot(st_as_sfc(st_bbox(bacia_tamanduatei)), add=T)
plot(st_geometry(setores_crop_tamanduatei), add=T)
setores_tamanduatei <- st_intersection(setores_abc_censo,bacia_tamanduatei)
plot(st_geometry(bacia_tamanduatei), col="pink")
plot(st_geometry(setores_tamanduatei), add=T)
View(setores_tamanduatei)
setores_sem_tamanduatei <- st_difference(setores_abc_censo, bacia_tamanduatei)
plot(st_geometry(setores_sem_tamanduatei))
plot(st_geometry(bacia_tamanduatei), col="pink", add=T)
View(setores_sem_tamanduatei)
setores_todos <- rbind(setores_tamanduatei, setores_sem_tamanduatei)
plot(st_geometry(setores_todos))
```

# Atividade 6:
## A) Carregue a camada da subbacia do rio dos Couros (bacia_couros) no geopackage "abc" e atribua a projecao Sirgas 2000 UTM 23S (EPSG 31983)
## B) Apague na camada da bacia do rio Tamanduatei, a area correspondente a sub-bacia do rio dos Couros
## C) Junte a camada construida em B com a subbacia do rio dos Couros, em uma unica camada sf
## D) Faca um mapa com a bacia do rio Tamanduatei junto com a sub-bacia do rio dos Couros

# Pontos em poligonos

```{r}
centroide_setor<-st_centroid(setores_abc_censo)
plot(st_geometry(setores_abc_censo))
plot(st_geometry(centroide_setor), cex=0.4, col="blue", add=T)
View(centroide_setor)
coord<-st_coordinates(centroide_setor)
View(coord)
class(coord)
coord<-as.data.frame((coord))
class(coord)
centroide_setor$UTMX<-coord$X
centroide_setor$UTMY<-coord$Y
View(centroide_setor)
ponto_no_setor<-st_point_on_surface(setores_abc_censo)
plot(st_geometry(setores_abc_censo))
plot(st_geometry(ponto_no_setor), cex=0.4, col="red", add=TRUE)

```

# Atividade 7 - Copiar as variaveis com as coordenadas X e Y para a camada sf "ponto_no_setor" 

# UniÃ£o espacial (Spatial Join)

```{r}
contaminacao_social <- st_join(contaminadas_abc, setores_abc_censo, join = st_intersects, left=T)
View(contaminacao_social)

```
# Atividade 8 - 
## A) Fazer um inner join (opcao left=FALSE), para trazer as informacoes de contaminacao apenas para os pocos que estao dentro do buffer de 250m das areas contaminadas
## B) Plotar os pocos totais do ABC em preto, sobrepondo os pocos em que foi feito o inner join em vermelho

# Amostragem

```{r}
mun_abc <- read_sf("abc.gpkg", layer="mun_abc")
st_crs(mun_abc)<-31983
aleatorio <- st_sample(mun_abc, 20, type = "random")
plot(st_geometry(mun_abc))
plot(st_geometry(aleatorio), pch=20, col="red", add=T)
hexagonal <- st_sample(mun_abc, 20, type = "hexagonal")
plot(st_geometry(mun_abc))
plot(st_geometry(hexagonal), pch=20, col="blue", add=T)

```

# Atividade 9 - Faca 2 mapas de 200 amostragens no formato aleatorio e hexagonal

# Amostragem estratificada espacialmente
```{r}
library(spatialEco)
mun_sp <- as(mun_abc,"Spatial")
estratificado_sp <- sample.poly(mun_sp, n=10, type="random")
estratificado_sf <- st_as_sf(estratificado_sp)
plot(st_geometry(mun_abc))
plot(st_geometry(estratificado_sf), pch=20, col="green", add=T)
```

# Atividade 10 - Faca a amostragem estratificada espacialmente no formato hexagonal e compare com a estratificada aleatoria

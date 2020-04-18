# Itens:
## Dados Espaciais
git remote add origin git@github.com: ErisonBarros / Dados-Espacias-em-R.git
## Dados Espaciais Vetoriais
 git push -u origin master
# Live 1: Precisamos falar de PyQGIS  
  
**[![Live pyqgis 1 - Precisamos falar de PyQGIS](https://img.youtube.com/vi/sab58zUKr-A/0.jpg)](https://youtu.be/sab58zUKr-A)**  

## Proposta de temática

:warning: vamos usar os dados o banco de dados do IBGE 1:1.000.000 (bcim). Para fazer [download, clique aqui](https://downloads.ibge.gov.br/downloads_geociencias.htm), e guarde-o dentro da pasta "/livepyqgis/dados"  

### Abrir uma camada vatorial  

Há algumas formas de fazer isso. Vamos começar pelo `addVectorLayer()`  

* Vamos usar o método [`addVectorLayer()`](https://qgis.org/pyqgis/master/gui/QgisInterface.html#qgis.gui.QgisInterface.addVectorLayer), que é um método do [`QgisInterface`](https://qgis.org/pyqgis/master/gui/QgisInterface.html#qgis.gui.QgisInterface), que pode ser "abreviado" como `iface`, para realizar a importação do dado vetorial desejado. O mesmo depende das seguintes variáveis: `addVectorLayer(vectorLayerPath, baseName, providerKey)` (bem similar ao `qgsVectorLayer`).  
O Método `addVectorLayer` retorna um objeto `QgsVectorLayer`;  

**ATENÇÃO**

* *vectorLayerPath*: deve incluir o nome da layer a ser carregada, precedida de `|layername=`. E.g.: `bcim_2016_21_11_2018.gpkg|lim_unidade_federacao_a`  
* *basename*: nome a ser dado à layer no projeto qgis;  
* *providerKey*: "ogr" <3 mas outros podem ser usados, como -“postgres”, “delimitedtext”, “gpx”, “spatialite”, and “WFS”.  

> iface is an object belonging to QGIS – something that has properties and behaviors we can use to interact with QGIS. iface is a very important object in QGIS because without it, we could not interact with QGIS or any layers loaded in our project. ( [Anita Graser](https://anitagraser.com/pyqgis-101-introduction-to-qgis-python-programming-for-non-programmers/pyqgis-101-loading-a-vector-layer/) )

O dado foi adicionado mas não salvamos como um objeto para podermos seguir trabalhando com ele. Temos duas opções: carregar de novo atribuindo o resutado a um objeto. ou podemos atribuir a camada ativa (camada selecionada e com *underline* no qgis a um objeto;  

Vamos pela segunda opção:  

### Selecionando camada ativa  

Ainda usando o `ìface` (me parece que será nosso amigo nessa jornada), vamos usar o *método* `activeLayer()`, atribuindo o resultado a uma objeto. Nessa caso, vou chamar de "uf";
`uf = iface.activeLayer()`. O console não dará nenhum sinal, a não se que haja algum erro. Uma vez tendo atribuido ao objeto `uf` a camada ativa, podemos seguir brincado...  

### Contando feições da camada  

A classe `QgsVectorLayer` possui várias funções, as quais chamamos de étodo. Uma delas é para a contagem das feições existentes na camada que estamos trabalhando: `uf.featureCount()`.  
Ao executar esse método, teremos o resultado no console do python. Perceba que o metodo [`featureCount`](https://qgis.org/pyqgis/master/core/QgsVectorLayer.html?highlight=qgsvectorlayer#qgis.core.QgsVectorLayer.featureCount) é de obejto `qgsVectorLayer`, por isso o usamos sem a necessidade de usar o `iface`.  

### Listando os campos da camada

Outro método interessante de vermos é o que retorna os campos (ou nome das colunas) de nosssa camada. Vamos usar `uf.fields()`, para poder identificar os campos e iterar sobre eles para, então, usar o método `name()` para termos o nome de cada campo:  

```python
for field in uf.fields():
    print(field.name())
```  

A gente poderia também ter o nome de um campo específico, caso saibamos a ordem ao qual os mesmo se encontra ( :warning: lembrando que no python a contagem começa com 0). Então para saber o nome do primeiro campo da camada:  
`print(uf.fields()[0].name())`  

Para abrir a tabela de atributos da camada, teremos que usar o método `showAttributeTable` do `iface`, com o detalhe de incluir o objeto uf no parenteses do método:
`iface.showAttributeTable(uf)`  

### Listando os valores de um campo  

Agora que vimos a tabela de atributos, vamos iterar a cada feição existente. Vamos usar o método `getFeatures()` do objeto `uf` e iterar sobre ele e imprimir o campo "nome", afinal, já sabemos que ele existe....

```python
for feature in layer.getFeatures():
    print(feature["nome"])

```  

### Filtrar por uma ou mais feições  

Sabendo que há uma feição chamada "Rio de Janeiro" no campo "nome" da camada que estamos trabalhando, podemos filtrar nossa camada. Para isso, vamos usar o método [`setSubsetString()`](https://qgis.org/pyqgis/master/core/QgsVectorLayer.html?highlight=setsubsetstring#qgis.core.QgsVectorLayer.setSubsetString) do objeto `QgsVectorLayer`. Nele temos que informar a expressão a ser filtrada.
`setSubsetString(self, subset)`:  
`rj = uf.setSubsetString("nome = 'Rio de Janeiro'")`.

Agora que temos apenas a feição que queremos trabalhar, podemos dar um zoom à ela, usando o método `zoomToActiveLayer()` do `iface`:  
`iface.zoomToActiveLayer()`  

### Desfazer filtro

Para desfazer o filtro, basta:
`layer.setSubsetString("")`

### Alterando a simbologia

Para alterar a cor da feição que estamos trabalhando, vamos usar as clases `renderer()`, que cuida da renderização de cada feição, seguida de `symbol()` que cuida específicamente da simbologia. Para alterar a cor, usarmos, então, o método `setColor()` para alterar a cor de nossa camada. O `QColor("black")` nos permite deifnir a cor a ser alterada, resultado em:   `uf.renderer().symbol().setColor(QColor("black"))`  

Percebam que o *canvas* precisa ser atualizado. Faremos isso pelo método do `QgsVectorLayer` `triggerRepaint()`: `uf.triggerRepaint()`;  

Estamos quase lá. Nos falta atualizar a simbologia na lista de camadas. Como se trata de uma atualização na interface, vamos de `iface`:  
`iface.layerTreeView().refreshLayerSymbology(uf.id())`  
  
### Salvando o projeto  
  
Para salvar o projeto que estamos trabalhando, vamos criar uma instancia `[QgsProject](https://qgis.org/pyqgis/master/core/QgsProject.html#qgis.core.QgsProject)` que, por ser uma classe única, basta usar `instance()` e, então, o método `write()` no qual devemos informar o caminho da até a pasta onde o projeto será salvo:  

```python
QgsProject.instance().write('caminho_para_pasta/projeto1.qgs')
```  

Vejam que após salva-lo e enquanto o mantemos aberto, o nome do projeto pode ser acessado pelo método `fileName()`;  
`print(QgsProject.instance().fileName())`  


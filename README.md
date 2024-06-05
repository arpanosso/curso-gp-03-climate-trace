
<!-- README.md is generated from README.Rmd. Please edit that file -->

![](img/logo01.png)

<img src="img/todos.png" width="100%" style="display: block; margin: auto auto auto 0;" />

# Introdução às Mudanças Climáticas Globais: Monitoramento de Emissões e Capturas de Gases do Efeito Estufa

No minicurso falaremos sobre as bases físicas das mudanças climáticas
globais, impactos, adaptações e necessidades de mitigação. Exploraremos
também a plataforma [Climate TRACE](https://climatetrace.org/) para
monitoramento de emissões de gases do efeito estufa em nível nacional.
Além disso, haverá uma atividade prática com aquisição de dados,
pré-processamento e visualização de dados com o R.

------------------------------------------------------------------------

## 1) Apresentações

<img src="img/ppt-logo.png" style="width:10.0%" /> [Panorama das
emissões no
Brasil](https://raw.githubusercontent.com/arpanosso/curso-gp-03-climate-trace/master/Docs/apresentacao-daCosta.pdf)

<img src="img/ppt-logo.png" style="width:10.0%" /> [Bases Físicas das
MCG](https://raw.githubusercontent.com/arpanosso/curso-gp-03-climate-trace/master/Docs/apresentacao-daCosta.pdf)

------------------------------------------------------------------------

## 2) Plataforma [Climate TRACE](https://climatetrace.org/)

------------------------------------------------------------------------

## 3) Aquisição de Dados

Nesta atividade, você aprenderá a navegar na plataforma [Climate
TRACE](https://climatetrace.org/), selecionar a base de dados de
interesse, no caso vamos baixar os dados do Brasil, e fazer o download
dos dados para uso em seus projetos.

### Passo a Passo

**Acesse a Plataforma**  
+ Abra seu navegador de internet preferido.  
+ Digite o endereço da plataforma na barra de endereços
(<https://climatetrace.org/>) ou clique no link de acesso.

![](img/aq-ct01.png)

**Criação de Conta ou Login**  
+ No momento, não é necessário criar uma conta ou fazer login na
plataforma para acessar os dados.  
+ Provavelmente, essa opção será implementada no futuro.  
+ Portanto, você pode prosseguir diretamente para a navegação e download
dos dados.

**Navegação até a Base de Dados**  
+ No canto direito inferior, clique no botão
<img src="img/aq-ct02.png" style="width:15.0%" />.  
+ Você será direcionado para a página abaixo.

![](img/aq-ct03.png)

- Observe que a aquisição de dados poderá ser feita via download ou por
  API (Interface de Programação de Aplicações). Nessa prática, por
  questões didáticas, optaremos pela aquisição via download.  
- Role a página para baixo até encontrar a seção ou aba chamada “Bases
  de Dados”, “Data Sets” ou algo semelhante. Clique nesta opção.

![](img/aq-ct04.png)

- Clique nesta opção **Country**.  
- Uma nova página será carregada dinamicamente com o alfabeto para
  auxiliar na procura das bases de dados disponíveis.
- Clique em **B** e procure por *BRAZIL*.

![](img/aq-ct05.png)

**Download dos Dados**  
+ Encontre o botão ![](img/aq-ct051.png).  
+ Clique sobre ele para fazer o download dos dados no formato CSV.  
+ O download será iniciado automaticamente.  
+ Aguarde até que o arquivo seja salvo em seu computador.

**OBS:** CSV (Comma-Separated Values) é um formato de arquivo simples e
amplamente utilizado para armazenar dados tabulares.

![](img/aq-ct06.png)

Após o download terminar, acesse a pasta de downloads do seu computar e
observe o arquivo:

![](img/aq-ct07.png)

**Lidando com Arquivos ZIP**

- Muitas vezes, os dados são compactados em um arquivo ZIP para
  facilitar o download. Um arquivo ZIP é um formato de arquivo que
  contém um ou mais arquivos compactados para reduzir o tamanho total e
  facilitar a transferência.  
- Para descompactar o arquivo ZIP:
  - No Windows: Clique com o botão direito no arquivo ZIP e selecione
    “Extrair Tudo…”, depois siga as instruções para escolher um local
    onde os arquivos serão extraídos.  
  - Por padrão, os dados serão descompatados dentro de uma pasta como no
    BRA, semelhante ao nome do arquivo baixado, localizada no mesmo
    diretório onde o arquivo BRA.zip se encontra.
- Após descompactar, você verá os arquivos de dados e metadados que
  podem ser abertos e analisados.

![](img/aq-ct08.png)

**OBS:** Metadados são informações adicionais que descrevem os dados
principais. Eles podem incluir: descrição das variáveis; explicação do
que cada coluna ou campo de dados representa; Unidades de medida:
unidades usadas; ou seja, qualquer outra informação relevante que ajude
a entender e utilizar os dados corretamente.

**Dicas Adicionais**  
+ Organização: Crie uma pasta dedicada em seu computador para armazenar
os dados baixados, facilitando a organização e o acesso futuro.  
+ Documentação: Leia a documentação ou notas técnicas fornecidas pela
plataforma para entender melhor os dados e suas limitações.  
+ Backup: Sempre faça backup dos dados importantes para evitar perdas
acidentais.

------------------------------------------------------------------------

## 4) Pré-Processamento de Dados (Faxina de Dados)

O pré-processamento de dados, ou faxina de dados, é uma das etapas mais
importantes do Data Science. Antes de realizar qualquer análise ou
construção de modelos, é essencial garantir que os dados estejam limpos
e estruturados corretamente.

![](img/data-science-cycle.png) O Ciclo do Data Science.

Dados de má qualidade podem levar a resultados imprecisos e análises
equivocadas. Por isso, dedicar tempo ao pré-processamento assegura que
as análises subsequentes sejam baseadas em informações confiáveis e
precisas.

**Carregar Pacotes**

``` r
library(tidyverse)
```

**Importação dos Dados**

Importe os dados para o software de análise que você está utilizando
(Excel, R, Python, etc.).

``` r
dados_crus <- read_rds("data-raw/BRA.rds")
glimpse(dados_crus)
#> Rows: 100,000
#> Columns: 23
#> $ source_id                 <int> 8173502, 4580584, 20404729, 4530293, 9289668…
#> $ source_name               <chr> "Campo do Tenente", "Matriz de Camaragibe", …
#> $ source_type               <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
#> $ iso3_country              <chr> "BRA", "BRA", "BRA", "BRA", "BRA", "BRA", "B…
#> $ original_inventory_sector <chr> NA, NA, "manure-left-on-pasture-cattle", NA,…
#> $ start_time                <chr> "2021-01-01 00:00:00", "2022-01-01 00:00:00"…
#> $ end_time                  <chr> "2021-12-31 00:00:00", "2022-12-31 00:00:00"…
#> $ lat                       <dbl> -25.977848, -9.104498, -29.362905, -16.62071…
#> $ lon                       <dbl> -49.65640, -35.58160, -51.30492, -43.92882, …
#> $ geometry_ref              <chr> "gadm_BRA.16.59_2", "gadm_BRA.2.55_2", "gadm…
#> $ gas                       <chr> "co2", "ch4", "co2e_100yr", "co2e_100yr", "c…
#> $ emissions_quantity        <dbl> 2587.14882, NA, 105.21137, 89.00585, 0.00000…
#> $ temporal_granularity      <chr> "annual", "annual", "annual", "annual", "ann…
#> $ created_date              <chr> "2023-09-29 00:00:00", "2023-09-29 00:00:00"…
#> $ modified_date             <chr> "2024-02-26 22:15:30.926679", NA, "2023-11-1…
#> $ directory                 <chr> "data-raw/BRA/forestry_and_land_use/forest-l…
#> $ activity                  <dbl> 7354.740884, NA, 239.978673, 231.431143, 3.8…
#> $ activity_units            <chr> "Total Living biomass burned", NA, "animals"…
#> $ emissions_factor          <dbl> 3.517661e-01, NA, 1.506299e-03, NA, NA, 1.26…
#> $ emissions_factor_units    <chr> "unitless emission efficiency factor", NA, "…
#> $ capacity                  <dbl> 4020983.226, NA, 29569.152, 46720.959, 71557…
#> $ capacity_units            <chr> "Total live biomass carbon from annual carbo…
#> $ capacity_factor           <dbl> 1.829090e-03, NA, 8.115846e-03, 4.953476e-03…
```

### Observe o mesmo banco de dados em \[EXCEL\]

    Correção de Inconsistências

    Verifique e corrija valores ausentes (missing values) e inconsistências nos dados.
    Substitua valores ausentes por uma média, mediana, ou utilize técnicas de imputação apropriadas.

    Remoção de Duplicatas

    Identifique e remova registros duplicados que possam estar presentes no conjunto de dados.

    Normalização e Padronização

    Normalize ou padronize os dados, se necessário, para garantir que todas as variáveis estejam na mesma escala, especialmente para análises estatísticas e de machine learning.

    Conversão de Tipos de Dados

    Verifique e converta tipos de dados (por exemplo, transformar strings de datas em objetos de data, transformar variáveis categóricas em fatores ou dummy variables).

    Tratamento de Outliers

    Identifique e trate outliers que possam afetar a análise. Decida se deve removê-los ou transformá-los.

    Criação de Novas Variáveis (Se Necessário)

    Crie novas variáveis derivadas de outras, se necessário, para enriquecer a análise.

    Validação Final

    Revise e valide o conjunto de dados limpo para garantir que está pronto para análise.

------------------------------------------------------------------------

### Carregando os pacotes necessários

``` r
# library(tidyverse)
# library(treemapify)
# library(geobr)
# source("R/base_map.R")
# source("R/my_function.R")
```

``` r
# dados <- read_rds('data/emissoes_br.rds')
```

``` r
# dados %>%
#   distinct(ano)
```

``` r
# estados  %>%
#   filter(name_state=="São Paulo") %>%
#   ggplot() +
#     geom_sf(fill="lightgray", color="black",
#           size=.15, show.legend = FALSE,
#           alpha=.5) +
#   geom_sf(data=conservacao,
#          color= conservacao %>%
#            pull(code_conservation_unit),
#          fill=NA)+
#   geom_sf(fill=NA, color="black",
#           size=.15, show.legend = T) +
#   lims(x=c(-53,-44.5),y=c(-25,-19.5)) +
#   geom_point(data = dados %>%
#                filter(area_conservacao,
#                       estado=="SP",
#                       ano==2022) %>%
#                group_by(lat,lon) %>%
#                summarise(
#                  emissao = sum(emissao,na.rm = T)/1e6,
#                  .groups = 'drop'
#                )  %>%
#                mutate(
#                  emission_class=case_when(
#                    emissao < -1 ~ "< -1",
#                    emissao < 0 ~ "< 0",
#                    emissao < 1 ~ "< 1",
#                    emissao > 1 ~ "> 1"
#                  )
#                ),
#              aes(x=lon,y=lat,color=emission_class))+
#   labs(color='Emission (M ton C)')+
#   tema_mapa()
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado=="SP",
#          ano==2022) %>%
#   group_by(lat,lon) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6,
#     .groups = 'drop'
#   )  %>%
#   mutate(
#     emission_class=case_when(
#       emissao < -1 ~ "< -1",
#       emissao < 0 ~ "< 0",
#       emissao < 1 ~ "< 1",
#       emissao > 1 ~ "> 1"
#     )
#   )  %>%
#   ungroup()  %>%
#   group_by(emission_class)  %>%
#   summarise(e_count = n())
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado=="SP",
#          ano==2022) %>%
#   group_by(lat,lon) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6,
#     .groups = 'drop'
#   )  %>%
#   mutate(
#     classe_emissao=case_when(
#       emissao < 0 ~ "sink",
#       .default = "source",
#     )
#   )  %>%
#   ungroup()  %>%
#   group_by(classe_emissao)  %>%
#   summarise(e_count = n(),.groups = 'drop')
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado=="SP",
#          ano==2022) %>%
#   filter(setor!='forestry_and_land_use')%>%
#   group_by(setor) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6
#   )%>%
#   arrange(emissao)  %>%
#   ungroup()  %>%
#   mutate(emissao_p = emissao/sum(emissao)*100)  %>%
#   ggplot(aes(area = emissao_p, fill = setor)) +
#   geom_treemap() +
#   geom_treemap_text(
#     aes(label = paste(setor,
#                       paste0(round(emissao_p, 2), "%"), sep = "\n")),
#     colour = "white") +
#   theme(legend.position = "none")
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado=="SP",
#          ano==2022) %>%
#   #filter(setor !='forestry_and_land_use')%>%
#   group_by(setor) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6
#   ) %>%
#   ggplot() +
#   geom_col(aes(x=setor,y=emissao,fill=setor),color="black")+
#   labs(x='Setor',y=expression('Emissão (M ton CO'[2]~'eq.)'))+
#   theme(axis.text.x = element_text(angle = 45,hjust = 1),
#         legend.position = "none") +
#   theme_bw()
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado=="SP",
#          ano==2022) %>%
#   #filter(setor !='forestry_and_land_use') %>%
#   #group_by(setor) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6,
#     .groups = 'drop'
#   )
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado == "SP") %>%
#   #filter(setor != 'forest-land-clearing') |>
#   #group_by(setor) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6,
#     .groups = 'drop'
#   )
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado == "SP") %>%
#   group_by(ano) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6,
#     .groups = 'drop'
#   )  %>%
#   ggplot(aes(x=ano, y=emissao))+
#   geom_col(color="black",fill="gray") +
#   theme_bw()
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado=="SP") %>%
#   filter(setor != 'forest-land-clearing') |>
#   group_by(setor, ano) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6,
#     .groups = 'drop'
#   ) %>%
#   ggplot()+
#   geom_col(aes(x=ano,y=emissao,fill=setor),
#            position = 'dodge')+
#   labs(x='Setor',y=expression('Emissão (M ton CO'[2]~'eq.)'))+
#   scale_fill_viridis_d()+
#   theme(axis.text.x = element_text(angle = 45,hjust = 1))+
#   theme_bw()
```


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

## Carregando os pacotes necessários

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
# estados <- read_rds("data/estados.rds") 
# conservacao <- read_rds("data/conservacao.rds") 
```

``` r
# estados <- geobr::read_state()
# conservacao <- geobr::read_conservation_units()
# conservacao %>% 
#   filter(str_detect(name_organization,"SP"))
# 
# estados  %>% 
#   filter(name_state=="São Paulo") %>% 
#   ggplot() +
#     geom_sf(fill="white", color="black",
#           size=.15, show.legend = FALSE) +
#   geom_sf(data=conservacao %>% 
#             filter(str_detect(name_organization,"SP")),
#          color= conservacao %>%
#            filter(str_detect(name_organization,"SP")) %>% 
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
#                  emissao = sum(emissao,na.rm = T)/1e6
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
#   #scale_color_viridis_d()+
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
#     emissao = sum(emissao,na.rm = T)/1e6
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
#     emissao = sum(emissao,na.rm = T)/1e6
#   )  %>% 
#   mutate(
#     classe_emissao=case_when(
#       emissao < 0 ~ "sink",
#       .default = "source",
#     )
#   )  %>% 
#   ungroup()  %>% 
#   group_by(classe_emissao)  %>% 
#   summarise(e_count = n())
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
#         legend.position = "none")
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado=="SP",
#          ano==2022) %>%
#   #filter(setor !='forestry_and_land_use') %>%
#   #group_by(setor) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6
#   )
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado == "SP") %>%
#   #filter(setor != 'forest-land-clearing') |>
#   #group_by(setor) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6
#   )
```

``` r
# dados %>%
#   filter(area_conservacao,
#          estado == "SP") %>%
#   group_by(ano) %>%
#   summarise(
#     emissao = sum(emissao,na.rm = T)/1e6
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
#     emissao = sum(emissao,na.rm = T)/1e6
#   ) %>%
#   ggplot()+
#   geom_col(aes(x=ano,y=emissao,fill=setor), 
#            position = 'dodge')+
#   labs(x='Setor',y=expression('Emissão (M ton CO'[2]~'eq.)'))+
#   scale_fill_viridis_d()+
#   theme(axis.text.x = element_text(angle = 45,hjust = 1))+
#   theme_bw()
```

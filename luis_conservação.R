library(tidyverse)
library(ggsci)
library(geobr)
source("R/base_map.R")
source("R/my_function.R")


df <- read_rds('data-raw/teste2.rds')



df$year %>% unique()
#> [1] 2015 2016 2017 2018 2019 2020 2021 2022 2023
states <- read_rds("data/states.rds") %>%
  mutate(name_region = ifelse(name_region == "Centro Oeste","Centro-Oeste",name_region))

states |>
  filter(name_state=="São Paulo") |>
  ggplot()+
  geom_sf(data=conservation,
          color=conservation$code_conservation_unit,fill=NA)+
  geom_sf(fill=NA, color="black",
          size=.15, show.legend = T)+
  lims(x=c(-53,-44.5),y=c(-25,-19.5))+
  geom_point(data =df %>%
               filter(flag_conservation,
                      sigla_uf=="SP",
                      year==2022) %>%
               group_by(lat,lon) %>%
               summarise(
                 emission = sum(emissions_quantity,na.rm = T)/1e6
               ) |>
               mutate(
                 emission_class=case_when(
                   emission < -1 ~ "< -1",
                   emission < 0 ~ "< 0",
                   emission < 1 ~ "< 1",
                   emission > 1 ~ "> 1"
                 )
               ),
             aes(x=lon,y=lat,color=emission_class))+
  #scale_color_viridis_d()+
  labs(color='Emission (M ton C)')+
  tema_mapa()

df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         year==2022) %>%
  group_by(lat,lon) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  ) |>
  mutate(
    emission_class=case_when(
      emission < -1 ~ "< -1",
      emission < 0 ~ "< 0",
      emission < 1 ~ "< 1",
      emission > 1 ~ "> 1"
    )
  ) |>
  ungroup() |>
  group_by(emission_class) |>
  summarise(e_count = n())

df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         year==2022) %>%
  group_by(lat,lon) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  ) |>
  mutate(
    emission_class=case_when(
      emission < 0 ~ "sink",
      .default = "source",
    )
  ) |>
  ungroup() |>
  group_by(emission_class) |>
  summarise(e_count = n())


library(treemapify)
df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         year==2022,
         gas=='co2e_100yr') %>%
  filter(sector_name!='forestry_and_land_use')%>%
  group_by(sector_name) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  )%>%
  arrange(emission)  %>%
  ungroup() |>
  mutate(emisison_p = emission/sum(emission)*100) |>
  ggplot(aes(area = emisison_p, fill = sector_name)) +
  geom_treemap() +
  geom_treemap_text(
    aes(label = paste(sector_name,
                      paste0(round(emisison_p, 2), "%"), sep = "\n")),
    colour = "white") +
  theme(legend.position = "none")


df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         year==2022,
         gas=='co2e_100yr') %>%
  #filter(sector_name!='forestry_and_land_use')%>%
  group_by(sector_name) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  )%>%
  ggplot()+
  geom_col(aes(x=sector_name,y=emission))+
  labs(x='Setor',y=expression('Emissão (M ton CO'[2]~'eq.)'))+
  theme(axis.text.x = element_text(angle = 45,hjust = 1))


df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         year==2022,
         gas=='co2e_100yr') %>%
  #filter(sector_name!='forestry_and_land_use')%>%
  #group_by(sector_name) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  )

df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         gas=='co2e_100yr') %>%
  #filter(sub_sector!='forest-land-clearing') |>
  #group_by(sector_name) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  )

df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         gas=='co2e_100yr') %>%
  group_by(year) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  ) |>
  ggplot(aes(x=year,y=emission))+
  geom_col()


df %>%
  filter(flag_conservation,
         sigla_uf=="SP",
         gas=='co2e_100yr') %>%
  filter(sub_sector!='forest-land-clearing') |>
  group_by(sector_name,year) %>%
  summarise(
    emission = sum(emissions_quantity,na.rm = T)/1e6
  )%>%
  ggplot()+
  geom_col(aes(x=year,y=emission,fill=sector_name),position = 'dodge')+
  labs(x='Setor',y=expression('Emissão (M ton CO'[2]~'eq.)'))+
  scale_fill_viridis_d()+
  theme(axis.text.x = element_text(angle = 45,hjust = 1))


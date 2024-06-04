library(tidyverse)
df <- readr::read_rds("data-raw/emissions_sources.rds")
glimpse(df)
df <- df %>%
  select(lat,lon,
         gas,emissions_quantity,
         year,
         sector_name,
         sub_sector,
         nome_regiao,biome,
         flag_indigenous,
         flag_conservation,
         city_ref,
         sigla_uf) %>%
  rename(emissao = emissions_quantity,
         ano = year,
         setor = sector_name,
         sub_setor = sub_sector,
         regiao = nome_regiao,
         bioma = biome,
         terra_indigena = flag_indigenous,
         area_conservcao = flag_conservation,
         municipio = city_ref,
         estado = sigla_uf
         ) %>%
  filter(gas == "co2e_100yr") %>%
  relocate(lon,lat,ano,estado,municipio)
df$ano %>% unique()
write_rds(df,"data/emissoes_br.rds")


states <- read_rds("data/states.rds") %>%
  mutate(name_region = ifelse(name_region == "Centro Oeste","Centro-Oeste",name_region))




states <- geobr::read_state()
write_rds(
  states %>% tibble() %>%
    mutate(name_region = ifelse(name_region == "Centro Oeste",
                                "Centro-Oeste",name_region)),
  "data/estados.rds")

write_rds(read_rds("data/emissoes_br.rds") %>%
  rename(area_conservacao = area_conservcao),"data/emissoes_br.rds")


conservacao <- geobr::read_conservation_units()

write_rds(
  conservacao %>% tibble(),
  "data/conservacao.rds")

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

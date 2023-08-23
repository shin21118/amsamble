library(tidyverse)
co2_df <- read_csv("owid-co2-data.csv")
install.packages("remotes")
remotes::install_github("indenkun/seq.geometric")
library(seq.geometric)
head(co2_df)
seq_geometric(from = 1, to = 64, by.ratio = 2)

# G7の国
# GDP per Capita($1,000)
# CO2 per Capita


tidy_df <- co2_df %>% 
      dplyr::filter(country %in% c("Japan","United States",
                                   "United Kingdom","Italy","Germany",
                                   "Canada","France")) %>%
      mutate(gdp_per_capita = gdp / 1000 / population,
             CO2_per_capita = co2 / population * 2*(10^6) ) %>% 
      select(country,year,gdp_per_capita,CO2_per_capita)

tidy_df %>% ggplot() +
            geom_line(aes(x = gdp_per_capita, y = CO2_per_capita,color = country)) +
            geom_point(aes(x = gdp_per_capita, y = CO2_per_capita,color = country)) +
            labs(x = "GDP per Capita($1,000)", y = "CO2 per Capita", color = "country") +
            scale_x_continuous(breaks = seq(0.5,3.5,0.5), 
                               labels = seq_geometric(from = 1, to = 64, by.ratio = 2))
# ggplot(data = df) +
#   geom_line(aes(x = Year, y = P, color = Company_Type1), 
#             linewidth = 1) +
#   geom_point(aes(x = Year, y = P, color = Company_Type1), 
#              size = 3, shape = 21, fill = "white") +
#   labs(x = "年度", y = "平均利用者数 (人/日)", color = "事業者区分") +
#   scale_x_continuous(breaks = 2011:2017, labels = 2011:2017) +
#   theme_minimal(base_size = 12)
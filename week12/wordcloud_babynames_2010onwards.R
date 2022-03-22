# For tidytuesday - week 12 - Babynames in the US 
# An attempt to visualize the popular names in past decade (2010-2017)
library(wordcloud2) # for word cloud creation
library(babynames) # dataset from Hadley W.
library(dplyr) # for piping and data manipulation

# look at the structure of the dataset
str(babynames)

# data prep 
# filtering for years 2010 and beyond and names with more than 3000 babies for wordcloud
baby_2010s = babynames %>% 
  filter(year >= 2010, n>3000) %>% 
  group_by(name, sex) %>% 
  summarise(tot=sum(n)) %>% 
  rename(word = "name", freq = "tot") %>% 
  mutate(sex = factor(sex)) %>% 
  relocate(word, freq, sex) %>% 
  ungroup()

# define color scheme
basecolor = c("pink", "skyblue")
colorlist = basecolor[match(baby_2010s$sex, unique(baby_2010s$sex))]

# creating word cloud and fitting into a image mask
wordcloud2(baby_2010s, 
           size = 0.25,
           rotateRatio = 0,
           backgroundColor = "White", 
           color = colorlist, shuffle = FALSE,
           figPath = "babies.png"
           )



### unnest_tokens function notes
text<-c("Because I could not stop for Death-",
        "He kindly stopped for me-",
        "The Carriage held but just Ourselves-",
        "And Immortality.")
text

library(dplyr)
text_df<-tibble(line=1:4,text=text)
text_df

install.packages("tidytext")
library(tidytext)
text_df %>%
  unnest_tokens(word,text)
### Tidying the works of Jane Austen
library(janeaustenr)
library(stringr)
library(stringr)
original_books<-austen_books() %>%
  group_by(book) %>%
  mutate(linenumber=row_number(),
         chapter=cumsum(str_detect(text,regex("^chapter [\\divxlc]",ignore_case=TRUE)))) %>%
  ungroup()
### unnesting the tokens
library(tidytext)
tidy_books<-original_books %>%
  unnest_tokens(word,text)
tidy_books
### Removing stop words
data(stop_words)
tidy_books<-tidy_books %>%
  anti_join(stop_words)
tidy_books %>% 
  count(word,sort=TRUE)
## pipe directly to ggplot2
library(ggplot2)
tidy_books %>%
  count(word,sort=TRUE) %>%
  filter(n>600) %>%
  mutate(word=reorder(word,n)) %>%
  ggplot(aes(word,n))+
  geom_col()+
  labs(y = NULL)
## gutenbergr package
install.packages("gutenbergr")
library(gutenbergr)
hgwells<-gutenberg_download(c(35,36,5230,159))
tidy_hgwells<-hgwells %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words)
tidy_hgwells %>%
  count(word,sort=TRUE) %>%  

## the bronte sisters works
bronte<-gutenberg_download(c(1260,768,969))
tidy_bronte<-bronte %>%unnest_tokens(word,text) %>%
  anti_join(stop_words)
tidy_bronte %>%
  count(word,sort=TRUE) %>%
tidy_bronte  
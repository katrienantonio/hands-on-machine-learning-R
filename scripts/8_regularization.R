####################################################################
#  Regularized (G)LMs
####################################################################

library(tidyverse)

## --------------------------------------------------------------------------------------------------------------------------------------------------
# fit <- glmnet(x, y, family = ., alpha = ., weights = ., offset = ., nlambda = ., standardize = ., intercept = .)


## --------------------------------------------------------------------------------------------------------------------------------------------------
library(glmnet)
data(QuickStartExample)


## --------------------------------------------------------------------------------------------------------------------------------------------------
fit <- glmnet(x, y, family = "gaussian", alpha = 1, standardize = TRUE, intercept = TRUE)
summary(fit)


## --------------------------------------------------------------------------------------------------------------------------------------------------
library(broom)
fit %>% broom::tidy()


## --------------------------------------------------------------------------------------------------------------------------------------------------
plot(fit, label = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------------------------
plot(fit, label = TRUE, xvar = 'lambda')


## --------------------------------------------------------------------------------------------------------------------------------------------------
plot(fit, xvar = 'dev', label = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------------------------
print(fit)


## --------------------------------------------------------------------------------------------------------------------------------------------------
coef(fit, s = 0.1)


## --------------------------------------------------------------------------------------------------------------------------------------------------
cv_fit <- cv.glmnet(x, y)


## --------------------------------------------------------------------------------------------------------------------------------------------------
cv_fit$lambda.min
cv_fit$lambda.1se


## --------------------------------------------------------------------------------------------------------------------------------------------------
plot(cv_fit)


## --------------------------------------------------------------------------------------------------------------------------------------------------
coef(fit, s = cv_fit$lambda.min)


## --------------------------------------------------------------------------------------------------------------------------------------------------
subset <- data.frame(y = y, V1 = x[, 1], V3 = x[, 3], V5 = x[, 5], V6 = x[, 6], V7 = x[, 7], V8 = x[, 8], V11 = x[, 11], V14 = x[, 14], V20 = x[, 20])
final_model <- lm(y ~ V1 + V3 + V5 + V6 + V7 + V8 + V11 + V14 + V20, data = subset)
final_model %>% broom::tidy()


## --------------------------------------------------------------------------------------------------------------------------------------------------
dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(dir) 
mtpl_orig <- read.table('../data/PC_data.txt', 
                        header = TRUE,
                        stringsAsFactors = TRUE)
mtpl_orig <- as_tibble(mtpl_orig)
mtpl <- mtpl_orig %>% rename_all(tolower) %>% rename(expo = exp)


## --------------------------------------------------------------------------------------------------------------------------------------------------
map(mtpl[, c("coverage")], contrasts, 
    contrasts = FALSE)

map(mtpl[, c("coverage")], contrasts, 
    contrasts = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------------------------
y <- mtpl$nclaims

x <- model.matrix( ~ coverage + fuel + use + fleet + sex + ageph + bm +
                     agec + power, data = mtpl, 
                   contrasts.arg = map(mtpl[, c("coverage")], contrasts, 
                                       contrasts = FALSE))[,-1]

x[1:6,]


## Your Turn!
## --------------------------------------------------------------------------------------------------------------------------------------------------















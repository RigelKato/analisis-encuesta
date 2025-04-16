#Intalación de paquetes
install.packages("janitor")
# Cargar librerías
library(tidyverse)
library(janitor)

# Cargar el dataset
datos <- read_csv("encuesta_clientes.csv")

# Vista rápida de los datos
glimpse(datos)
summary(datos)
str(datos)

#Limpieza de la Información
datos<-remove_empty(datos,which = "rows")
datos<-remove_empty(datos,which = "cols")
datos<-clean_names(datos)
datos$genero <- factor(datos$genero)
summary(is.na(datos))
datos<-na.omit(datos)

#Distribución de Respuestas
library(ggplot2)

ggplot(datos, aes(x = pais)) +
  geom_bar(fill = "blue") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, color = "black") +
  labs(title = "Distribution of responses by country",
       x = "Country",
       y = "Frecuency") +
  theme_minimal()

ggplot(datos, aes(x = edad)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "white") +
  labs(title = "Distribution of responses by age",
       x = "Age",
       y = "Frecuency") +
  theme_minimal()

ggplot(datos, aes(x = producto_favorito, y = edad))+
  geom_point(alpha = 0.5, color = "blue")+
  geom_smooth(method = lm,se = FALSE)+
  labs(title = "Relación entre edad y productos",
       x = "Productos",
       y = "Edades")+
  theme_minimal()

ggplot(datos, aes(x = producto_favorito, y = edad)) +
  geom_jitter(width = 0.2, alpha = 0.5, color = "blue") +  # Jitter dispersa los puntos
  stat_summary(fun = mean, geom = "point", color = "red", size = 3) +  # Muestra promedios
  labs(title = "Relationship between age and products",
       x = "Favorite product",
       y = "Age") +
  theme_minimal()

ggplot(datos, aes(x = producto_favorito, y = edad)) +
  geom_boxplot(fill = "#4a90e2", alpha = 0.7) +
  labs(title = "Distribución de edades según el producto favorito",
       x = "Producto favorito",
       y = "Edad") +
  theme_minimal()

#Exportación de datos
install.packages("writexl")  # solo la primera vez
library(writexl)

write_xlsx(datos, "datos_encuesta.xlsx")
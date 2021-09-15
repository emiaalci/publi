//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
// guardado como 
data {
  int<lower=0> J;         // número de tratamientos 
  real y[J];              // efectos del tratamiento estimados 
  real<lower=0> sigma[J]; //error estándar de estimaciones del efecto 
}
parameters {
  real mu;                // population treatment effect
  real<lower=0> tau;      // standard deviation in treatment effects
  vector[J] eta;          // desviación sin escala de mu por tratamiento
}
transformed parameters {
  vector[J] theta = mu + tau * eta;        // efectos del tratamiento aplicado
}
model {
  target += normal_lpdf(theta | 0, 1);       // prior log-density
  target += normal_lpdf(y | theta, sigma); // log-likelihood
}

# hmm_helpers.R
# Minimal helpers for a Gaussian HMM with hmmTMB.

fit_hmm <- function(data, value = "value", time = NULL, n_states = 2) {
  if (!requireNamespace("hmmTMB", quietly = TRUE)) {
    stop("Install hmmTMB first: install.packages('hmmTMB')")
  }

  dat <- data[is.finite(data[[value]]), , drop = FALSE]

  if (!is.null(time)) {
    dat <- dat[order(dat[[time]]), , drop = FALSE]
  }

  means <- as.numeric(
    quantile(
      dat[[value]],
      probs = seq(0.2, 0.8, length.out = n_states),
      names = FALSE
    )
  )

  sds <- rep(sd(dat[[value]]), n_states)

  hidden <- hmmTMB::MarkovChain$new(
    data = dat,
    n_states = n_states
  )

  observation <- hmmTMB::Observation$new(
    data = dat,
    n_states = n_states,
    dists = setNames(list("norm"), value),
    par = setNames(
      list(list(mean = means, sd = sds)),
      value
    )
  )

  model <- hmmTMB::HMM$new(
    hid = hidden,
    obs = observation
  )

  model$fit(silent = TRUE)

  list(
    model = model,
    data = dat,
    value = value,
    time = time
  )
}


decode_hmm <- function(result) {
  out <- result$data
  out$state <- result$model$viterbi()

  probabilities <- as.data.frame(result$model$state_probs())
  names(probabilities) <- paste0("prob_state_", seq_len(ncol(probabilities)))

  cbind(out, probabilities)
}


summary_hmm <- function(result) {
  result$model$print_obspar()
  result$model$print_tpm()
}


plot_hmm <- function(decoded, value = "value", time = NULL) {
  x <- if (is.null(time)) seq_len(nrow(decoded)) else decoded[[time]]
  y <- decoded[[value]]

  plot(
    x,
    y,
    type = "n",
    xlab = if (is.null(time)) "Observation" else time,
    ylab = value
  )

  for (s in sort(unique(decoded$state))) {
    lines(
      x,
      ifelse(decoded$state == s, y, NA),
      col = s,
      lwd = 2
    )
  }

  legend(
    "topright",
    legend = paste("State", sort(unique(decoded$state))),
    col = sort(unique(decoded$state)),
    lty = 1,
    lwd = 2,
    bty = "n"
  )
}


check_residuals <- function(result) {

  res <- result$model$pseudores()[[1]]

  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))

  par(mfrow = c(2, 2))

  # Residuals vs observation
  plot(
    res,
    type = "l",
    xlab = "Observation",
    ylab = "Pseudo-residual",
    main = "Residuals"
  )
  abline(h = 0, lty = 2)

  # Histogram
  hist(
    res,
    breaks = 30,
    main = "Histogram",
    xlab = "Pseudo-residual"
  )

  # QQ plot
  qqnorm(res)
  qqline(res)

  # ACF
  acf(
    res,
    main = "Residual autocorrelation"
  )

  invisible(res)
}

count_state_blocks <- function(decoded, state = 1) {

  x <- decoded$state == state

  sum(diff(c(FALSE, x)) == 1)
}
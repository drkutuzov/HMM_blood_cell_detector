# HMM Blood Cell Detector

**Automatic detection of blood cells and estimation of capillary blood cell flux from two-photon microscopy images**

HMM Blood Cell Detector is an **R package** for automated analysis of two-photon microscopy (2PM) recordings of cerebral capillaries. The package uses Hidden Markov Models (HMMs) to identify blood cells in line-scan or frame-scan recordings and estimate blood cell flux through individual capillaries.

The package was developed for quantitative studies of cerebral microcirculation and endothelial glycocalyx function in vivo.

---

## Features

- Automatic detection of blood cells in 2PM recordings
- Hidden Markov Model (HMM)-based image analysis
- Estimation of capillary blood cell flux
- Visualization of image data and HMM state assignments
- Analysis of individual capillaries
- Designed for in vivo two-photon or confocal microscopy experiments

---

## Installation

Clone the repository

```bash
git clone https://github.com/drkutuzov/HMM_blood_cell_detector.git
cd HMM_blood_cell_detector
```

Install the required R packages and load the functions.

```R
source("R/hmm_detector.R")
```

(or install as an R package once packaged)

---

## Example workflow

```
Two-photon microscopy recording
              │
              ▼
      Image preprocessing
              │
              ▼
     Hidden Markov Model
              │
              ▼
 Blood cell detection
              │
              ▼
 Blood cell counting
              │
              ▼
 Capillary blood cell flux
```

---

## Repository structure

```
HMM_blood_cell_detector/
│
├── R/
│   ├── hmm_helpers.R
│
├── examples/
├── data/
├── README.md
```

---

## Applications

This package is intended for quantitative analysis of

- Cerebral microcirculation
- Capillary blood flow
- Blood cell flux
- Endothelial glycocalyx
- Blood–brain barrier physiology
- Neurovascular coupling
- In vivo two-photon microscopy

---

## Output

Typical outputs include

- Blood cell detections
- Hidden state assignments
- Blood cell counts
- Blood cell flux (cells/s)
- Publication-quality figures

---

## Author

**Nikolay Kutuzov**

Department of Neuroscience  
University of Copenhagen

GitHub: https://github.com/drkutuzov

---

## License

MIT License

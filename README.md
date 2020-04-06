# `cdc_statistics`: R-script to download CDC mortality data and make plots of the data including control plots for interpretability

This script performs the following actions:
- Downloads CDC mortality data (https://www.cdc.gov/flu/weekly/#S2).
- Concatenates weekly data release series and plots statistics from 2020 by week of release to show that users should not interpret dips or other oddities in most recent data points.
- Also plots mortality for all deaths, pneumonia-related, influenza-related, and pneumonia/influenza-related as a percent of all deaths.

To run, direct `R` to the repository root directory after downloading and type the below.

```R
source('cdc_statistics.R')
```

Below is an example output.

![image](https://user-images.githubusercontent.com/5241605/78589307-df483b80-77f4-11ea-928c-ecacda19e92f.png)
![image](https://user-images.githubusercontent.com/5241605/78589317-e5d6b300-77f4-11ea-9c64-5b90627978ca.png)

Notes:
- Open `cdc_statistics.R` to edit further from defaults as needed.
- The script will skip existing files during downloading.

## License

Biafra Ahanonu, PhD <bahanonu [at] alum [dot] mit [dot] edu>

This program is free software: you can redistribute it and/or modify it under the terms of the GNU. Attribution is appreciated, but not required, if parts of the software are used elsewhere.
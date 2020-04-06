# Biafra Ahanonu
# started:2020.04.06
# Script to download CDC total mortality and pneumonia/influenza statistics and plot the total per year along with showing the increased deaths as a function of reporting week
# Run by opening R or RStudio
# changelog
	#
# TODO
	#

# =====================
# CONSTANTS, change these as needed
# Path on computer where data will be saved
savePath = '_downloads\\';

# URL to download CDC data. NOTE that %s near the end indicates where a dynamic string will be place to download each data series
baseUrl = 'https://www.cdc.gov/flu/weekly/weeklyarchives2019-2020/data/NCHSData%s.csv';

# Current week
currentWeek = as.numeric(strftime(c(Sys.Date()), format = "%V"))-2;
	# currentWeek = 13;
# Current year
currentYear = 2020;
columnsToRemove = c("Expected","Threshold")

# Size of text for ggplot
axisTextSize = 20
defaultTextSize = 15

# =====================
# Load dependencies
srcFileList = c('helper.ggplot_themes.R')
lapply(srcFileList,FUN=function(file){source(file)})

packagesFileList = c("reshape2", "ggplot2","grid","gridExtra","ggthemes","RColorBrewer")
lapply(packagesFileList,FUN=function(file){if(!require(file,character.only = TRUE)){install.packages(file,dep=TRUE)}})

# =====================
# Format of imported CDC table data
# [1] "Year"
# [2] "Week"
# [3] "Percent.of.Deaths.Due.to.Pneumonia.and.Influenza"
# [4] "Expected"
# [5] "Threshold"
# [6] "All.Deaths"
# [7] "Pneumonia.Deaths"
# [8] "Influenza.Deaths"

# =====================
# Download and load the CDC data
# Weeks to download
urlList = c(1:currentWeek)
nLinks = length(urlList)

# Check download directory exists
if(dir.exists(savePath)==FALSE){
	dir.create(savePath)
}

for (fileNo in c(1:nLinks)) {
	if(fileNo<10){
		strNo = paste0('0',fileNo)
	}else{
		strNo = fileNo
	}

	# Download CDC data
	fileURL = sprintf(baseUrl,strNo)
	destfile = paste0(savePath,sprintf('NCHSData%s.csv',strNo))
	# Check file exists, if not then download
	if(!file.exists(destfile)){
		print(paste0('Download: ',fileURL,' | ',destfile))
		download.file(fileURL,destfile=destfile,quiet=TRUE,cacheOK = FALSE,method="curl")
	}

	# Load downloaded data into RAM
	filePath = destfile
	print(paste0('Loading: ',filePath))
	tableData = read.table(filePath,sep=',',header=T);
	tableData$CollectionSeries = sprintf('NCHSData%s',strNo)
	tableData$CollectionNo = fileNo
	if(fileNo>1){
		tableDataAll = rbind(tableDataAll,tableData)
	}else{
		tableDataAll = tableData
	}
	if(fileNo==nLinks){
		tableDataLatest = tableData
	}
}

# =====================
# Convert table into long data format to allow easy faceting, ONLY use the current year
tableDataAll$Year = as.character(tableDataAll$Year)
	tableDataAllMelt = melt(tableDataAll[tableDataAll$Year==currentYear,],id.vars=c("Year","Week","CollectionSeries","CollectionNo"))
	tableDataAllMelt$variable = gsub('\\.',' ',tableDataAllMelt$variable)
	tableDataAllMelt$variable = gsub(' to ',' to\n',tableDataAllMelt$variable)
	# Remove rows not informative to most users
	tableDataAllMelt = tableDataAllMelt[!(tableDataAllMelt$variable %in% columnsToRemove),]

# =====================
# Plot CDC data as a function of week data reported
newplot = ggplot(tableDataAllMelt,aes(Week,value,color=CollectionNo,group=CollectionNo))+
	geom_vline(xintercept=seq(4,currentWeek,4),color='black')+
	geom_line(size=2)+
	geom_point(size=2)+
	xlab('Week (1 = start of year)')+
	ylab('')+
	labs(color='Week data reported')+
	scale_x_continuous(breaks=seq(1,currentWeek,1))+
	# ggCustomColor(colourCount=14)+
	# ggCustomColorContinuous(lowColor="gray",midColor="blue",midpointH=currentWeek/2)+
	scale_colour_gradient2(low="gray", mid="blue", high="red",midpoint=currentWeek/2,limits = c(1,currentWeek),breaks=seq(1,currentWeek,1))+
	facet_wrap(~variable,scales="free_y")+
	ggtitle(sprintf('CDC total mortality by week data reported in %s | Black lines indicate every 4 weeks',currentYear))+
	ggThemeBlank(axisTextSize=axisTextSize,defaultTextSize=defaultTextSize)

dev.new(width=20,height=5)
print(newplot)

# =====================
# PLOT STATISTICS FOR ALL YEARS

# Convert most recent table into long format
tableData = tableDataLatest
	tableData$Year = as.character(tableData$Year)
	tableDataMelt = melt(tableData,id.vars=c("Year","Week","CollectionSeries","CollectionNo"))
	tableDataMelt$variable = gsub('\\.',' ',tableDataMelt$variable)
	tableDataMelt$variable = gsub(' to ',' to\n',tableDataMelt$variable)
	# Remove rows not informative to most users
	tableDataMelt = tableDataMelt[!(tableDataMelt$variable %in% columnsToRemove),]

# Plot all years in CDC dataset by various statistics
newplot = ggplot(tableDataMelt,aes(Week,value,color=Year,group=Year))+
	geom_vline(xintercept=seq(4,currentWeek,4),color='black')+
	geom_line(size=2)+
	xlab('Week (1 = start of year)')+
	ylab('')+
	scale_x_continuous(breaks=seq(1,52,6))+
	facet_wrap(~variable,scales="free_y")+
	ggCustomColor(colourCount=length(unique(tableDataLatest$Year))+1)+
	ggThemeBlank(axisTextSize=axisTextSize,defaultTextSize=defaultTextSize)

dev.new(width=20,height=5)
print(newplot)
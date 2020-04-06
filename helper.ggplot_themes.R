# Biafra Ahanonu
# Themes to add to ggplot
# started 2014.03.19

ggThemeBlank <- function(stripTextSize=20,stripYAngle = 270, axisTextSize = 25, defaultTextSize = 20, axisXAngle = 0, gridMajorColor = "transparent", gridMinorColor = "transparent", backgroundColor="white",plotBackgroundColor='white', borderColor = "transparent",xAxisAdj = 0.5, tickColor="black", tickSize = 0.5, tickWidth = 1, titleTextSize = 15, legendPosition="right", legendDirection="vertical",stripTextColor="black",axisTextColor="black", backgroundColorLine=NA,backgroundColorSize=1, axisLineColor="transparent", axisLineSize = 2){
	# font_import(pattern="[F/f]utura")
	# theme(text=element_text(size=16, family="Comic Sans MS"))
	# gridMajorColor = "#F0F0F0"
	theme(panel.background = element_rect(fill = backgroundColor, colour = NA),
		plot.background = element_rect(size=backgroundColorSize,linetype="solid",color=backgroundColorLine, fill = plotBackgroundColor),
		text = element_text(size=defaultTextSize),
		legend.text=element_text(size=defaultTextSize),
		legend.title=element_text(size=defaultTextSize),
		legend.key = element_blank(),
		legend.key.height=unit(1.5,"line"),
		legend.key.width=unit(1.5,"line"),
		legend.position=legendPosition,
		legend.direction = legendDirection,
		# strip.background = element_rect(fill = '#005FAD'),
		# strip.text.x = element_text(colour = 'white', angle = 0, size = stripTextSize, hjust = 0.5, vjust = 0.5, face = 'bold'),
		# strip.text.y = element_text(colour = 'white', angle = stripYAngle, size = stripTextSize, hjust = 0.5, vjust = 0.5, face = 'bold'),
		strip.background = element_rect(fill = 'white'),
		strip.text.x = element_text(colour = stripTextColor, angle = 0, size = stripTextSize, hjust = 0.5, vjust = 0.5, face = 'bold'),
		strip.text.y = element_text(colour = stripTextColor, angle = stripYAngle, size = stripTextSize, hjust = 0.5, vjust = 0.5, face = 'bold'),
		axis.text.x = element_text(colour=axisTextColor, size = axisTextSize, angle = axisXAngle, vjust = xAxisAdj,hjust = xAxisAdj),
		axis.text.y = element_text(colour=axisTextColor, size = axisTextSize),
		axis.title.y=element_text(vjust=1.6, size = axisTextSize,colour=axisTextColor),
		axis.title.x=element_text(vjust=0.2, size = axisTextSize,colour=axisTextColor),
		# axis.line = element_line(colour = axisLineColor),
		axis.line.x = element_line(color = axisLineColor, size = axisLineSize),
		axis.line.y = element_line(color = axisLineColor, size = axisLineSize),
		plot.title = element_text(vjust=1.4, size = titleTextSize),
		# axis.ticks.x = element_blank(),
		# axis.ticks.y = element_blank(),
		axis.ticks.x = element_line(color = tickColor, size = tickWidth),
		axis.ticks.y = element_line(color = tickColor, size = tickWidth),
		axis.ticks.length=unit(tickSize,"cm"),
		panel.grid.major = element_line(color = gridMajorColor),
		panel.grid.minor = element_line(color = gridMinorColor),
		panel.border = element_rect(fill = NA,colour = borderColor),
		panel.spacing=unit(1 , "lines"))
}
ggCustomColor <- function(palette="Set1",colourCount = 9,revList=FALSE,...){
	# Pastel1 also option
	if(colourCount<3){colourCount=3;}
	getPalette = colorRampPalette(brewer.pal(colourCount, palette))
	colorValues = getPalette(colourCount)
	if(revList==TRUE){
		colorValues = rev(colorValues)
	}
	return(scale_colour_manual(values = colorValues))
}
ggCustomColorContinuous <- function(midpointH=0,lowColor="white",midColor="gray",highColor="red",...){
	return(scale_colour_gradient2(low=lowColor, mid=midColor, high=highColor,midpoint=midpointH,limits = c(1,13),breaks=seq(1,13,1)))
}
# Prokudin-Gorsky
Project 1: Images of the Russian empire

main.m
Use this script to run the various below functions.

bfalign.m
BFALIGN Brute force alignment of images B, G, and R
	This function calculates the number images B and G must shift
   	both horizontally and vertically to align with image R using 
   	the sum of squared differences.

contrast.m
CONTRAST Adjusts the contrast of the input images.
   	This function uses imadjust to increase the 
    contrast of the input images.

crossalign.m
CROSSALIGN Alignment of images B, G, and R using normalized 
cross-correlation.
  	This function uses the normxcorr2 function built into
   	Matlab and finds the maximum correlation. It then finds
   	the difference between the current alignment and the 
   	alignment based on maximum correlation in order to shift
   	images B and G.

humantouch.m
HUMANTOUCH User alignment of input images.
   	This function prompts the user to select the location of
   	the same prominent feature on the three input images.
   	It then uses the pixel differences in these three locations
   	to align the images.

parbfalign.m (Incomplete)
PARBFALIGN Parallelized rute force alignment of images B, G, and R
	This function calculates the number images B and G must shift
   	in parallel both horizontally and vertically to align with image
   	R using the sum of squared differences.

pyramidalign.m
PYRAMIDALIGN Alignment of images B, G, and R using brute force
on smaller versions of oldB, oldG, and oldR and scaling up.
   	This function calculates the number of pixels images B 
   	and G must shift both horizontally and vertically to align
   	with image R. It uses brute force alignment on smaller 
   	versions of the images and refines the shift values as it
   	looks at larger and larger versions of the images.

ssd.m
SSD Returns sum of squared differences on input matrices



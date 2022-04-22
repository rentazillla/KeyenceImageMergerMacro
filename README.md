# KeyenceImageMergerMacro
Macro written in ImageJ ijm language for merging 4 channel z-stacks of Keyence images

Hi all,

I wrote the following to merge large numbers of four channel images taken using the Keyence BZ-X microscope: https://www.keyence.com/products/microscope/fluorescence-microscope/

Myself and others have found that the Keyence images are difficult to deal with in ImageJ, as four channels are converted to rgb, which requires opening and converting the fourth channel separately from channels 1 - 3.

This macro assumes that Ch1 is your green channel of interest, Ch2 is red, Ch3 is blue, and Ch4 is magenta (red plus blue). It will take a folder of given keyence rbg images saved with similar names and combine them to make 4 channel TIFF files.

Please let me know if you have any issues using it or any suggestions on how to improve it. I’d love feedback / ideas.

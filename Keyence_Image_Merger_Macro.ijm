// script to convert keyence images into stacked tiffs
// READ FIRST - this macros assumes you have z-stacks, 4 channels, with each chanel per z position saved as an rgb image
// actions:
// import all images in the input folder into Fiji
// deinterleave to create stacks of each channel separately
// the fourth channel must be made from two separate rgb stacks
// all stacks are converted to 8-bit depth
// then all stacks are combined into to a four channel hyperstack representing the final image

#@ File(label = "Input directory:", style = "directory") dir
#@ File(label = "Save directory:", style = "directory") out_dir
#@ String(label="Ch1 name", description="Target name in the first channel") ch1
#@ String(label="Ch2 name", description="Target name in the second channel") ch2
#@ String(label="Ch3 name", description="Target name in the third channel") ch3
#@ String(label="Ch4 name", description="Target name in the fourth channel") ch4
#@ String(label="File name to use when saving", description="Your name") file_name

channels = newArray("_CH1", "_CH2", "_CH3", "_CH4");
names = newArray(ch1, ch2, ch3, ch4);
for (i = 0; i < 4; i++) {
	args = "open=" + dir;
	args += " file=" + channels[i];
	args += " sort";

	run("Image Sequence...", args);
	temp = getTitle();
	run("Deinterleave", "how=3");
	if (i == 0) {
		selectImage(temp + " #1");
		close();
		selectImage(temp + " #3");
		close();
		selectImage(temp + " #2");
		rename(names[i]);
		// if you want another bit depth, change it
		run("8-bit");
		continue;
	} if (i == 1) {
		selectImage(temp +" #2");
		close();
		selectImage(temp +" #3");
		close();
		selectImage(temp +" #1");
		rename(names[i]);
		run("8-bit");
		continue;
	} if (i == 2) {
		selectImage(temp +" #1");
		close();
		selectImage(temp +" #2");
		close();
		selectImage(temp +" #3");
		rename(names[i]);
		run("8-bit");
		continue;
	} if (i == 3) {
		selectWindow(temp +" #2");
		close();
		run("Merge Channels...", "c1=["+ temp +" #1] c3=[" + temp +" #3] Composite create ignore");
		selectImage("Composite");
		run("RGB Color", "slices");
		rename(names[i]);
		run("8-bit");
		break;
	}
}

args = "c1=" + ch1;
args += " c2=" + ch2;
args += " c3=" + ch3;
args += " c4=" + names[i] + " create ignore";
run("Merge Channels...", args);
rename(file_name + "_Composite");


Stack.setXUnit("microns");


// channel properties to edit below
//args2 = "channels=4";
//args2 += " slices=" + (nSlices/4);
//args2 += " frames=1"
//args2 += " pixel_width=0.37742 pixel_height=0.37742 voxel_depth=0.7"
//run("Properties...", args2);
//c3=[" + temp +" #3]


// optional saving parameters
// remove the comment characters ('//') befor each line below to save outomatically
//saveAs("Tiff", out_dir + File.separator + file_name + "_Composite");
//File.makeDirectory(out_dir + File.separator + file_name);
//
//args3 = "dir=" + out_dir + File.separator + file_name;
//args3 += " format=" + "TIFF";
//args3 += " name=" + file_name;
//args3 += " digits=4";
//run("Image Sequence... ", args3);
//

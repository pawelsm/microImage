print("");
print("//");
print("choose source directory:");
Dialog.create("");
 Dialog.addMessage("choose source directory");
 Dialog.show();
 	dir1 = getDirectory("Choose Source Directory");
	print(dir1);

Dialog.create("");
 Dialog.addMessage("choose destination directory")
  Dialog.show();
print("choose destination directory:");
	dir2 = getDirectory("Choose Destination Directory");
	print(dir2);

tmp_3D = dir2+"tmp_3D"+File.separator;
  File.makeDirectory(tmp_3D);
  if (!File.exists(tmp_3D))
      exit("ERROR: Unable to create directory");
  print("directories created:");
  print(tmp_3D);
tmp_max_pro = dir2+"tmp_max_pro"+File.separator;
  File.makeDirectory(tmp_max_pro);
  if (!File.exists(tmp_max_pro))
      exit("ERROR: Unable to create directory");
  print(tmp_max_pro);
    print("");

title = "untitled";
max_pro = "untitled";
t = "10";
//ch = "1";

Dialog.create("output parameters");
  Dialog.addString("3D output file name:", title);
  Dialog.addString("max projection output file name:", max_pro);
  Dialog.addCheckbox("time stamp", true);
  Dialog.addNumber("time intervaln (min):", t);
//  Dialog.addNumber("Select channel:", ch);
  Dialog.show();
  title = Dialog.getString();
  max_pro = Dialog.getString();
  time_stamp = Dialog.getCheckbox();
  t = Dialog.getNumber();
//  ch = Dialog.getNumber();


  while (nImages>0) {
          selectImage(nImages);
          close();
  }

  
list1 = getFileList(dir1);
setBatchMode(true);
j=0;
for (i=0; i<list1.length; i++) {
	showProgress(i+1, list1.length);
	print("i="+i);
    "showProgress(i+1, list1.length);"
    filename = dir1 + list1[i];
    if (endsWith(filename, "oif")) {
    j++;
    print("j="+j);
    print(filename);
	print(lengthOf(filename));
    open(filename);
//    run("8-bit");

	run("Z Project...", "projection=[Max Intensity]");

	if (lengthOf(filename) > 2) {
		name = File.nameWithoutExtension;
		print(name);
		len = lengthOf(name);
		print(len);
		coreName = split(name, "\_");;
		
		indd = lengthOf(coreName)-1;

		print(indd);
		print(coreName[0]);//TODO
		print(coreName[indd]);//TODO
		nn = coreName[indd];//TODO
				
		if(lengthOf(nn)<3){
				newfilename = "0"+nn;
				print(newfilename);
		} 
		else {
				newfilename = nn;
		}
		print(newfilename);
						
		saveAs("Tiff", tmp_max_pro+newfilename);
	}
	close();
	}
	}
setBatchMode(false);
print("progress:");
print("done: maximum projection");

while (nImages>0) { 
          selectImage(nImages); 
          close(); 
	
}

list2= getFileList(tmp_max_pro);
setBatchMode(true);
for (i=0; i<list2.length; i++) {
    showProgress(i+1, list2.length);
    filename = tmp_max_pro + list2[i];
    if (endsWith(filename, "tif")) {
    open(filename);
    print(filename);
	}

	
	}
run("Concatenate...", "all_open title=[Concatenated Stacks]");
"saveAs(""Tiff"", dir2+max_pro);
"
setBatchMode(false);

print("done: concatenate maximum projection");

if (time_stamp == true);

//Stack.setChannel(ch);

Stack.setChannel(1);
run("Time Stamper", "starting=0 interval=t x=5 y=30 font=20 '00 decimal=0 anti-aliased or=min");
saveAs("avi", dir2+max_pro+"_1");
print("done: avi");

Stack.setChannel(2);
run("Time Stamper", "starting=0 interval=t x=5 y=30 font=20 '00 decimal=0 anti-aliased or=min");
saveAs("avi", dir2+max_pro+"_2");
print("done: avi");

Stack.setChannel(3);
run("Time Stamper", "starting=0 interval=t x=5 y=30 font=20 '00 decimal=0 anti-aliased or=min");
saveAs("avi", dir2+max_pro+"_3");
print("done: avi");
close();

while (nImages>0) { 
          selectImage(nImages); 
          close(); 
}

print("");
print("done");
print("//");
exit("DONE");

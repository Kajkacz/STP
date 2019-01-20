#!/usr/local/bin/perl -w

#Kajetan Kaczmarek, projekt 2
use warnings;
use strict;
use Getopt::Std;
use File::Find;

our($opt_f);
getopts('f:');
my $dir = $opt_f;
my $folder = "LatexImports";
my $MtLb = "MatlabFiles.txt";
my $images = "ImageFiles.txt";
if (!(-e $folder and -d $folder)) {
  system qq(mkdir  $folder);
}
system qq(touch $folder/$MtLb);
system qq(touch $folder/$images);
opendir DIR, $dir or die "cannot open dir $dir: $!";
#my @files= readdir DIR
my @files = glob "*.m";
open(my $MtLbHandle, ">", $folder.'/'.$MtLb)	or die "Can't open the log file: $!";
print $MtLbHandle "Matlab Files : \\\\\*\n";
foreach my $file (@files) {
  (my $fileName = $file )=~ s{\.[^.]+$}{} ;
  print $MtLbHandle "\n \\lstinputlisting{";
  print $MtLbHandle $file."} \n";
}
close $MtLbHandle;
closedir DIR;

open(my $IMGHandle, ">", $folder.'/'.$images)	or die "Can't open the log file: $!";
print $IMGHandle "Image Files : \n";
find(\&saveImageInput, $dir);
close $IMGHandle;

sub saveImageInput {
  if($_ =~ /.*\.bmp/ || $_ =~ /.*\.jpg/ || $_ =~ /.*\.png/ ){
    print $IMGHandle "\ \n \\includegraphics[width=\\linewidth]{$File::Find::name} \n" ;
  }
 }

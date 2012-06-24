#!/usr/bin/env perl
my $x;
my $wordsInSentence = 0;
my $totalWords = 0;
my $sentenceCount = 0;
my @lengthArray;
my $bigWords = 0;
while ($x = <>){
    $x =~ s/[.?!]/\./g;
    $x =~ s/[0-9]*//g;
    while($x =~ /(\w+|\.)/g){
	testSuffix("$1");
	if ("$1" eq "\."){
	    @lengthArray[$sentenceCount] = $wordsInSentence;
	    $wordsInSentence = 0;
	    $sentenceCount++;
	}
	else {
	    $totalWords++;
	    $wordsInSentence++;	    
	}
	#print $wordsInSentence, " ", $wordsInSentence," $1 ", "\n";
    }
}
my $avgLength = 0;
foreach $length (@lengthArray){
    $avgLength += $length;
#    print $length . "\n";
}
#print $avgLength . "\n";
$avgLength /= $sentenceCount;
#printf "%f\n", $avgLength;

sub testSuffix {
    my $var = shift;
    if($var =~ s/([a-zA-Z]*)es$/$1/g){
	return checkSyllables($1);
    }
    if($var =~ s/([a-zA-Z]*)ed$/$1/g){
	return checkSyllables($1);
    }
    if($var =~ s/([a-zA-Z]*)ing$/$1/g){
	return checkSyllables($1);
    }
    if($var =~ s/([a-zA-Z]*)ly$/$1/g){
	return checkSyllables($1);
    }
    else {
	return checkSyllables($1);
    }
}

sub checkSyllables {
    my $var = shift;
    if($var =~ s/.*[aeiouAEIOU]+.*[^aeiouAEIOU]+.*[aeiouAEIOU]+.*[^aeiouAEIOU]+.*[aeiouAEIOU]+.*//g){
	$bigWords++;
	return true;
    }
}

#print $bigWords . "\n";
#print $totalWords . "\n";
my $percentage = $bigWords / $totalWords * 100;
#print $percentage . "\n";
my $fogIndex = ($avgLength + $percentage) * .4;
print "Fog Index: ", $fogIndex . "\n";


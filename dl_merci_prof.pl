#!/usr/bin/perl

# Copyright (C) 2013 Matte Célestin

use strict;
use warnings;

use WWW::Mechanize;
use URI::Escape;

my $base_url = 'http://www.tv5.org';
my $url = "$base_url/cms/chaine-francophone/lf/Merci-Professeur/p-17081-Vision.htm?episode=0";
my $smil_url = "$base_url/data/tv5/emission/merciprof/smil/";
my $mp4_url = "http://vodhdflash.tv5monde.com/tv5mondeplus/hq/";
my $page;
my $completed = 0;
my $mech = WWW::Mechanize->new;
my $ans;
my $title = '';
my $nb_retry = 1000;

for (my $i = 0 ; $i < $nb_retry ; $i++) {
	print "Fetching file number $i...: ";
	$ans = $mech->get($url);
	if (!$ans->is_success) {
		print "Failed fetching base url\n";
		exit 1;
	}
	$page = $mech->content();

	# Get title
	if ($page =~ /'streamsense_jwp\.episodetitle': '(.*)',/) {
		$title = $1;
		$title = uri_unescape($title);
		$title =~ s/\+/ /g;
		print "$title\n";
	} else {
		print "Title not found\n";
		next;
	}

	# if file already exists, reload the page
	# tv5 randomly gives episode, *not* depending on episode number.
	# There is no better way to get all episode than to reload the page a
	# great number of times and hope we will have fetched all the videos
	# in the end...
	if ( -e "$title.mp4" ) {
		print "File already exists. Trying again...\n";
		next;
	}

	# fetch .smil file
	if ($page =~ /(\d+\.smil)/) {
		$ans = $mech->get($smil_url . $1);
		$page = $mech->content();
		if (!$ans->is_success) {
			print "Failed fetching .smil file: $1\n";
			next;
		}

		# Fetch .mp4 file
		if ($page =~ /(\d+\.mp4)/) {
			$ans = $mech->get($mp4_url . $1);
			if (!$ans->is_success) {
				print "Failed fetching .mp4 file: $1\n";
				next;
			}
			$mech->save_content($title . '.mp4');
			print "File $title.mp4 saved\n";
		} else {
			print "Failed finding the .mp4 file in the .smil file\n";
		}
	} else {
		print "No video found for this number, end of the script.\n";
	}
}

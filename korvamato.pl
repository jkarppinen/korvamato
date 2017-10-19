#!/etc/perl

use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
use warnings;

use Time::HiRes qw(usleep nanosleep);

$VERSION = '001';
%IRSSI = (
    authors     => 'Juhani Karppinen',
    contact     => 'jcara@IRCnet',
    name        => 'highlight',
    description => 'Bot for saving all annoying songs from YouTube for later use.',
    license     => 'GNU GPL v3.0 or later' );

# Set absolute home path
my $chatchannel = "#your_channel_here";
# Set path to text file where URLs are saved
my $file = "/home/path/to/.irssi/scripts/korvamato.txt";

sub korvamato {
	my ($server,$msg,$target, $channel, $chatnet) = @_;
	$_ = $msg;
	if ($chatnet eq $chatchannel) {
		if(/^!korvamato add /i) {
			my @in = split / /, $msg;
			my $size = scalar @in;
			my $output = "";

			if($size > 2) {
				if(/http.*yout*/i) {
					`echo "$in[2]" >> $file`;
					$server->command("msg $chatnet $target: korvamato lisätty!");
				}
				else {
					$server->command("msg $chatnet $target: YouTube url pls :(");
				}
			}

		}
		elsif(/^!korvamato/i) {
			my $korvamato = `cat $file | shuf | uniq | head -1`;
			$server->command("msg $chatnet Korvamato: $korvamato");
		}
	}
}

Irssi::signal_add('message public','korvamato');

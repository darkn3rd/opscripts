###############################################################
# DailyEvts.pl - gathers error/warning events through Win2k3
#   tools and mails them to users
#
#  (c) 2005 Joaquin Menchaca
#
#  Authors:
#    jm    Joaquin Menchaca
#  Change History
#   20050107  document creation
#   20050120  added mail functionality, modularized
#   20050124  added CLI argument support
#
###############################################################
use strict;
use Net::SMTP;
 
my (@computers, %computers);
my $domain = "contoso.com"
my $mailsrvr = "mailex01"
 
##### set the default scripting mode to console
system('CSCRIPT //H:CSCRIPT //s > NULL');
 
##### get arguments and set defaults
die "Invalid Arguments" if @ARGV < 3;
my $watchset = $ARGV[0];
my $emailset = $ARGV[1];
my $mode     = $ARGV[2] || "server";
my $subject = "Daily Event Report - " . $ARGV[2];
 
 
##### format of date for eventquery    
my ($mday, $mon, $year) = (localtime (time))[3..5];
$year+=1900;
$mon++;
$mday--; # get yesterday
my $datestr = "\"Datetime gt $mon/$mday/$year,12:00:00AM\"";
# generic log types for eventquery
my @logtypes;
 
if ($mode eq "server") {
 
    @logtypes = ('application',
                 'system',
                 '"dns server"',
                 '"directory service"',
                 '"file replication service"');
}
else { @logtypes = ('application', 'system'); }
 
##### acquire list of computers from hand crafted file
open (COMPUTERS, $watchset) || die "ERROR: Could not read $!\n";
@computers=<COMPUTERS>;          # save list of computers to scan
close(COMPUTERS);                   # close file
 
##### output the results
$computers{$_} = getevents($_) foreach (@computers);
mailevents(\%computers);
 
###############################################################
#  mailevents() - generates report and mails output.
###############################################################
sub mailevents {
    my $compref = shift;
    my $output  = buildoutput($compref);
    my ($addresses, $sender, @addresses) = ("", "administrator\@$domain");
 
    ##### acquire list of mail addresses from hand crafted file
    open (MAILADDR, $emailset) || die "ERROR: Could not read $!\n";
    #foreach (<MAILADDR>) { chomp; push (@addresses, $_); }
    @addresses = map { chomp; $_ } <MAILADDR>;
    close(MAILADDR);
     
    ##### configure mail server
    my $smtp = Net::SMTP->new($mailsrvr)  || die "Bad mail server\n";
     
    $smtp->mail($sender);
    $smtp->recipient(@addresses);
    $smtp->data();
 
    $addresses = join(", ", @addresses);
    $smtp->datasend("To: $addresses");
    $smtp->datasend("From: $sender\n");
    $smtp->datasend("Priority: Urgent\n");
    $smtp->datasend("Importance: high\n");
    $smtp->datasend("Subject: $subject\n\n");
    $smtp->datasend($output);
 
    $smtp->dataend();
    $smtp->quit();
}
 
###############################################################
#  buildoutput() - generates output string from hash of
#       computers/events
###############################################################
sub buildoutput {
    my $compref = shift;
    my ($output, $computer, $evtcat, $event) = "";
         
    foreach $computer (keys %$compref) {
        $output .= "$computer\n";
        $output .= "=" x length $computer;
        $output .= "\n";
         
        foreach $evtcat (sort keys %{$compref->{$computer}}) {
            next unless (@{$compref->{$computer}{$evtcat}} gt 0);
             
            $output .= "   $evtcat\n   ";
            $output .= "-" x length $evtcat;
            $output .= "\n";
             
            foreach $event (@{$compref->{$computer}{$evtcat}}) {
                $output .= "      $event\n";
            }
            $output .= "\n";
        }
        $output .= "\n";
    }
     
    return $output                
}
 
 
###############################################################
#  getevents() - creates a hash containing all the
#      warning and error events
###############################################################
sub getevents {
    chomp $_[0];                        # delete new line character
    my $system = shift;
    my ($logtype, @events, %events);
     
    foreach $logtype (@logtypes) {
       my $querystr = "eventquery /v /s $system /fi $datestr /l $logtype";
       queryevent($querystr, "Warning", \@events);
       queryevent($querystr, "Error", \@events);
       $logtype =~ tr|"||d;
       $events{$logtype} = [@events];
       @events = ();
    }
     
    return {%events};
}
 
###############################################################
#  queryevent() - given the query string, type of event, and
#      ref to list, queries the events.  Data returned in ref
#      to list.
###############################################################
sub queryevent {    
    my ($querystr, $type, $events) = @_;
    my ($entry);
     
    $querystr .= " /fi \"Type eq $type\"";   # reformat w/ approp. type
     
    open (EVTQUERY, "$querystr 2>&1 |");     # execute query
 
    foreach $entry (<EVTQUERY>)
    {
        next if $entry !~ m/^\s*${type}/i;   # skip invalid types
        push(@$events, $entry);              # insert entry into array
    }
     
    close (EVTQUERY);
}

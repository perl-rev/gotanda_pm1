#!/WWW/sfw/linux6/perl5/5.16/bin/perl
########################################################################
# @par  Client Name
#   社用
# @par  System Name
#   サンプルプログラム
# @brief
# @par   File Code
#   UTF8
# @par   修正履歴
# version 1.0.0 :  2014.06.14 (YU) New Create @n
########################################################################
use lib "/WWW/sfw/linux6/perl5/5.16/local/lib/perl5";
use warnings;
use strict;
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
use Data::Dumper;
our $unit_env = &unit_info_get;

########################################################################
#   各種事前処理
########################################################################
my $com = $ARGV[0];
my $INC = "/WWW/sfw/linux6/perl5/5.16/local/lib/perl5"; 
my $lib="./../perl/lib";

if (!$com){ 
	print "command not found !"."\n";
	exit;
}elsif ($com eq 'h' || $com eq 'h') {
	&disp_usage();
}

my $rtn = system("prove -fcr -I$lib --timer --trap $com");

########################################################################
#   各種事前処理
########################################################################
sub disp_usage {
	print 'Usage:'."\n";
	print ' ./test_runner.pl [options] [files or directories]'."\n";
	print "\n";
	print ' if no arguments then target dir is current'."\n";
	print "\n";
	exit;
}

########################################################################
#	unit_info_get : 環境情報ファイルから設定情報の取得
########################################################################
sub unit_info_get {
	my ( %unit_env );

	#--- 環境情報ファイルパス ---#
	my $unit_env_file = "./unit_env2.txt";    #mg_env形式、あとで調整
	if ( -s $unit_env_file ) {
		if ( open(IN,"$unit_env_file") ) {
			binmode(IN, ":utf8");
			while ( <IN> ) {
				chomp;
				if ( $_ !~ /^#/ && length($_) > 0 ) {
					$_ =~ s/#.+$//ig;				# ＃以降削除
					$_ =~ s/\s+$//ig;				# 末尾スペース削除
					my ($n,$v) = split(/=/);
					$unit_env{$n} = $v;
				}
			}
			close IN;
		}
	}
	return ( \%unit_env );
}

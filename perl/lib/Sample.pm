use strict;
use warnings;
use utf8;

use Util;

package Sample {

	sub new { bless {}, shift }

	sub execute(){
		my $self = shift;

		my $sql = 'select name , old from sample order by old ';

		# TODO DB接続情報
		my ( $host, $dbname, $user, $passwd ) = ( 'localhost', 'perl_rev', 'perl_rev', 'perl_revp' );
		my $dbh = Util->db_connect( $host, $dbname, $user, $passwd );

		my ( $sth, $errstr, $warnings_cnt, $warnings );

		my ( $sth, $errstr ) = Util->db_access( $dbh, $sql );

		if( $errstr ){ return; } # すみません、エラーハンドリングは後日。。

		my @array;

		while ( my $hash_ref = $sth->fetchrow_hashref() ){

			push @array, $hash_ref;

		}

		$sth->finish();

		my %dto;
		$dto{'records'} = \@array;
		$dto{'title'} = '五反田pm がんばりましょう';
		return \%dto;
	}
}

1;

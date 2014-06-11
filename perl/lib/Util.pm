use strict;
use warnings;
use utf8;
use DBD::mysql;

package Util {

	sub db_connect(){

		my $self = shift; 
		my ( $dbhost, $dbname, $dbuser, $dbpass ) = @_;

		if( defined( $ENV{'UNIT_TEST_FLG'} ) && $ENV{'UNIT_TEST_FLG'} eq 'ON' ){
			# ユニットテスト用の設定を読み込み
			$dbhost = $ENV{'DB_UNIT_HOST'};
			$dbname = $ENV{'DB_UNIT_NAME'};
			$dbuser = $ENV{'DB_UNIT_USER'};
			$dbpass = $ENV{'DB_UNIT_PASS'};
		}
		my $dbh = DBI->connect( "DBI:mysql:$dbname:$dbhost", $dbuser, $dbpass );


		return $dbh;
	}

	sub db_access(){

		my ( $self, $dbh, $sql ) = @_;
		my ( $sth, $errstr );

		if( !( ( $sth = $dbh->prepare("$sql") ) && ( $sth->execute ) ) ) {

			$errstr = $dbh->errstr;
		}

		return ( $sth, $errstr );
	}
}

1;

use strict;
use warnings;
use utf8;
use DBD::mysql;

package Util {

	sub db_connect(){
		my ( $self, $host, $dbname, $user, $passwd ) = @_;
		my $dbh = DBI->connect( "DBI:mysql:$dbname:$host", $user, $passwd );


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

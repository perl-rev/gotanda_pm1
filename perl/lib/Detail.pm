use strict;
use warnings;
use utf8;
use Util;

package Detail {

	sub new { bless {}, shift }

	sub get(){
		my $self = shift;

		#DB接続情報
		my ( $host, $dbname, $user, $passwd ) = ( 'localhost', 'perl_rev_unit4', 'perl_rev_unit4', 'perl_rev_unit4p' );
		#DB接続
		my $dbh = Util->db_connect( $host, $dbname, $user, $passwd );
		my ( $sql,$sth, $errstr, $warnings_cnt, $warnings );
		#表示用ハッシュ
		my %disp;
		#記事詳細取得
		$sql = 'select article_text from article_main where seq = 1';#.$dbh->quote($self->param('seq'));
		( $sth, $errstr ) = Util->db_access( $dbh, $sql );

		if( $errstr ){ return; } # すみません、エラーハンドリングは後日。。


		if ( my $hash_ref = $sth->fetchrow_hashref() ){

			$disp{'article_text'} = $hash_ref->{'article_text'};	

		}

		$sth->finish();


		#コメント情報取得
		$sql = 'select coment_content from comment_table where article_main_seq = 1 order by post_time desc ';
		( $sth, $errstr ) = Util->db_access( $dbh, $sql );

		if( $errstr ){ return; } # すみません、エラーハンドリングは後日。。

		my @array;

		while ( my $hash_ref = $sth->fetchrow_hashref() ){

			push @array, $hash_ref;

		}

		$sth->finish();

		$disp{'records'} = \@array;
		$disp{'title'} = '五反田pm がんばりましょう';
		return \%disp;
	}
}

1;

#############################################
#   ユニットテスト用の共通クラス
#       テストは、これを継承して作成。
#       以下のメソッドを保持。
#       ・データ投入
#       ・ロギング
#
#############################################

use strict;
use warnings;

package Unit_Base{

use base qw(Test::Class);
use Test::More;
use utf8;
use Encode;

use Util;


sub inittest:Test(setup){
	my $self = shift;

	# 品目ごとのマスターデータのセット等
}

# DBにテストデータをいれる
# ↓のようなハッシュをうけとる。
#	my $sample_tbl_data =
#	{
#		sample => [  # テーブル名
#			{ seq => '1', name=> 'sakupan', old => '24' },
#			{ seq => '2', name=> 'saito'  , old => '27' },
#			{ seq => '3', name=> 'naito'  , old => '26' },
#		],
#	};
#
# TODO データを入れれない場合のハンドリングなど
sub setup_db(){
	my $self = shift;
	my ( $test_data ) = @_;
	
	my $dbh = Util->db_connect();

	$self->log("data input start -----------------------------");
	# テーブルごとにデータを削除し、インサートし直す
	while ( my ( $tablename, $records ) = each %$test_data ){

		$self->log("$tablename data input");

		# 対象テーブルのデータを削除
		my $delete_sql = "truncate table $tablename";
		$self->log($delete_sql);
		Util->db_access( $dbh, $delete_sql);

		# １件ごとにinsert
		foreach my $record (@$records){

			my @columns;
			my @values;

			while ( my ( $columnname, $value ) = each %$record ){
				push @columns, $columnname;
				push @values , "'$value'";
			}

			my $inser_sql = "insert into $tablename ( "
				 . join( ',', @columns ) . ' ) values ( ' . join( ',', @values ) . ' )';
			$self->log($inser_sql);
			Util->db_access( $dbh, $inser_sql );

		}
	}	

	$self->log("data input end -----------------------------");

}

# ログレベルまでは設定できなくていいかな。
sub log(){

	my $self = shift;
	my ($msg, $loggfile) = @_;
	
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);  
	my $logdate = sprintf("%04d/%02d/%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

	$msg = "$logdate $msg";
	$msg = encode( 'utf-8', $msg );

	diag $msg;

}



}

1

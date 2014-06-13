################################################
#       Test::More 版 サンプルテスト
###############################################


use Test::More;
use utf8;

use Util;
use Sample;

&log( 'test start -----------------------------' );

# 正常系1
&testExecuteSelect();


# TODO 異常系 DB つながらない場合とか

done_testing();

# execute()のテスト
# セレクトした結果が以下の通り想定通りかテスト
# 取得条件
# 　・old >= 25
# ソート順
# 　・old asc
sub testExecuteSelect(){

	# テストデータ投入
	# TODO この辺は、Excelのマクロとかで
	# ハッシュを自動生成してコピペできるようにしたいな。。だれか・・・。
	# データ量が多いと外だしも検討。
	my $sample_tbl_data =
	{
		sample => [  # テーブル名
			{ seq => '1', name=> 'sakupan', old => '24' }, # 25才以下は取得されない
			{ seq => '2', name=> 'saito'  , old => '27' }, # 取得される
			{ seq => '3', name=> 'naito'  , old => '26' }, # 取得される
		],
	};

	&setup_db( $sample_tbl_data );

	# テスト対象オブジェクト取得
	my $sample = Sample->new();
	# テスト対象メソッドを実行
	my $sample_result = $sample->execute();

	# 以下 実行結果のassert --------------------------------------

	# タイトルのチェック
	is $sample_result->{'title'}, '五反田pm がんばりましょう';

	my $records = $sample_result->{'records'};

	# 件数
	my $cnt = @{$records};
	is $cnt, 2;

	# 1レコード目のチェック
	my $record1 = @{$records}[0];
	is $record1->{'name'}, 'naito';		# 名前
	is $record1->{'old'} , '26';		# 年齢

	# 2レコード目のチェック
	my $record2 = @{$records}[1];
	is $record2->{'name'}, 'saito';		# 名前
	is $record2->{'old'} , '27';		# 年齢

}


# ここから下は共通ファイルにもたせる予定


sub setup_db(){
	my ( $test_data ) = @_;
	
	my $dbh = Util->db_connect();

	&log("data input start -----------------------------");
	# テーブルごとにデータを削除し、インサートし直す
	while ( my ( $tablename, $records ) = each %$test_data ){

		&log("$tablename data input");

		# 対象テーブルのデータを削除
		my $delete_sql = "truncate table $tablename";
		&log($delete_sql);
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
			&log($inser_sql);
			Util->db_access( $dbh, $inser_sql );

		}
	}	

	&log("data input end -----------------------------");

}

# ログレベルまでは設定できなくていいかな。
sub log(){

	my ($msg, $loggfile) = @_;
	
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);  
	my $logdate = sprintf("%04d/%02d/%02d %02d:%02d:%02d", $year + 1900, $mon + 1, $mday, $hour, $min, $sec);

	$msg = "$logdate $msg";

	diag $msg;

}

######################################################################
#   Test::Calss 版 サンプルテスト
#       ・Testアトリビュートがついているメソッドが自動で実行される
#       　引数は、テスト件数を指定する場合に設定可能だが、
#       　テストをなおすたびに毎回修正は手間なのでno_planでもOK。
#
#       ・Unit_Test_Baseを継承すること。
#
#       ・何のテストをしているかわかりやすいように、テストケースをファイルの上部に記述し、
#       　長くなる詳細部分はファイルの下のほうに分けてかく。
#
#####################################################################

use strict;
use warnings;

# テストを走らせるおまじない
Sample::Test->runtests();

package Sample::Test{ # ひとまず、テスト対象モジュール名::Test

use base qw(Unit_Base);
use Test::More;
use utf8;

use Util;
use Sample;

# テストごとに毎回呼ばれる。共通データの削除や、
# データのクリーンアップ等が必要な場合に使う
sub setup:Test(setup){}


# 正常系1
# execute()のテスト
# セレクトした結果が以下の通り想定通りかテスト
# 取得条件
# 　・old >= 25
# ソート順
# 　・old asc
sub test1:Test(no_plan){ 

	my $self = shift;
	$self->testExecuteSelect();
}

# TODO 異常系 DB つながらない場合とか
sub testErrorNoconnectDB:Test(no_plan){

	my $self = shift;
	#$self->testExecuteError1();
}



# 正常系1 詳細
sub testExecuteSelect(){

	my $self = shift;

	$self->log( "正常系1　開始");

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

	$self->setup_db( $sample_tbl_data );

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

	$self->log( "正常系1　終了");
}


}
1

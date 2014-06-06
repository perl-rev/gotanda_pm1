use Test::More;
use utf8;

use Util;
use Sample;


# 正常系1
&testExecuteSelect();


# TODO 異常系

done_testing();

# execute()のテスト
# セレクトした結果が想定通りかテスト
sub testExecuteSelect(){

	# TODO テストデータ投入

	my $sample = Sample->new();
	my $sample_result = $sample->execute();

	# タイトルのチェック
	is $sample_result->{'title'}, '五反田pm がんばりましょう';


	my $records = $sample_result->{'records'};

	# 件数
	my $cnt = @{$records};
	is $cnt, 2;

	# 1レコード目のチェック
	my $record1 = @{$records}[0];
	is $record1->{'name'}, 'saito'; # 名前
	is $record1->{'old'} , '5';	# 年齢

	# 2レコード目のチェック
	my $record2 = @{$records}[1];
	is $record2->{'name'}, 'sakupan';	# 名前
	is $record2->{'old'} , '6';		# 年齢

}



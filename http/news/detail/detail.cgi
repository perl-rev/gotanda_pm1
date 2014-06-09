#!/WWW/sfw/linux6/perl5/5.16/bin/perl
#---------------------------------------------------------------------------
# モジュール関連
#---------------------------------------------------------------------------
use lib '/WWW/sfw/linux6/perl5/5.16/local/lib/perl5';
use lib $ENV{'DOCUMENT_ROOT'} . "/../perl/lib/";
use Mojolicious::Lite;
use utf8;
use Detail;
use Data::Dumper;#debug#
#---------------------------------------------------------------------------
# main
#---------------------------------------------------------------------------
get '/' => sub {
	my $self = shift;

	my $comment_model = Detail->new();
	my $dto = $comment_model->get($self);

	$self->stash( records => $dto->{"records"} );
	$self->stash( article_text => $dto->{"article_text"} );
	$self->stash( title => $dto->{"title"} );
	$self->render('sample');
};

app->start;

__DATA__

@@ sample.html.ep
% layout 'default';
% title 'Sample';

<p>詳細記事内容</p>
<%= $article_text %>

% for my $hash_ref (@{$records}){
    <p>コメント内容：<%= $hash_ref->{'coment_content'} %></p>
%}
<br>たいとる：<%= $title %>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>

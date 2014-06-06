#!/WWW/sfw/linux5/perl5/5.16/bin/perl

#---------------------------------------------------------------------------
# サンプル
#---------------------------------------------------------------------------

use lib $ENV{'DOCUMENT_ROOT'} . "/../perl/lib/";

use Mojolicious::Lite;

use Data::Dumper;
use utf8;

use Sample;

get '/' => sub {
	my $self = shift;

	my $model = Sample->new();
	my $dto = $model->execute();

	$self->stash( records => $dto->{"records"} );
	$self->render('sample');
};

app->start;
__DATA__

@@ sample.html.ep
% layout 'default';
% title 'Sample';
DB の中身
% for my $hash_ref (@{$records}){
    <p><%= $hash_ref->{'name'} %></p>
%}

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>

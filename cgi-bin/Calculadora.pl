#!/usr/bin/perl
use strict;
use warnings;
use CGI ':standard';

print header();

my $query = CGI->new;
my $operacion = $query->param('operacion');

print "<html><body>";
print "<h1>Resultado</h1>";

# Expresión regular para identificar números y operadores básicos
if ($operacion =~ /^(\d+)([+\-*\/])(\d+)$/) {
    my ($num1, $op, $num2) = ($1, $2, $3);
    print "<p>Primer operando: $num1</p>";
    print "<p>Operador: $op</p>";
    print "<p>Segundo operando: $num2</p>";
} else {
    print "<p>Operación inválida.</p>";
}

print "</body></html>";

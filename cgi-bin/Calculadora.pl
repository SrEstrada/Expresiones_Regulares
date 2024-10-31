#!/usr/bin/perl
use strict;
use warnings;
use CGI ':standard';

print header();

my $query = CGI->new;
my $operacion = $query->param('operacion');

print "<html><body>";
print "<h1>Resultado</h1>";

# Verificamos que solo se usen caracteres válidos
if ($operacion =~ /^[\d+\-*\/\(\)\s]+$/) {
    # Expresión regular para identificar números y operadores básicos
    if ($operacion =~ /^(\d+)([+\-*\/])(\d+)$/) {
        my ($num1, $op, $num2) = ($1, $2, $3);
        my $resultado;

        # Realizar la operación de acuerdo al operador
        if ($op eq '+') {
            $resultado = $num1 + $num2;
        } elsif ($op eq '-') {
            $resultado = $num1 - $num2;
        }

        # Mostrar el resultado
        print "<p>Operación: $operacion</p>";
        print "<p>Resultado: $resultado</p>";
    } else {
        print "<p>Operación inválida.</p>";
    }
} else {
    print "<p>Error: La operación contiene caracteres no válidos.</p>";
}

print "</body></html>";

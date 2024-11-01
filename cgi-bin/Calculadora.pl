#!/usr/bin/perl
use strict;
use warnings;
use CGI ':standard';

print header();

my $query = CGI->new;
my $operacion = $query->param('operacion');
# Eliminación de espacios en blanco
$operacion =~ s/\s+//g;

print "<html><body>";
print "<h1>Resultado</h1>";

# Validación de caracteres permitidos
if ($operacion =~ /^[\d+\-*\/\(\)\s]+$/) {
    # Expresión regular para identificar números y operadores
    if ($operacion =~ /^(\d+)([+\-*\/])(\d+)$/) {
        my ($num1, $op, $num2) = ($1, $2, $3);
        my $resultado;

        if ($op eq '+') {
            $resultado = $num1 + $num2;
        } elsif ($op eq '-') {
            $resultado = $num1 - $num2;
        } elsif ($op eq '*') {
            $resultado = $num1 * $num2;
        } elsif ($op eq '/') {
            if ($num2 == 0) {
                $resultado = "Error: División por cero";
            } else {
                $resultado = $num1 / $num2;
            }
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

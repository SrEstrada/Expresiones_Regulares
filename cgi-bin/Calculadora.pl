#!/usr/bin/perl
use strict;
use warnings;
use CGI ':standard';

print header();

my $query = CGI->new;
my $operacion = $query->param('operacion');
$operacion =~ s/\s+//g;

print "<html><body>";
print "<h1>Resultado</h1>";

# Validación de caracteres permitidos
if ($operacion =~ /^[\d+\-*\/\(\)\s]+$/) {
    # Verificar formato inicial y final y balanceo de paréntesis
    if ($operacion =~ /^[\+\-*\/]/ || $operacion =~ /[\+\-*\/]$/ || $operacion =~ /\(\)/ || $operacion =~ /[\+\-\*\/]{2,}/) {
        print "<p>Error: Operación mal formada (operadores consecutivos, inicio o fin inválido, paréntesis vacíos).</p>";
    } 
    # Evaluar con `eval` si hay paréntesis
    elsif ($operacion =~ /[\(\)]/) {
        my $resultado = eval $operacion;
        if ($@) {
            print "<p>Error en la expresión: $@</p>";
        } else {
            print "<p>Operación: $operacion</p>";
            print "<p>Resultado: $resultado</p>";
        }
    }
    # Para operaciones simples
    elsif ($operacion =~ /^(\d+)([+\-*\/])(\d+)$/) {
        my ($num1, $op, $num2) = ($1, $2, $3);
        my $resultado;

        if ($op eq '+') {
            $resultado = $num1 + $num2;
        } elsif ($op eq '-') {
            $resultado = $num1 - $num2;
        } elsif ($op eq '*') {
            $resultado = $num1 * $num2;
        } elsif ($op eq '/') {
            $resultado = $num2 == 0 ? "Error: División por cero" : $num1 / $num2;
        }

        print "<p>Operación: $operacion</p>";
        print "<p>Resultado: $resultado</p>";
    } else {
        print "<p>Operación inválida.</p>";
    }
} else {
    print "<p>Error: La operación contiene caracteres no válidos.</p>";
}

print "</body></html>";

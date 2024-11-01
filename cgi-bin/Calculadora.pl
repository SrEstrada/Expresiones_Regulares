#!/usr/bin/perl
use strict;
use warnings;
use CGI ':standard';

print header();

my $query = CGI->new;
my $operacion = $query->param('operacion');
$operacion =~ s/\s+//g;  # Eliminación de espacios en blanco

print "<html><body>";
print "<h1>Resultado</h1>";

# Validación de caracteres permitidos y formato correcto
if ($operacion =~ /^[\d+\-*\/\(\)\s]+$/) {
    # Verificar si hay operadores consecutivos o paréntesis desbalanceados
    if ($operacion =~ /[\+\-\*\/]{2,}/ || $operacion =~ /\(\)/) {
        print "<p>Error: Operación mal formada (operadores consecutivos o paréntesis vacíos).</p>";
    }
    # Detectar paréntesis y evaluar con `eval` solo si es necesario
    elsif ($operacion =~ /[\(\)]/) {
        my $resultado = eval $operacion;
        if ($@) {
            print "<p>Error en la expresión: $@</p>";
        } else {
            print "<p>Operación: $operacion</p>";
            print "<p>Resultado: $resultado</p>";
        }
    }
    # Caso de una operación simple de dos operandos
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
            if ($num2 == 0) {
                $resultado = "Error: División por cero";
            } else {
                $resultado = $num1 / $num2;
            }
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

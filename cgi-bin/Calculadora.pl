#!/usr/bin/perl
use strict;
use warnings;
use CGI ':standard';

print header();

# Configuración para recibir la operación
my $query = CGI->new;
my $operacion = $query->param('operacion');

# Mostrar un mensaje de prueba
print "<html><body>";
print "<h1>Resultado</h1>";
print "<p>Operación recibida: $operacion</p>";
print "</body></html>";

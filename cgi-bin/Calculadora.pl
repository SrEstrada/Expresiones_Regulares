#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;

my $q = CGI->new;

# Subrutina principal que maneja la lógica de la calculadora
sub contenido {
    my $operacion = $q->param('operacion') // '';
    my $resultado;

    if (defined $operacion && $operacion ne '') {
        # Validación de caracteres permitidos en la operación
        if ($operacion =~ /^[\d\+\-\*\/\(\) ]+$/) {
            # Intentar evaluar la operación con `eval`
            eval {
                $resultado = eval $operacion;
            };
            if ($@) {
                $resultado = "Error en la expresión: $@";
            }
        } else {
            $resultado = "Expresión no válida: solo se permiten números y operadores.";
        }
    } else {
        $resultado = "No se ha ingresado ninguna expresión.";
    }
    
    return generarHTML($operacion, $resultado);
}

# Subrutina que genera el HTML
sub generarHTML {
    my ($operacion, $resultado) = @_;
    
    print $q->header('text/html; charset=UTF-8');
    print <<"HTML";
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Calculadora</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="calculadora">
        <h1>Calculadora</h1>
        <form action="/cgi-bin/calcular.pl" method="post">
            <input type="text" name="operacion" placeholder="Ingrese expresión" value="$operacion" required>
            <button type="submit">Calcular</button>
        </form>
    </div>
HTML

    if (defined $resultado) {
        print "<h2>Resultado: $resultado</h2>";
    }

    print "</body></html>";
}

# Llamar a la subrutina principal
contenido();

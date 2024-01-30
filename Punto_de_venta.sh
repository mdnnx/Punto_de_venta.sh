#Script de prueba para llevar el inventario, ventas y compras de una tienda
#by Armin van mont
#Colores
ColorVerde="\e[0;32m\033[1m"
FinColor="\033[0m\e[0m"
ColorRojo="\e[0;31m\033[1m"
ColorAzul="\e[0;34m\033[1m"
ColorAmarillo="\e[0;33m\033[1m"
ColorMorado="\e[0;35m\033[1m"
ColorTurquesa="\e[0;36m\033[1m"
ColorGris="\e[0;32m\033[1m"
BTC="https://www.google.com/finance/quote/BTC-MXN?sa=X&ved=2ahUKEwjpxvX-pJWDAxUvLkQIHTKfAugQ-fUHegQIFRAi"
function Bienvenido {
        clear
        for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
	echo -e "\n${ColorAmarillo}\n\tBienvenido a \n\t\t
        S C R I P T   P U N T O   D E   V E N T A${FinColor}\n"
        for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
        echo -e "\n\n\t${ColorMorado}Deseas comenzar ?${FinColor}"          
	echo -e "\n\n\t${ColorRojo}1 ) Si${FinColor}"      
	echo -e " \n\n\t${ColorRojo}2 ) Salir${FinColor}\n\n\t"
        echo -e " \n\n\t${ColorRojo}3 ) Precio Bitcoin${FinColor}\n\n\t"         
	read -p "Has una eleccion: " opt
        case $opt in          
		"1") Main ;;
                "2") exit ;;
                "3") PrecioBTC ;;
                * ) 
                        echo "Eleccion no reconocida por favor intentalo otra vez";;   
        esac
}
function Main {
        clear  
	for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
	echo -e "\n${ColorAmarillo}\n\t\t\tM E N  U   P R I N C I P A L${FinColor}\n"    
	for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
	echo -e "\n\n\t${ColorRojo}1 ) Configuracion ( solo personal autorizado )${FinColor}"  
	echo -e "\n\n\t${ColorRojo}2 ) Iniciar dia laboral${FinColor}"  
	echo -e "\n\n\t${ColorRojo}3 ) Salir\n\n${FinColor}"
        read -p "Has una eleccion: " opt     
	case $opt in       
		"1") Configuracion ;;   
		"2") Iniciar_dia_laboral ;;  
		"3") exit ;;      
	esac    
}
function Iniciar_dia_laboral {
	clear
	echo "Fecha"
	read Fecha
	sqlite3 $Fecha.db << EOF       
	CREATE TABLE IF NOT EXISTS Ventas (         
	Producto TEXT NOT NULL,  
	Cantidad_vendida INT NOT NULL,
	Beneficio INT NOT NULL,
	Beneficio_total INT NOT NULL
);
EOF
clear          
	echo "Producto"       
	read Producto
        echo "Cantidad_vendida"
        read Cantidad_vendida
	echo "Beneficio"
	read Beneficio
	echo "Beneficio_total"
	read Beneficio_total

	sqlite3  $Fecha.db << EOF 
	INSERT INTO Ventas (Producto, Cantidad_vendida, Beneficio, Beneficio_total) VALUES ('$Producto', $Cantidad_vendida, $Beneficio, $Beneficio_total);

EOF

echo -e "\nLos datos se agregaron correctamente"
read -p "Selecciona < 1 > para volver al menu Configuracuon" optionss
case $optionss in
	"1") Configuracion ;;
esac
						
}

function ctrl_c () {       
	echo -e "\n${ColorTurquesa} [!] Saliendo ......\n${FinColor}"   
	tput cnorm;exit      
}

trap ctrl_c INT

function PrecioBTC { 
	curl -s "$BTC" | html2text | grep -A 1 "Bitcoin (BTC / MXN)"
        read -p "Selecciona < 1 > para volver al menu: " opt    
	case $opt in    
		"1") Main ;;    
	esac
}

function PaneldeAyuda {      
	echo -e "Usage: ./inventario.sh  [-o] [opciones]"   
	echo -e "opciones\n\t\tPrecio_BTC\n\t\tBienvenido\n\t\tConfiguracion\n\t\tMain"      
}

function Configuracion {
        clear
	for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done 
	echo -e "\n${ColorAmarillo}\n\t\t\tC O N F I G U R A C I O N\n${FinColor}"
        for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
	
        echo -e "\n${ColorRojo}\n\n\t1 ) Crear una nueva base de datos\n${FinColor}"
	echo -e "\n${ColorRojo}\n\n\t2 ) Modificar base de datos\n${FinColor}"
	echo -e "\n${ColorRojo}\n\n\t3 ) Menu principal\n\n\n${FinColor}"
	read -p "Has una eleccion: " opti
        case $opti in

                "1") nueva_base_de_datos ;;
                "2") Modificar_base_de_datos ;;
                "3") Main ;;
        esac
}
function nueva_base_de_datos {
        clear
        for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
         echo -e "\n${ColorAmarillo}\n\t\tN U E V A   B A S E   D E   D A T O S${FinColor}\n"
        for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
               #La siguiente linea de codigo crea la base de datos

        sqlite3 Inventario.db << EOF
CREATE TABLE IF NOT EXISTS Productos (
    Producto TEXT NOT NULL,
     Precio_unitario INT NOT NULL,
    Precio_publico  INT NOT NULL,
    Beneficio INT NOT NULL,
    Stock INT NOT NULL,
    Inversion INT NOT NULL

);
EOF

        echo -e "\n\n\t${ColorRojo}La base de datos fue creada con exito${FinColor}"
        read -p "Selecciona < 1 > para volver al menu: " opt
        case $opt in
                "1") Main ;;
        esac
}
function Modificar_base_de_datos {
	clear     
	for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done  
	 echo -e "\n${ColorAmarillo}\n\t\tM O D I F I C A R   B A S E   D E   D A T O S${FinColor}\n"
        for i in $(seq 1 150); do echo -ne "${ColorVerde}=${FinColor}" ; done
	echo -e "\n\n\t${ColorRojo}Selecciona < 1 > para volver a Configuracion o < 2 > para agregar productos a la base de datos ${FinColor}"
	read -p "Has una eleccion: " option     
	case $option in
		"1") Configuracion;;
		"2") Agregar_producto ;;
	esac
}
function Agregar_producto {
	clear
	echo "Producto:"
	read Producto
	echo "Precio unitario:"
	read Precio_unitario
	echo "Precio al publico:"
	read Precio_publico
	echo "Beneficio:"
	read Beneficio
	echo "Stock:"
	read Stock
	echo "Inversion:"
	read Inversion

	sqlite3 Inventario.db << EOF
	INSERT INTO Productos(Producto, Precio_Unitario, Precio_publico, Beneficio, Stock, Inversion) VALUES ('$Producto', $Precio_unitario, $Precio_publico, $Beneficio, $Stock, $Inversion 
	);

EOF
	echo -e "Los datos se agregaron correctamente"
	read -p "Selecciona < 1 > para volver al menu Configuracion: " options
	case $options in
		"1") Configuracion ;;
	esac
}

parameter_counter=0;while getopts ":o:h" arg;
do
	case $arg in                  
		o) exploration_mode=$OPTARG; let parameter_counter+=1;;
		h) ;;
	esac     
done


if [ $parameter_counter -eq 0 ]; then
	PaneldeAyuda
elif [ "$(echo $exploration_mode)" == "Bienvenido" ]; then
                Bienvenido
elif [ "$(echo $exploration_mode)" == "Configuracion" ]; then
		Configuracion
elif [ "$(echo $exploration_mode)" == "Main" ]; then
		Main
else
	if [ "$(echo $exploration_mode)" == "Precio_BTC" ]; then
		PrecioBTC
	fi
fi

function ctrl_c () {
	echo -e "\n${ColorTurquesa} [!] Saliendo ......\n${FinColor}"
	tput cnorm;exit 
}



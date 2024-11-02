docker build -f dockerfile -t iminideb5 .  
docker run -d -p 8130:80 -p 2202:22 --name cminideb5 iminideb5

http://172.25.80.1:8130/
https://github.com/SrEstrada/Expresiones_Regulares.git
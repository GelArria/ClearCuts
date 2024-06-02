import 'dotenv/config';
import {UnauthorizedError} from '../model/errors/UnauthorizedError.js';
import { FtpConnection } from '../../node_modules/ftp-srv/ftp-srv.js';
import FtpSrv from 'ftp-srv';

function iniciarServidorFTP(){
    // Crear el servidor FTP
    const ftpServer = new FtpSrv({
        url: `ftp://0.0.0.0:${process.env.PORT_FTP}`, // FTP server address
        pasv_url: '0.0.0.0', // Passive mode IP address
        pasv_min: 1025,
        pasv_max: 1040, // Passive mode port range
        greeting: 'Bienvenido al servidor ftp de la aplicación', // Welcome message
        whitelist: ['GET', 'PASS', 'PUT', 'TYPE', 'USER', 'QUIT'], // FTP commands allowed
    });


    // Manejador de conexiones de los clientes
    ftpServer.on('login', (data:{connection:FtpConnection, username:string, password:string}, resolve:Function, reject:Function) => {
        if(data.username === process.env.FTP_USER && data.password === process.env.SERVER_PASSWORD){
            resolve({ root: process.env.FTP_FOLDER }); // Carpeta donde se puede acceder a través del servidor FTP
        }
        return reject(new UnauthorizedError('Usuario o contraseña no válidos', 401));
    });

    // Ejecución del servidor FTP
    ftpServer.listen()
    .then(() => console.log('Ejecutando servidor FTP'))
    .catch((err:Error) => console.error('Error al iniciar el servidor FTP:', err));
}

export {iniciarServidorFTP};
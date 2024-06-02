import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import {router} from './routes/prueba.js';
import "dotenv/config"
import { Video } from './model/Video.js';
import { VideoError } from './model/errors/VideoError.js';

import { iniciarServidorFTP } from './datos/ftpServer.js';

const app = express();

const corsOption = {
    origin: '*',
    credentials: true,
    optionSuccessStatus: 200
}

//  Configuración del servidor 

app.use(morgan('combined'));
app.use(cors(corsOption));
app.use(express.text());
app.use(express.json());
app.use(express.urlencoded({extended: false}));


//  Rutas del servidor

app.use("/", router);

//  Servidor encendido
const port = process.env.PORT_HTTP;
app.listen(port);
console.log(`Server on port ${port}`);

iniciarServidorFTP();

async function prueba(){
    try {
        let video = new Video('Video', 'mp4');
        await video.setFrameRate();
        await video.getFrames();
        await video.getAudio();
        await Video.createVideo(video);
    } catch (error: any) {
        console.log(error.message)
    }
}

prueba();


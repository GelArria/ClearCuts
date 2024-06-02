import Ffmpeg, { FfmpegCommand } from "fluent-ffmpeg";
import 'dotenv/config';
import fs from 'fs';
import { VideoError } from "./errors/VideoError.js";
import { VideoNotExistsError } from "./errors/VideoNotExistsError.js";
import { exec } from "child_process";

const BASE_URI = process.env.VIDEOS_FOLDER;

export class Video{

    private name:string;
    private format:string;
    private frameRate:number;

    constructor(name: string, format: string){

        this.name = name;
        this.format = format;
        this.frameRate = 0;
    }

    getName(){
        return this.name;
    }

    getFormat(){
        return this.format;
    }

    getFrameRate(){
        return this.frameRate;
    }

    public async setFrameRate(){
        let path = `${BASE_URI}/${this.name}.${this.format}`;
        if (!fs.existsSync(path)) {
            throw new VideoNotExistsError('El video no existe');
        }
        let command = Ffmpeg(fs.createReadStream(path));
        this.frameRate = await this.calcularFPS(command);
    }

    private async calcularFPS(command:FfmpegCommand): Promise<number> {
        return new Promise((resolve, reject) => {
            command.ffprobe((err, data) => {
                if (err) {
                    reject(new VideoError('Error al obtener información del video'));
                }
                console.log(data);
                let result = data.streams[0].avg_frame_rate?.split('/');
                let numerator = result !== undefined ? parseInt(result[0]) : 0;
                let denominator = result !== undefined ? parseInt(result[1]) : 1;
                let calc = ~~(numerator / denominator);
                console.log(calc !== undefined ? `El video tiene ${calc} fps` : 'No se pudo obtener el frame rate del video');
                resolve(calc);
            });
        });
    }

    public async getFrames(){
        let outputDir = `${BASE_URI}/${this.name}`;
        fs.mkdirSync(outputDir, {recursive: true});

        if (this.frameRate === undefined) {
            await this.setFrameRate();
        }

        // const command = `ffmpeg -i ${BASE_URI}/${this.name}.${this.format} -vf fps=${this.frameRate} ${outputDir}/frame-%03d.png`;

        // console.log(command)

        // exec(command, (error, stdout, stderr) => {
        //     if (error) {
        //         console.error(`error: ${error.message}`);
        //         return;
        //     }
        //     if (stderr) {
        //         console.error(`stderr: ${stderr}`);
        //         return;
        //     }
        //     console.log(`stdout: ${stdout}`);
        // });

        

        let command = Ffmpeg(`${BASE_URI}/${this.name}.${this.format}`);
        return new Promise<void>((resolve, reject) => { // Devolvemos una promesa
            command.outputOptions(['-vf', `fps=${this.frameRate}`])
                .output(`${outputDir}/frame-%03d.png`)
                .videoFilters(`fps=${this.frameRate}`)
                .on('error', (err, stdout, stderr) => {
                    console.error('Error occurred:', err.message);
                    console.log('ffmpeg standard output:\n', stdout);
                    console.log('ffmpeg standard error:\n', stderr);
                    reject(err); // Rechazamos la promesa en caso de error
                })
                .on('end', () => {
                    console.log('Processing finished !');
                    resolve(); // Resolvemos la promesa cuando termina
                })
                .run();
        });
    }

    public async getAudio(){
        let outputDir = `${BASE_URI}/${this.name}`;
        fs.mkdirSync(outputDir, {recursive: true});

        if (this.frameRate === undefined) {
            await this.setFrameRate();
        }

        let command = Ffmpeg(`${BASE_URI}/${this.name}.${this.format}`);
        return new Promise<void>((resolve, reject) => { // Devolvemos una promesa
            command.outputOptions('-vn', '-acodec', 'copy')
                .output(`${outputDir}/${this.name}.aac`)
                .on('error', (err, stdout, stderr) => {
                    console.error('Error occurred:', err.message);
                    console.log('ffmpeg standard output:\n', stdout);
                    console.log('ffmpeg standard error:\n', stderr);
                    reject(err); // Rechazamos la promesa en caso de error
                })
                .on('end', () => {
                    console.log('Processing finished !');
                    resolve(); // Resolvemos la promesa cuando termina
                })
                .run();
        });
    }

    public static async createVideo(video:Video){

        await Ffmpeg()
          .input(`${BASE_URI}/${video.getName()}/frame-%03d.png`)
          .inputFPS(video.getFrameRate())
          .videoCodec('libx264')
          .input(`${BASE_URI}/${video.getName()}/${video.getName()}.aac`)
          .audioCodec('aac')
          .output(`${BASE_URI}/${video.getName()}/output.mp4`)
          .run();
        
    }

}